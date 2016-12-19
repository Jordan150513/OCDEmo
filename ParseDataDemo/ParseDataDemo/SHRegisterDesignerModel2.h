//
//  SHRegisterDesignerModel2.h
//  ParseDataDemo
//
//  Created by 乔丹丹 on 2016/12/13.
//  Copyright © 2016年 Fang. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 <root>
 <result>”1”</result>
 <message>“操作成功”</message>
 
 <loginmsgArr>
 
 <loginmsg>
 <soufunId>1234567</soufunId>
 <soufunName>dandan</soufunName>
 <realName>qiaodan</realName>
 </loginmsg>
 
 <loginmsg>
 <soufunId>1234567</soufunId>
 <soufunName>dandan</soufunName>
 <realName>qiaodan</realName>
 </loginmsg>
 
 <loginmsg>
 <soufunId>1234567</soufunId>
 <soufunName>dandan</soufunName>
 <realName>qiaodan</realName>
 </loginmsg>
 
 </loginmsgArr>
 </root>
 */
@class SHDetailDataModel2;
@interface SHRegisterDesignerModel2 : NSObject
@property(nonatomic,strong)NSString * result;
@property(nonatomic,strong)NSString * message;
@property(nonatomic,strong)NSMutableArray<SHDetailDataModel2 *> * detailDataModel;

+(id)praseSHRegisterDesignerModel:(NSString *)str;
@end

@interface SHDetailDataModel2 : NSObject
@property(nonatomic,strong)NSString * soufunId;
@property(nonatomic,strong)NSString * soufunName;
@property(nonatomic,strong)NSString * RealName;
@end
