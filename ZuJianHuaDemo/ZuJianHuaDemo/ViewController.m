//
//  ViewController.m
//  ZuJianHuaDemo
//
//  Created by 乔丹丹 on 2017/2/21.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "ViewController.h"
//#import "ComponentOneViewController.h"
//#import "ComponentTwoViewController.h"
#import "Mediator.h"
#import "MediatorTwo.h"

@interface ViewController ()
@property(nonatomic,strong)NSString * someId;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"两种 组件化Demos";
    self.someId = @"110";
    //我有一个疑问：组件化的粒度大小是多少？一个功能模块？一个功能模块里面的东西是紧密耦合的，模块对外的接口（入口，出口）采用的是组件之间的处理？
    
}

#pragma mark - 第二种组件化的方案 注册表的方式 用URL表示接口
//需要事先注册好，才能正常执行
//蘑菇街用的解决方式：注册表的方式，用URL表示接口，在模块启动时注册模块提供的接口
+ (void)gotoThree:(NSString *)someId {
    [[MediatorTwo sharedInstance] openURL:@"weread://bookDetail" withParam:@{@"someId": someId}];
}

//测试代码
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[self class] gotoThree:self.someId];
}


#pragma mark - 第一种组件化的方案
////测试代码
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    //    [self gotoOne];
//    [self gotoTwo];
//}

//跳转到组件1
-(void)gotoOne{
//    ComponentOneViewController * vcOne = [[ComponentOneViewController alloc] initWithId:self.someId];
//    [self.navigationController pushViewController:vcOne animated:YES];
    //解除了各个组件之间的依赖 组件只依赖Mediator
    UIViewController * vcOne = [Mediator ComponentOneViewController:self.someId];
    [self.navigationController pushViewController:vcOne animated:YES];
}

//跳转到组件2
-(void)gotoTwo{
//    ComponentTwoViewController * vcTwo = [[ComponentTwoViewController alloc] initWithId:self.someId andType:1];
//    [self.navigationController pushViewController:vcTwo animated:YES];
    //解除了各个组件之间的依赖 组件只依赖Mediator
        UIViewController * vcTwo = [Mediator ComponentTwoViewController:self.someId andType:1];
    [self.navigationController pushViewController:vcTwo animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
