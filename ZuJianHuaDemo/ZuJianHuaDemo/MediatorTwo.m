//
//  MediatorTwo.m
//  ZuJianHuaDemo
//
//  Created by 乔丹丹 on 2017/2/21.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "MediatorTwo.h"

@implementation MediatorTwo
//第二种组件化的方式：

- (void)registerURLPattern:(NSString *)urlPattern toHandler:(componentBlock)blk {
    [self.cache setObject:blk forKey:urlPattern];
}
- (void)openURL:(NSString *)url withParam:(id)param {
    componentBlock blk = [self.cache objectForKey:url];
    if (blk) blk(param);
}
-(NSMutableDictionary *)cache{
    if (_cache==nil) {
        _cache = [NSMutableDictionary dictionary];
    }
    return _cache;
}
+(instancetype)sharedInstance{
    static MediatorTwo * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        
    });
    return instance;
}
@end
