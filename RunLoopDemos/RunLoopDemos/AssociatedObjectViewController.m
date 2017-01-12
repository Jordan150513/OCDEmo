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
#import "NSObject_DDNSObjectExtension.h"

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
    
    
//    NSLog(@"----%@",objInstance.nameStrExt);
    /*
     (lldb) po objInstance.nameStrExt
     error: property 'nameStrExt' not found on object of type 'NSObject *'
     (lldb) po [objInstance nameStrExt]
     error: Execution was interrupted, reason: Attempted to dereference an invalid ObjC Object or send it an unrecognized selector.
     The process has been returned to the state before expression evaluation.
     (lldb)
     */
    
}

-(void)click:(UIButton *)button{
    NSLog(@"button 点击了");
    
}

@end

//私有的扩展？？？为啥没有起作用呢？？？？私有到什么程度，只能自己扩展类内部访问？？
@interface NSObject ()
@property(nonatomic,strong) NSString * nameStrExtPrivate;
@end
