//
//  MediatorTwo.h
//  ZuJianHuaDemo
//
//  Created by 乔丹丹 on 2017/2/21.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MediatorTwo : NSObject
//第二种组件化方式：
typedef void (^componentBlock) (id param);
@property (nonatomic,strong) NSMutableDictionary *cache;

+(instancetype)sharedInstance;
- (void)registerURLPattern:(NSString *)urlPattern toHandler:(componentBlock)blk;
- (void)openURL:(NSString *)url withParam:(id)param;
@end
