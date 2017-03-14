//
//  Son.m
//  TestDemo
//
//  Created by 乔丹丹 on 2017/3/14.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "Son.h"

@implementation Son
- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"%@", NSStringFromClass([self class]));
        NSLog(@"%@", NSStringFromClass([super class]));
    }
    return self;
}
@end
