//
//  TestIMP.m
//  TestDemo
//
//  Created by 乔丹丹 on 2017/3/15.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "TestIMP.h"
#import <objc/runtime.h>
//#import <objc/objc.h>
//#import <objc/message.h>


@implementation TestIMP
-(instancetype)init{
    self = [super init];
    if (self) {
        [self getIMPFromSelector:@selector(aaa)];
        [self getIMPFromSelector:@selector(test1)];
        [self getIMPFromSelector:@selector(test2)];
    }
    
    return self;
}

-(void)getIMPFromSelector:(SEL)aSelector{
    // 1、class_getMethodImplementation（）方法获取IMP
    // 找实例方法
    IMP instanceIMP = class_getMethodImplementation(objc_getClass("TestIMP"), aSelector);
    
    //找的是类方法
    IMP classIMP = class_getMethodImplementation(objc_getMetaClass("TestIMP"), aSelector);
    
    // 2、
    Method instanceMethod = class_getInstanceMethod(objc_getClass("TestIMP"), aSelector);
//    IMP
    
    Method classMethod = class_getClassMethod(objc_getMetaClass("TestIMP"), aSelector);
    
    
}

-(void)test1{
    NSLog(@"test1");
}

-(void)test2{
    NSLog(@"test2");
}


@end
