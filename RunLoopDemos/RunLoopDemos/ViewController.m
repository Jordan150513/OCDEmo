//
//  ViewController.m
//  RunLoopDemos
//
//  Created by 乔丹丹 on 2016/12/26.
//  Copyright © 2016年 Fang. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "AFNetworking.h"
#import "AssociatedObjectViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"RunLoopDemos";
    
    
    NSString * requestURL = @"http://119.254.98.136/api/v1/web/homepage";
    
    NSMutableArray * arr = [NSMutableArray array];
    NSString * nilStr = nil;
//    [arr addObject:nilStr];
    //往数组中添加nil，会引起崩溃，项目中需要容错
    
    
//    AFHTTPSessionManager * manager =[[AFHTTPSessionManager alloc] init];
    AFHTTPSessionManager * manager =[AFHTTPSessionManager manager];
    [manager GET:requestURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSLog(@"请求成功了！");
        AssociatedObjectViewController * vc = [[AssociatedObjectViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败了！");

    }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
