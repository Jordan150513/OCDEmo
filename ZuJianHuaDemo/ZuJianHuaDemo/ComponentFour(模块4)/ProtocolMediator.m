//
//  ProtocolMediator.m
//  ZuJianHuaDemo
//
//  Created by 乔丹丹 on 2017/2/21.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "ProtocolMediator.h"

@implementation ProtocolMediator

- (void)registerProtocol:(Protocol *)proto forClass:(Class)cls {
    [self.protocolCache setObject:cls forKey:NSStringFromProtocol(proto)];
}

- (Class)classForProtocol:(Protocol *)proto {
    NSString * keyStr = NSStringFromProtocol(proto);
    return [self.protocolCache objectForKey:keyStr];
}
-(NSMutableDictionary *)protocolCache{
    if (_protocolCache==nil) {
        _protocolCache = [NSMutableDictionary dictionary];
    }
    return _protocolCache;
}

+(instancetype)sharedInstance{
    static ProtocolMediator * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        
    });
    return instance;
}
@end
