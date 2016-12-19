//
//  SHRegisterDesignerModel2.m
//  ParseDataDemo
//
//  Created by 乔丹丹 on 2016/12/13.
//  Copyright © 2016年 Fang. All rights reserved.
//

#import "SHRegisterDesignerModel2.h"
#import "ParseXmlData.h"

@implementation SHRegisterDesignerModel2
+(id)praseSHRegisterDesignerModel:(NSString *)str{
    NSMutableArray * nodes = [[NSMutableArray alloc] init];
    [nodes addObject:@"//Root"];
    [nodes addObject:@"//Root//loginmsgArr//loginmsg"];
    
    NSMutableArray * modes = [[NSMutableArray alloc] init];
    [modes addObject:@"SHRegisterDesignerModel2"];
    [modes addObject:@"SHDetailDataModel2"];
    
    id iret = [ParseXmlData parseDataFromXML:str nodeArrary:nodes modeArrary:modes andOpption:NO];
    return iret;
}
@end

@implementation SHDetailDataModel2


@end
