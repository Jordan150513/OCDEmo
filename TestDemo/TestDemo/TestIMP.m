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
    // 有参考这个block：http://blog.csdn.net/dp948080952/article/details/52437451
    // 1、class_getMethodImplementation（）方法获取IMP
    // 找实例方法
    IMP instanceIMP = class_getMethodImplementation(objc_getClass("TestIMP"), aSelector);
    
    //找的是类方法
    IMP classIMP = class_getMethodImplementation(objc_getMetaClass("TestIMP"), aSelector);
    
    // 2、method_getImplementation() 获取IMP
    // 1、找实例的方法IMP
    Method instanceMethod = class_getInstanceMethod(objc_getClass("TestIMP"), aSelector);
    IMP instanceIMP2 = method_getImplementation(instanceMethod);
    
    // 2、找类的方法IMP
    Method classMethod1 = class_getClassMethod(objc_getClass("TestIMP"), aSelector);
    IMP classIMP2 = method_getImplementation(classMethod1);
    
    // 3、找类的方法IMP 元类
    Method classMethod2 = class_getClassMethod(objc_getMetaClass("TestIMP"), aSelector);
    IMP classIMP3 = method_getImplementation(classMethod2);
    
    NSLog(@"instanceIMP:%p,instanceIMP2:%p,,classIMP:%p,classIMP2:%p,classIMP3:%p",instanceIMP,instanceIMP2,classIMP,classIMP2,classIMP3);
}

-(void)test1{
    NSLog(@"test1");
}

+(void)test2{
    NSLog(@"test2");
}


@end
