//
//  SimpleModel.h
//  ParseDataDemo
//
//  Created by 乔丹丹 on 2016/12/14.
//  Copyright © 2016年 Fang. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 <root>
 <result>”1”</result>
 <message>“操作成功”</message>
 </root>
 */
@interface SimpleModel : NSObject
@property(nonatomic,strong)NSString * result;
@property(nonatomic,strong)NSString * message;
+(id)praseSimpleXmlStr:(NSString *)str;
@end
