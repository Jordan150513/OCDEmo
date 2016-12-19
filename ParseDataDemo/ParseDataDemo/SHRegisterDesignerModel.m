//
//  SHRegisterDesignerModel.m
//  ParseDataDemo
//
//  Created by 乔丹丹 on 2016/12/13.
//  Copyright © 2016年 Fang. All rights reserved.
//

#import "SHRegisterDesignerModel.h"
#import "ParseXmlData.h"

//外层数据model类
@implementation SHRegisterDesignerModel

+(id)praseSHRegisterDesignerModel:(NSString *)str{
    NSMutableArray * nodes = [[NSMutableArray alloc] init];
    [nodes addObject:@"//root"];
    [nodes addObject:@"//root//loginmsg"];
    
    NSMutableArray * modes = [[NSMutableArray alloc] init];
    [modes addObject:@"SHRegisterDesignerModel"];
    [modes addObject:@"SHDetailDataModel"];
    
    id iret = [ParseXmlData parseDataFromXML:str nodeArrary:nodes modeArrary:modes andOpption:NO];
    return iret;
}
@end
//内层数据model类
@implementation SHDetailDataModel



@end
