//
//  LEDScreen.m
//  TestDemo
//
//  Created by 乔丹丹 on 18/3/17.
//  Copyright © 2018年 Fang. All rights reserved.
//

#import "LEDScreen.h"

@implementation LEDScreen
- (void) helloScreen{
    
    // 这里也是ledscreen 当前实例是子类的实例 当前类一直是子类 super只是一个编译器指示符号
    //指示作用 表示是去父类的方法表里找方法的实现而已
    
    [super helloScreen];
    
    NSLog(@"%@",[self class]);
}
@end
