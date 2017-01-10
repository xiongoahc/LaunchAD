# LaunchAD
两行代码添加iOS应用启动广告的功能，支持无网络显示，可点击进入广告页面。

广告思路：第一次进入app时没有广告（因为广告的加载最好是从本地缓存获取，如果每次都从网络获取有可能因网速原因加载失败）。第一次启动的同时，根据后台返回的数据加载广告（一般是图片地址和广告链接），然后保存在本地。第二次启动的时候本地存在了广告，这个时候就可以显示了。然后请求最新的广告数据，如果和旧广告一样则不做操作；如果有新广告，则删除本地的旧广告，保存新广告，下次启动再显示。

![image](https://github.com/xiongoahc/LaunchAD/blob/master/LaunchAD/%E6%95%88%E6%9E%9C%E5%9B%BE.gif)   
使用方法：
在使用的地方导入头文件ADView.h之后，添加如下代码

    NSString *imageUrl = @"http://img5q.duitang.com/uploads/item/201505/25/20150525223238_NdQrh.thumb.700_0.png";
    NSString *adURL = @"http://tieba.baidu.com/";
    
    //1、创建广告
    ADView *adView = [[ADView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds andImgUrl:imageUrl andADUrl:adURL andClickBlock:^(NSString *clikImgUrl) {
        
        NSLog(@"进入广告:%@",clikImgUrl);
    }];
    
    //2、显示广告
    [adView show];
