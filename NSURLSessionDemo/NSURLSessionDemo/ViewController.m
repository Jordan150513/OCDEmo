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
@property(nonatomic,strong)NSURLSessionDownloadTask * downloadTask;
@property(nonatomic,assign)BOOL isDownLoading;
@end

@implementation ViewController

static NSString * const urlString = @"http://119.254.98.136/api/v1/web/homepage";
//static const NSString * urlString = @"http://119.254.98.136/api/v1/web/homepage";
//这里有一个问题，const的位置不同，大不一样
//const的添加会造成什么样的不同，会出现警告：sending 'const NSString * __strong' to paramter of type 'NSString * __Nonnull' discards qualifiers
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"AFN & NSURLSession";
    
//    AFN一般的数据请求
//    [self requestAFN];
//    NSURLSession 一般的数据请求
//    [self request];
    
    //AFN的download数据请求
    [self requestDownLoadAFN];
    
    //NSURLSession的download数据请求
    
    //AFN的upload数据
    
    //NSURLSession的upload数据请求
}

#pragma mark - NSURLSession
#pragma mark 一般数据请求
-(void)request{
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDataTask * task = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSLog(@"--------------------------------");
    }];
    [task resume];
    

    //三种不同的session配置：
//    [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
//    [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"sessionIdentifier"]];
    //定制程度更高的NSURLSession创建方法
//    [NSURLSession sessionWithConfiguration:<#(nonnull NSURLSessionConfiguration *)#> delegate:<#(nullable id<NSURLSessionDelegate>)#> delegateQueue:<#(nullable NSOperationQueue *)#>]

}

#pragma mark 下载数据请求
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

#pragma mark 上传数据请求
-(void)requestUpLoad{

}

#pragma mark 断点续传
-(void)DDXCRequest{
    
    NSURLSession * session = [NSURLSession sharedSession];
    NSData * data = [NSData data];
    NSURLSessionDownloadTask * downloadTask = [session downloadTaskWithResumeData:data completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //
        NSString * path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"kkk.dmg"];
        NSURL * documentUrl = [NSURL fileURLWithPath:path];
        [[NSFileManager defaultManager] moveItemAtURL:location toURL:documentUrl error:nil];
    }];
    self.downloadTask = downloadTask;
    [downloadTask resume];

}

#pragma mark - AFN
#pragma mark 一般请求
-(void)requestAFN{
    
//    NSString * urlString= @"http://119.254.98.136/api/v1/web/homepage";
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

#pragma mark AFN 下载
-(void)requestDownLoadAFN{
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//    [manager downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
//        
//    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//        
//    }];
    
}

#pragma mark AFN 上传
-(void)requestUpLoadAFN{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//    manager upl
}
#pragma mark - AFN断点续传
-(void)DDXCAFNRequest{

    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
//    [manager downloadTaskWithResumeData:[NSData data] progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
//        
//    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//        
//    }];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //暂停下载
    [self.downloadTask cancel];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
