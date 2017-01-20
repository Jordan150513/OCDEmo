//
//  ViewController.m
//  NSURLSessionDemo
//
//  Created by 乔丹丹 on 2017/1/20.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "Masonry.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"AFN & NSURLSession";
    
    [self requestAFN];
}

#pragma mark - NSURLSession
-(void)request{
    NSURLSession * session = [NSURLSession sharedSession];
    //三种不同的session配置：
//    [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
//    [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"sessionIdentifier"]];
    //定制程度更高的NSURLSession创建方法
//    [NSURLSession sessionWithConfiguration:<#(nonnull NSURLSessionConfiguration *)#> delegate:<#(nullable id<NSURLSessionDelegate>)#> delegateQueue:<#(nullable NSOperationQueue *)#>]

}

-(void)requestDownLoad{
    
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask * task = [session downloadTaskWithURL:[NSURL URLWithString:@"http://127.0.0.1/dawenjian.zip"] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString * path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"kkk.dmg"];
        NSURL * documentUrl = [NSURL fileURLWithPath:path];
        [[NSFileManager defaultManager] moveItemAtURL:location toURL:documentUrl error:nil];
    }];
    //新建的task默认是挂起状态，需要resume才可以开始执行
    [task resume];
}

-(void)requestUpLoad{

}

#pragma mark - AFN
-(void)requestAFN{
    
    NSString * urlString= @"http://119.254.98.136/api/v1/web/homepage";
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"AFN请求成功");
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"AFN请求失败");
    }];
    
//    AFHTTPSessionManager是AFURLSessionManager的子类
    AFURLSessionManager * urlSessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    /*
     NSURLSession的NSURLSessionConfiguration有三种
     defaultSessionConfiguration ：
     默认的，cache，证书和会话session cookie都保存在磁盘中
     ephemeralSessionConfiguration ：
     瞬息的暂时的无痕浏览，cache，证书和会话session cookie保存在内存中，其他的在硬盘中
     backgroundSessionConfigurationWithIdentifier  :
     程序退到后台，下载或者上传也会停止，但是当程序启动的时候，会接着进行数据请求，需要唯一标识程序的Identifier
     */
    
    
}

-(void)requestDownLoadAFN{
    
}

-(void)requestUpLoadAFN{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
