//
//  SimpleModel.m
//  ParseDataDemo
//
//  Created by 乔丹丹 on 2016/12/14.
//  Copyright © 2016年 Fang. All rights reserved.
//

#import "SimpleModel.h"
#import "ParseXmlData.h"

@implementation SimpleModel

+(id)praseSimpleXmlStr:(NSString *)str{
    NSMutableArray * nodes = [[NSMutableArray alloc] init];
    [nodes addObject:@"//root"];
    
    NSMutableArray * modes = [[NSMutableArray alloc] init];
    [modes addObject:@"SimpleModel"];
    
    id iret = [ParseXmlData parseDataFromXML:str nodeArrary:nodes modeArrary:modes andOpption:NO];
    return iret;
}
@end
