//
//  Mediator.h
//  ZuJianHuaDemo
//
//  Created by 乔丹丹 on 2017/2/21.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Mediator : NSObject
+ (UIViewController *)ComponentOneViewController:(NSString *)someId;
+ (UIViewController *)ComponentTwoViewController:(NSString *)someId andType:(NSInteger)type;

@end
