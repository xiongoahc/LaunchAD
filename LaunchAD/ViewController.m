//
//  ViewController.m
//  LaunchAD
//
//  Created by 熊超 on 16/9/12.
//  Copyright © 2016年 xiongchao. All rights reserved.
//

#import "ViewController.h"
#import "ADView.h"
#import "ADViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"首页";
    
    //    NSString *imageUrl =  @"http://img4q.duitang.com/uploads/item/201408/18/20140818140642_yQZwB.jpeg";
    //    NSString *imageUrl = @"http://imgsrc.baidu.com/forum/pic/item/9213b07eca80653846dc8fab97dda144ad348257.jpg";
    //    NSString *imageUrl = @"http://www.mangowed.com/uploads/allimg/130410/1-130410215449417.jpg";
    //       NSString *imageUrl = @"http://img5.pcpop.com/ArticleImages/picshow/0x0/20110801/2011080114495843125.jpg";
    
    
//      NSString *imageUrl = @"http://img5.duitang.com/uploads/item/201501/05/20150105184318_w8HPK.jpeg";
//      NSString *adURL = @"http://www.jianshu.com";
    
    NSString *imageUrl = @"http://img5q.duitang.com/uploads/item/201505/25/20150525223238_NdQrh.thumb.700_0.png";
    NSString *adURL = @"http://tieba.baidu.com/";
    
    //1、创建广告
    ADView *adView = [[ADView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds andImgUrl:imageUrl andADUrl:adURL andClickBlock:^(NSString *clikImgUrl) {
        
        NSLog(@"进入广告:%@",clikImgUrl);
        ADViewController *adVc = [[ADViewController alloc] init];
        adVc.adUrl = clikImgUrl;
        [self.navigationController pushViewController:adVc animated:YES];
    }];
    //设置倒计时（默认3秒）
    adView.showTime = 5;
    
    //2、显示广告
    [adView show];
    

}


@end
