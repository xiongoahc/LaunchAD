//
//  ADViewController.m
//  LaunchAD
//
//  Created by xiongoahc on 16/9/12.
//  Copyright © 2016年 xiongoahc. All rights reserved.
//

#import "ADViewController.h"

@interface ADViewController ()

@end

@implementation ADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"广告页面";
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.backgroundColor = [UIColor whiteColor];
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.adUrl]];
    [webView loadRequest:request];
    [self.view addSubview:webView];
}


@end
