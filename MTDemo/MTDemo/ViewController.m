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
//    [self insertSeperateToString:string];
    
    //排序
    // 1、快速排序
    NSArray * array = [NSArray arrayWithObjects:@7,@1,@14,@8,@88,@9,@67,@34,@9,@77,@4, nil];
    [self quickSort:array];
    // 2、冒泡排序
    
    //
}

#pragma mark - 快速排序--时间复杂度---空间复杂度
-(void)quickSort:(NSArray *)array{
    
    NSMutableArray * resultArray = [array mutableCopy];
    NSLog(@"原始待排序的数组-resultArray:%@",resultArray);
    NSInteger indexTrail = resultArray.count-1;
    NSInteger indexHead = 1;
    NSInteger tmp = 0;//基准的位置
    NSInteger tmpValue = [resultArray[tmp] integerValue];//基准的值
    //边界值处理
    if (indexTrail==indexHead&&tmpValue>[resultArray[indexHead] integerValue]) {
        [resultArray replaceObjectAtIndex:tmp withObject:resultArray[indexHead]];
        tmp=indexHead;
    }
    while (indexTrail>indexHead) {
        //一次排序还没有进行完
        //从后
        while ([resultArray[indexTrail] integerValue]>=tmpValue&&indexTrail>indexHead) {
            indexTrail--;
        }
        if (indexHead<indexTrail) {
            //三个方法都可行，那三个方法有啥区别呢？
            //        resultArray[tmp] = resultArray[indexTrail];//可行
            //        [resultArray setObject:resultArray[indexTrail] atIndexedSubscript:tmp];//可行
            [resultArray replaceObjectAtIndex:tmp withObject:resultArray[indexTrail]];//可行
            tmp = indexTrail--;
            NSLog(@"%@",resultArray);
        }
    
        //从前
        while ([resultArray[indexHead] integerValue]<=tmpValue&&indexTrail>indexHead) {
            indexHead++;
        }
        
        if (indexHead<indexTrail) {
            [resultArray replaceObjectAtIndex:tmp withObject:resultArray[indexHead]];
            tmp = indexHead++;
            NSLog(@"%@",resultArray);
        }
    }
//    indexTrail==indexHead
//将基准放置合适的位置完成一次快排
    [resultArray replaceObjectAtIndex:tmp withObject:@(tmpValue)];
    NSLog(@"完成一次快排-resultArray：%@",resultArray);
    if (tmp>1) {
        //对左边进行快排
        [self quickSort:[resultArray subarrayWithRange:NSMakeRange(0, tmp)]];
    }
    if(resultArray.count-tmp>1){
    //对右边进行快排
        [self quickSort:[resultArray subarrayWithRange:NSMakeRange(tmp+1, resultArray.count-tmp-1)]];
    }
}

#pragma mark - 对String进行插入分隔符
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
