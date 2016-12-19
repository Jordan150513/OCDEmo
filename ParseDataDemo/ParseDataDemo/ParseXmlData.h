//
//  ParseXmlData.h
//  ParseDataDemo
//
//  Created by 乔丹丹 on 2016/12/13.
//  Copyright © 2016年 Fang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParseXmlData : NSObject
+ (id)parseDataFromXML:(NSString *)xmlString nodeArrary:(NSMutableArray*) nodes modeArrary:(NSMutableArray*) modes andOpption:(BOOL) isArray;
@end
