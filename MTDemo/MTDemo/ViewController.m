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
//    [self quickSort:array];
    // 2、选择排序
//    [self bubbleSort:array];
    
}

#pragma mark - 选择排序-------时间复杂度o(n²)----------空间复杂度o(n)
-(void)bubbleSort:(NSArray *)array{
    NSMutableArray * operateArray = [array mutableCopy];
    NSLog(@"原始数组：%@",operateArray);
    for (NSInteger i = 0; i<operateArray.count; i++) {
        
        NSInteger  minIndex = i;
        for (NSInteger j = i; j<operateArray.count; j++) {
            //找到最小的
            if ([operateArray[j] integerValue] < [operateArray[minIndex] integerValue]) {
                minIndex = j;
            }
            
        }
        NSInteger tmpValue = [operateArray[i] integerValue];
        [operateArray replaceObjectAtIndex:i withObject:operateArray[minIndex]];
        [operateArray replaceObjectAtIndex:minIndex withObject:@(tmpValue)];
        NSLog(@"一次选择-array:%@",operateArray);
    }
    NSLog(@"选择排序结束：%@",operateArray);
}

#pragma mark - 快速排序-----时间复杂度(o(logN))---空间复杂度o(n)---初始版本，写的不好，应该是在同一个NSMutableArray中进行操作，不能开辟这个多resultArray
-(void)quickSort:(NSArray *)array{
    
    NSMutableArray * resultArray = [array mutableCopy];
    NSLog(@"原始待排序的数组-resultArray:%@",resultArray);
    [self quickSortWithArray:resultArray fromIndex:0 toIndex:resultArray.count-1];
}

#pragma mark - 对NSMutableArray实例对象从fromIndex to toIndex进行快排，这样的封装抽象，才是更好一点的
-(BOOL)quickSortWithArray:(NSMutableArray *)array fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex{

    NSInteger indexTrail = toIndex;
    NSInteger indexHead = fromIndex+1;
    NSInteger tmp = fromIndex;//基准的位置
    NSInteger tmpValue = [array[tmp] integerValue];//基准的值
    //边界值处理,只有两个元素
    if (indexTrail==indexHead) {
        if(tmpValue>[array[indexHead] integerValue]){
            [array replaceObjectAtIndex:tmp withObject:array[indexHead]];
            tmp=indexHead;
            [array replaceObjectAtIndex:tmp withObject:@(tmpValue)];
            NSLog(@"完成了快排%@",array);
        }
        return 1;
    }
    
    while (indexTrail>indexHead) {
        //一次排序还没有进行完
        //从后
        while ([array[indexTrail] integerValue]>=tmpValue&&indexTrail>indexHead) {
            indexTrail--;
        }
        if (indexHead<indexTrail) {
            //三个方法都可行，那三个方法有啥区别呢？
            //        resultArray[tmp] = resultArray[indexTrail];//可行
            //        [resultArray setObject:resultArray[indexTrail] atIndexedSubscript:tmp];//可行
            [array replaceObjectAtIndex:tmp withObject:array[indexTrail]];//可行
            tmp = indexTrail--;
            NSLog(@"%@",array);
        }
        
        //从前
        while ([array[indexHead] integerValue]<=tmpValue&&indexTrail>indexHead) {
            indexHead++;
        }
        
        if (indexHead<indexTrail) {
            [array replaceObjectAtIndex:tmp withObject:array[indexHead]];
            tmp = indexHead++;
            NSLog(@"%@",array);
        }
    }
    //将基准放置合适的位置完成一次快排
    [array replaceObjectAtIndex:tmp withObject:@(tmpValue)];
    NSLog(@"完成一次快排-resultArray：%@",array);
    if (tmp-fromIndex>1) {
        //对左边进行快排
        [self quickSortWithArray:array fromIndex:fromIndex toIndex:tmp-1];
    }
    if(toIndex-tmp>1){
        //对右边进行快排
        [self quickSortWithArray:array fromIndex:tmp+1 toIndex:toIndex];
    }
    return 1;
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
