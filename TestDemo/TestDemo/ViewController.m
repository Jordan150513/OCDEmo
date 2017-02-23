//
//  ViewController.m
//  TestDemo
//
//  Created by 乔丹丹 on 2017/2/23.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test];
}

#pragma mark -test 1、 objc_selector 的本质是一个char * 字符串

// objc_selector 的定义在源码中并没有给出，网上的说法是映射到一个 char * 字符串
// 也就是本质上是一个 char * 字符串
// 经过下面的实验，确实如此  struct objc_selector *  == SEL == char *

- (void)methedWithStr1:(NSString *)str1 str2:(NSString *)str2 {
    NSLog(@"%@,%@", str1, str2);
}

- (void)test {
    struct objc_selector * sel_1 = @selector(methedWithStr1:str2:);
    SEL sel_2 = @selector(methedWithStr1:str2:);
    if (sel_1 == sel_2) {
        NSLog(@"一样");    // 确实一样
    } else {
        NSLog(@"不一样");
    }
    // 转为 char *
    char * str_1 = (char *)sel_1;
    printf("%s\n", str_1);  // methedWithStr1:str2:
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
