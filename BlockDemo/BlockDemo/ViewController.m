//
//  ViewController.m
//  BlockDemo
//
//  Created by 乔丹丹 on 2017/3/17.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Block Demo";
    
    __block int a = 0;
    NSLog(@"定义前：%p", &a);         //栈区
    void (^foo)(void) = ^{
        a = 1;
        NSLog(@"block内部：%p", &a);    //堆区
    };
    NSLog(@"定义后：%p", &a);         //堆区
    foo();
    
}

/*
 定义前：0x16fd01eb8 栈区
 定义后：0x1740334f8 堆区
 block内部：0x1740334f8 堆区
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
