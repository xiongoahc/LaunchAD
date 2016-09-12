# LaunchAD
两行代码添加iOS应用启动广告的功能，代码可添加到任意地方，支持无网络显示，可点击进入广告页面。
![image](https://github.com/xiongoahc/LaunchAD/blob/master/LaunchAD/%E6%95%88%E6%9E%9C%E5%9B%BE.gif)   
使用方法：
在使用的地方添加如下代码

    NSString *imageUrl = @"http://img5q.duitang.com/uploads/item/201505/25/20150525223238_NdQrh.thumb.700_0.png";
    NSString *adURL = @"http://tieba.baidu.com/";
    
    //1、创建广告
    ADView *adView = [[ADView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds andImgUrl:imageUrl andADUrl:adURL andClickBlock:^(NSString *clikImgUrl) {
        
        NSLog(@"进入广告:%@",clikImgUrl);
    }];
    
    //2、显示广告
    [adView show];
