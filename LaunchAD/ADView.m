//
//  ADView.m
//  LaunchAD
//
//  Created by xiongoahc on 16/9/12.
//  Copyright © 2016年 xiongoahc. All rights reserved.
//

#import "ADView.h"

@interface ADView()

@property (nonatomic, strong) UIImageView *adView;

@property (nonatomic, strong) UIButton *countBtn;

@property (nonatomic, strong) NSTimer *countTimer;


@property (nonatomic, assign) NSUInteger count;

/** 广告图片本地路径 */
@property (nonatomic,copy) NSString *imgPath;

/** 新广告图片地址 */
@property (nonatomic,copy) NSString *imgUrl;

/** 新广告的链接 */
@property (nonatomic,copy) NSString *adUrl;

/** 所点击的广告链接 */
@property (nonatomic,copy) NSString *clickAdUrl;

/** 点击图片回调block */
@property (nonatomic,copy) void (^clickImg)(NSString *url);

@end

@implementation ADView

-(NSUInteger)showTime
{
    if (_showTime == 0)
    {
        _showTime = 3;
    }
    return _showTime;
}

- (NSTimer *)countTimer
{
    if (!_countTimer) {
        _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    return _countTimer;
}

/**
 *  初始化
 *
 *  @param frame    坐标
 *  @param imageUrl 图片地址
 *  @param adUrl    广告链接
 *  @param block    点击广告回调
 *
 *  @return self
 */
- (instancetype)initWithFrame:(CGRect)frame imgUrl:(NSString *)img adUrl:(NSString *)ad clickImg:(void(^)(NSString *clikImgUrl))block
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //给属性赋值
        _clickImg = block;
        _imgUrl = img;
        _adUrl = ad;
        
        //广告图片
        _adView = [[UIImageView alloc] initWithFrame:frame];
        _adView.userInteractionEnabled = YES;
        _adView.contentMode = UIViewContentModeScaleAspectFill;
        _adView.clipsToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToAd)];
        [_adView addGestureRecognizer:tap];
        
        //跳过按钮
        CGFloat btnW = 60;
        CGFloat btnH = 30;
        _countBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - btnW - 24, btnH, btnW, btnH)];
        [_countBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        _countBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_countBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _countBtn.backgroundColor = [UIColor colorWithRed:38 /255.0 green:38 /255.0 blue:38 /255.0 alpha:0.6];
        _countBtn.layer.cornerRadius = 4;
        
        [self addSubview:_adView];
        [self addSubview:_countBtn];
        
    }
    return self;
}


- (void)show
{
    //判断本地缓存广告是否存在，存在即显示
    if ([self imageExist]) {
        //设置按钮倒计时
        [_countBtn setTitle:[NSString stringWithFormat:@"跳过%zd", self.showTime] forState:UIControlStateNormal];
        //当前显示的广告图片
        _adView.image = [UIImage imageWithContentsOfFile:_imgPath];
        //当前显示的广告链接
        _clickAdUrl = [UserDefaults valueForKey:adUrl];
        //开启倒计时
        [self startTimer];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self];
    }
    //不管本地是否存在广告图片都获取最新图片
    [self setNewADImgUrl:_imgUrl];
}


//判断沙盒中是否存在广告图片，如果存在，直接显示
- (BOOL)imageExist
{
    _imgPath = [self getFilePathWithImageName:[UserDefaults valueForKey:adImageName]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [fileManager fileExistsAtPath:_imgPath];
    return isExist;
}


//跳转到广告页面
- (void)pushToAd{
    if (_clickAdUrl)
    {
        //把所点击的广告链接回调出去
        _clickImg(_clickAdUrl);
        [self dismiss];
    }
    
}

//跳过
- (void)countDown
{
    _count --;
    [_countBtn setTitle:[NSString stringWithFormat:@"跳过%zd",_count] forState:UIControlStateNormal];
    if (_count == 0) {
        
        [self dismiss];
    }
}


// 定时器倒计时
- (void)startTimer
{
    _count = self.showTime;
    [[NSRunLoop mainRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
}


// 移除广告页面
- (void)dismiss
{
    [self.countTimer invalidate];
    self.countTimer = nil;
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
    
}

//获取最新广告
- (void)setNewADImgUrl:(NSString *)imgUrl
{
    //获取图片名字（***.png）
    NSString *imgName = [imgUrl lastPathComponent];
    //拼接沙盒路径
    NSString *filePath = [self getFilePathWithImageName:imgName];
    //判断路径是否存在
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [fileManager fileExistsAtPath:filePath];
    if (!isExist){// 如果本地没有该图片，下载新图片保存，并且删除旧图片
        [self downloadAdImageWithUrl:imgUrl imageName:imgName];
    }
}

/**
 *  下载新图片(这里也可以自己使用SDWebImage来下载图片)
 */
- (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];
        
        NSString *filePath = [self getFilePathWithImageName:imageName];
        if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {// 保存成功
            NSLog(@"保存成功");
            //删除旧广告图片
            [self deleteOldImage];
            //设置新图片
            [UserDefaults setValue:imageName forKey:adImageName];
            //设置广告链接
            [UserDefaults setValue:_adUrl forKey:adUrl];
            [UserDefaults synchronize];
        }else{
            NSLog(@"保存失败");
        }
        
    });
}


/**
 *  根据图片名拼接文件路径
 */
- (NSString *)getFilePathWithImageName:(NSString *)imageName
{

    if (imageName) {
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) firstObject];
        NSString *imgPath =[cachesPath stringByAppendingPathComponent:imageName];
        return imgPath;
    }
    return nil;
}


/**
 *  删除旧图片
 */
- (void)deleteOldImage
{
    NSString *imageName = [UserDefaults valueForKey:adImageName];
    if (imageName) {
        NSString *imgPath = [self getFilePathWithImageName:imageName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:imgPath error:nil];
    }
}

@end
