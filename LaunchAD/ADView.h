//
//  ADView.h
//  LaunchAD
//
//  Created by xiongoahc on 16/9/12.
//  Copyright © 2016年 xiongoahc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define UserDefaults [NSUserDefaults standardUserDefaults]
static NSString *const adImageName = @"adImageName";
static NSString *const adUrl = @"adUrl";

@interface ADView : UIView

/** 倒计时（默认3秒） */
@property (nonatomic,assign) NSUInteger showTime;

/** 初始化方法*/
- (instancetype)initWithFrame:(CGRect)frame imgUrl:(NSString *)img adUrl:(NSString *)ad clickImg:(void(^)(NSString *clikImgUrl))block;

/** 显示广告页面方法*/
- (void)show;

@end
