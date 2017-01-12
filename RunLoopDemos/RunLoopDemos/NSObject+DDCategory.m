//
//  NSObject+DDCategory.m
//  RunLoopDemos
//
//  Created by 乔丹丹 on 2017/1/12.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "NSObject+DDCategory.h"
#import <objc/runtime.h>



@implementation NSObject (DDCategory)
-(void)setNameStr:(NSString *)nameStr{
    NSLog(@"set方法调用了");
    objc_setAssociatedObject(self, @selector(nameStr), nameStr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)nameStr{
     NSLog(@"get方法调用了");
    return objc_getAssociatedObject(self, _cmd);
   
}
@end
