//
//  ComponentProtocol.h
//  ZuJianHuaDemo
//
//  Created by 乔丹丹 on 2017/2/21.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ComponentProtocol <NSObject>

@end

@protocol ComponentFourProtocol <NSObject>
- (UIViewController *)compFourController:(NSString *)someId;
- (UIImage *)coverImageWithsomeId:(NSString *)someId;
@end

@protocol ComponentFiveProtocol <NSObject>
- (UIViewController *)compFiveController:(NSString *)someId;
@end
