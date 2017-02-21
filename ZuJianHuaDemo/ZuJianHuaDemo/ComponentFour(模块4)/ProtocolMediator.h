//
//  ProtocolMediator.h
//  ZuJianHuaDemo
//
//  Created by 乔丹丹 on 2017/2/21.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProtocolMediator : NSObject
@property (nonatomic,strong) NSMutableDictionary *protocolCache;
+(instancetype)sharedInstance;
- (void)registerProtocol:(Protocol *)proto forClass:(Class)cls;
@end
