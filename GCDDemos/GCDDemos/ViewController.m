//
//  ViewController.m
//  GCDDemos
//
//  Created by 乔丹丹 on 2016/12/20.
//  Copyright © 2016年 Fang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,assign)NSInteger sum;
@property(nonatomic,strong)UILabel * sumLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createLabel];
    self.title = @"GCDDemos";
    
    //1.提交 Job
                                            //优先级为Default
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //global_queue会在轮到这个block执行时执行这里的代码
        [self goDoSomethingLongAndInvolved];
        NSLog(@"Done doing something long and involved");
    });
    //dispatch_async 函数会立即返回, block会在后台异步执行。所以后面的代码跟block里面的代码的执行顺序不确定
    NSLog(@"dispatch_async后面的任务");
    
    
    //2.使用嵌套的dispatch，异步抛任务给后台执行，后台异步执行完任务之后，dispatch回到main queue，执行更新UI
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //异步执行操作序列
        [self goDoSomethingLongAndInvolved];
        
        //异步执行完任务之后需要回到main_queue做UI页面更新等等
        dispatch_async(dispatch_get_main_queue(), ^{
            //
            [self.sumLabel setText:[NSString stringWithFormat:@"%ld",self.sum]];
        });
    });
    
    
    
    
}
#pragma mark - createLabel
-(void)createLabel{
    _sumLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, [UIScreen mainScreen].bounds.size.width, 50)];
    [_sumLabel setText:@"0"];
    [self.view addSubview:_sumLabel];
}
#pragma mark - 适合异步抛给后台做的事情
-(void)goDoSomethingLongAndInvolved{
    NSInteger  sum = 0;
    for (int i = 0; i<50000; i++) {
        sum = sum + i;
    }
    
    //3.dispatch_sync同步操作  将同步操作放在异步抛给后台执行的代码中，就可以，先等这个同步操作执行完之后，再接着进行下面的异步操作序列
    __block NSString *stringValue;
    dispatch_sync(dispatch_get_main_queue(), ^{
        //获取主线程里的UI中的Label的值，累加上Label的值
        stringValue = self.sumLabel.text;
        NSLog(@"实现累加上次结果的功能");
    });
    //这个实现有阻塞了后台的线程
    sum = sum + stringValue.integerValue;
    self.sum = sum;
}
/*
 用嵌套的block来中止后台线程，然后从主线程中获取值，然后再将后期处理提交至后台线程：
 dispatch_queue_t bgQueue = myQueue;
 dispatch_async(dispatch_get_main_queue(), ^{
 NSString *stringValue = sumLabel.text;
 dispatch_async(bgQueue, ^{
 // use stringValue in the background now
 });
 });
 取决于你的需求，myQueue可以是用户队列也可以使全局队列。

 */

//4.用同步异步队列来代替锁的功能
/*
 - (id)something
 {
 __block id localSomething;
 dispatch_sync(queue, ^{
 localSomething = [something retain];
 });
 return [localSomething autorelease];
 }
 
 - (void)setSomething:(id)newSomething
 {
 dispatch_async(queue, ^{
 if(newSomething != something)
 {
 [something release];
 something = [newSomething retain];
 [self updateSomethingCaches];
 }
 });
 }
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
