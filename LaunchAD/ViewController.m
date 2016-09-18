//
//  ViewController.m
//  LaunchAD
//
//  Created by xiongoahc on 16/9/12.
//  Copyright © 2016年 xiongoahc. All rights reserved.
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
    
//      NSString *image = @"http://img5.duitang.com/uploads/item/201501/05/20150105184318_w8HPK.jpeg";
//      NSString *ad = @"http://www.jianshu.com";
    
    NSString *image = @"http://img5q.duitang.com/uploads/item/201505/25/20150525223238_NdQrh.thumb.700_0.png";
    NSString *ad = @"http://tieba.baidu.com/";
    
    //1、创建广告
    ADView *adView = [[ADView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds imgUrl:image adUrl:ad clickImg:^(NSString *clikImgUrl) {
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
