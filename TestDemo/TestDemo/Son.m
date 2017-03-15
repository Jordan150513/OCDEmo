//
//  Son.m
//  TestDemo
//
//  Created by 乔丹丹 on 2017/3/14.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "Son.h"

@interface Son()
@property(nonatomic,copy)NSString * string;
@end

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

-(void)logTheSonMessage{
    NSLog(@"I am son.\n");
}

// 1、解决找不到消息的问题
+(BOOL)resolveInstanceMethod:(SEL)sel{
    if ([NSStringFromSelector(sel) isEqualToString:@"logNone"]) {
        NSLog(@"接收到这个unrecognized selector :%@",NSStringFromSelector(sel));
    }
    return YES;
}
// 2、转发消息给其他的target
//-(id)forwardingTargetForSelector:(SEL)aSelector{
//
//}

// 3.程序挂了之后 发送 unrecognized selector send to instance之后
//-(void)forwardInvocation:(NSInvocation *)anInvocation{
//
//}
@end
