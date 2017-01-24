//
//  ViewController.m
//  MTDemo
//
//  Created by 乔丹丹 on 2017/1/24.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //对string插入分隔符号
    NSString * string = @"1234567890";
    [self insertSeperateToString:string];
    
    //排序
    // 1、快速排序
    
    // 2、冒泡排序
    
    //
}

-(void)insertSeperateToString:(NSString *)string{
//  NSString * string = @"1234567890";
    NSMutableString * resultString = [string mutableCopy];
    if (string.length>3) {
        //多余三位才进行分隔操作
        for (NSInteger index = resultString.length-3; index>0; index = index-3) {
            NSMutableString * headString = [[resultString substringToIndex:index] mutableCopy];
            NSLog(@"%@",headString);
            NSMutableString * trailString = [[resultString substringFromIndex:index] mutableCopy];
            NSLog(@"%@",trailString);
            
           headString =  [[headString stringByAppendingString:@","] mutableCopy];
           headString =  [[headString stringByAppendingString:trailString] mutableCopy];
           resultString = headString;
        NSLog(@"resultString-%ld-%@",index,resultString);
        }
    }
    
    //自己基础不扎实，这么简单的，短时间内就没有想清楚，写出来。希望自己引以为戒，好好学习
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
