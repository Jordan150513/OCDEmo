//
//  SHRegisterDesignerModel.h
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
 
 <loginmsg>
 <soufunId>1234567</soufunId>
 <soufunName>dandan</soufunName>
 <realName>qiaodan</realName>
 </loginmsg>
 
 </root>
 */

//外层数据model类
@class SHDetailDataModel;
@interface SHRegisterDesignerModel : NSObject
@property(nonatomic,strong)NSString * result;
@property(nonatomic,strong)NSString * message;
@property(nonatomic,strong)SHDetailDataModel * detailDataModel;

+(id)praseSHRegisterDesignerModel:(NSString *)str;
@end

//内层数据model类
@interface SHDetailDataModel : NSObject
@property(nonatomic,strong)NSString * soufunId;
@property(nonatomic,strong)NSString * soufunName;
@property(nonatomic,strong)NSString * realName;
@end
