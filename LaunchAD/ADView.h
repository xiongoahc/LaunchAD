//
//  ADView.h
//  LaunchAD
//
//  Created by 熊超 on 16/9/12.
//  Copyright © 2016年 xiongchao. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define UserDefaults [NSUserDefaults standardUserDefaults]
static NSString *const adImageName = @"adImageName";
static NSString *const adUrl = @"adUrl";

@interface ADView : UIView

/** 倒计时（默认3秒） */
@property (nonatomic,assign) NSUInteger showTime;

/** 初始化方法*/
-(instancetype)initWithFrame:(CGRect)frame andImgUrl:(NSString *)imageUrl andADUrl:(NSString *)adUrl andClickBlock:(void(^)(NSString *clikImgUrl))block;

/** 显示广告页面方法*/
- (void)show;

@end
