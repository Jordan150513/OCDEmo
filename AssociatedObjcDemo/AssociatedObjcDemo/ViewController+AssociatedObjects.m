//
//  ViewController+AssociatedObjects.m
//  AssociatedObjcDemo
//
//  Created by 乔丹丹 on 2017/2/28.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "ViewController+AssociatedObjects.h"
#import <objc/runtime.h>

@implementation ViewController (AssociatedObjects)

/**
 * Returns the value associated with a given object for a given key.
 *
 * @param object The source object for the association.
 * @param key The key for the association.
 *
 * @return The value associated with the key \e key for \e object.
 *
 * @see objc_setAssociatedObject
 */
//OBJC_EXPORT id objc_getAssociatedObject(id object, const void *key)

#pragma mark - weak的set get方法
-(void)setWeakProperty:(NSString *)weakProperty{
    //key就是weakProperty
    objc_setAssociatedObject(self, @selector(weakProperty), weakProperty, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)weakProperty{
    return objc_getAssociatedObject(self, _cmd);//_cmd作为key _cmd 就是“weakProperty”
}

#pragma mark - strong的set get方法
-(void)setStrongProperty:(NSString *)strongProperty{
    objc_setAssociatedObject(self, @selector(strongProperty), strongProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)strongProperty{
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark - assign的 set get 方法
-(void)setAssignProperty:(NSString *)assignProperty{
    objc_setAssociatedObject(self, @selector(assignProperty), assignProperty, OBJC_ASSOCIATION_ASSIGN);
}

-(NSString *)assignProperty{
    return objc_getAssociatedObject(self, _cmd);
}
@end
