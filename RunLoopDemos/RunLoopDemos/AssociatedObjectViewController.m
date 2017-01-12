//
//  AssociatedObjectViewController.m
//  RunLoopDemos
//
//  Created by 乔丹丹 on 2017/1/12.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "AssociatedObjectViewController.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "NSObject+DDCategory.h"

#ifndef __OPTIMIZE__

#define NSLog(...) printf("%f %s %ld :%s\n",[[NSDate date]timeIntervalSince1970],strrchr(__FILE__,'/'),[[NSNumber numberWithInt:__LINE__] integerValue],[[NSString stringWithFormat:__VA_ARGS__]UTF8String]);

#endif

@interface AssociatedObjectViewController ()
@property (nonatomic, assign) BOOL disabledDD;
@end

@implementation AssociatedObjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"AssociatedObject Demo";
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(100, 100, 100, 50)];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    NSObject * objInstance = [[NSObject alloc] init];
    objInstance.nameStr = @"qiao";
    NSLog(@"----%@",[objInstance nameStr]);
    NSLog(@"----为啥没有出来？？？？？？？？");
    //NSLog 为什么会失效？？换成了c的printf才打印出来？？需要找到原因。。。。
    //(lldb) po objInstance.nameStr
    //error: property 'nameStr' not found on object of type 'NSObject *'
    //(lldb) po [objInstance nameStr]
    //qiao
    //(lldb) po _nameStr
    //error: use of undeclared identifier '_nameStr'
}

-(void)click:(UIButton *)button{
    NSLog(@"button 点击了");
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
