//
//  Mediator.m
//  ZuJianHuaDemo
//
//  Created by 乔丹丹 on 2017/2/21.
//  Copyright © 2017年 Fang. All rights reserved.
//

//组件化的中间控制器
#import "Mediator.h"
//#import "ComponentOneViewController.h"
//#import "ComponentTwoViewController.h"

@interface Mediator ()

@end

@implementation Mediator
+ (UIViewController *)ComponentOneViewController:(NSString *)someId {
//    return [ComponentOneViewController createComponentOneViewController:Id];
    //解除了Mediator对各个组件的依赖
    Class cls = NSClassFromString(@"ComponentOneViewController");
    return [cls performSelector:NSSelectorFromString(@"createComponentOneViewController:") withObject:@{@"someId":someId}];
    //在这里，传入的字典值不能为nil，someid为nil的时候会崩溃，是字典不能设置value为nil
}

+ (UIViewController *)ComponentTwoViewController:(NSString *)someId andType:(NSInteger)type {
//    return [ComponentTwoViewController createComponentTwoViewController:someId andType:type];
    Class cls = NSClassFromString(@"ComponentTwoViewController");
    return [cls performSelector:NSSelectorFromString(@"createComponentTwoViewController:andType:") withObject:@{@"someId":someId,@"type":@(type)}];
    //此处注意，多个参数的时候，方法的全名别写错了
}


@end
