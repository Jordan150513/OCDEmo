//
//  DemoTwoViewController.m
//  GCDDemos
//
//  Created by 乔丹丹 on 2016/12/20.
//  Copyright © 2016年 Fang. All rights reserved.
//

#import "DemoTwoViewController.h"

@interface DemoTwoViewController ()

@end

@implementation DemoTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"GCDDemo 2";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    NSMutableArray * array = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7", nil];
    
    //1、不用异步执行
    for ( NSMutableString * numberString in array) {
        //需要在枚举中修改枚举中的对象的值
         NSLog(@"%@",numberString);
//        [numberString replaceCharactersInRange:NSMakeRange(0, numberString.length) withString:[NSString stringWithFormat:@"%ld",[numberString integerValue]+10]];
// for in 循环里，对这个数组进行了修改的话，无论是增，删，修改数组元素位置，都会扔一个异常出来，枚举的过程中数组发生了突变
    }
    NSLog(@"end");
    
    //第一种：
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj);
    }];
    
    //第二种：
    //    (NSEnumerationOptions)
    //    NSEnumerationConcurrent = (1UL << 0),
    //NSEnumerationReverse = (1UL << 1),
    [array enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj);
    }];
    
    
    [array enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj);
    }];
    
//    //第三种：
//    [array enumerateObjectsAtIndexes:(nonnull NSIndexSet *) options:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSLog(@"%@",obj);
//    }];
//    
    
    
//    //2、采用异步执行
//    dispatch_queue_t  queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//
//    for (NSString * numberStr in array) {
//        dispatch_async(queue, ^{
//            NSLog(@"%@",numberStr);
//        });
//    }
//    NSLog(@"end");
//    //这句话会被打印出来，对数组的操作抛到了后台执行，dispatch_async会立即返回，执行end输出
//    
//    //3、Dispatch group
//    dispatch_group_t group = dispatch_group_create();
//    for (NSString * numberStr in array) {
//        dispatch_group_async(group, queue, ^{
//            NSLog(@"%@",numberStr);
//        });
//    }
//    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
//    //等待group执行完之后，再继续执行下面的代码语句
//    NSLog(@"end");
//
//    //4、dispatch_group_notify
//    //若后续对数组的处理也是异步的,可以用dispatch_group_notify
//    for (NSString * numberStr in array) {
//        dispatch_group_async(group, queue, ^{
//            NSLog(@"%@",numberStr);
//        });
//    }
//    dispatch_group_notify(group, queue, ^{
//        NSLog(@"%@",array);
//    });
//    NSLog(@"end");
//
//    //5、dispatch_apply
//    dispatch_async(queue, ^{
//        dispatch_apply([array count], queue, ^(size_t index) {
//            NSLog(@"%@",array[index]);
//        });
//        NSLog(@"%@",array);
//    });
//    NSLog(@"end");
//    //dispatch_async会立即返回，抛给后台异步执行，所以会立即执行输出end
//    //该函数按指定的次数将指定的Block追加到指定的Dispatch Queue中，指定的次数的Block将会被异步执行，
//    //dispatch_apply函数会等待全部处理执行结束，接着进行后面的代码序列,所以，完整输出array在单一输出结束之后
//
//    //5、dispatch_apply的理解
//    dispatch_apply(10, queue, ^(size_t index){
//        NSLog(@"%zu", index);
//    });
//    NSLog(@"done");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
