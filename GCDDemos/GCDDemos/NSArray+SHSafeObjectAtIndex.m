//
//  NSArray+SHSafeObjectAtIndex.m
//  homezxb
//
//  Created by 乔丹丹 on 2016/12/22.
//  Copyright © 2016年 soufunhome. All rights reserved.
//

#import "NSArray+SHSafeObjectAtIndex.h"

@implementation NSArray (SHSafeObjectAtIndex)
- (id)safeObjectAtIndex:(NSUInteger)index{
    if (self==nil||self.count==0) {
        return nil;
    }else return [self objectAtIndex:index];
}
@end
