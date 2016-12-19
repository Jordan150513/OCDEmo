//
//  ParseXmlData.m
//  ParseDataDemo
//
//  Created by 乔丹丹 on 2016/12/13.
//  Copyright © 2016年 Fang. All rights reserved.
//

#import "ParseXmlData.h"
#import "GDataXMLNode.h"
#import <Foundation/NSObjCRuntime.h>
#import <objc/objc.h>
#import <objc/runtime.h>
@implementation ParseXmlData
+ (id)parseDataFromXML:(NSString *)xmlString nodeArrary:(NSMutableArray*) nodes modeArrary:(NSMutableArray*) modes andOpption:(BOOL) isArray{
    if (xmlString==nil) {
        return nil;
    }
    if (nodes.count!=modes.count) {
        return nil;
    }

    GDataXMLDocument *xmlDoc = [[GDataXMLDocument alloc] initWithXMLString:xmlString error:nil];
    GDataXMLElement * rootElement = [xmlDoc rootElement];
    
    //获取nodes[i]路径下的，root路径下的不需要这样去取
    //    [xmlDoc nodesForXPath:nodes[i] error:nil]
    
    //根据model名字创建一个model类实例对象
    id baseObjModel = [[NSClassFromString([modes objectAtIndex:0]) alloc] init];
    //获取model类实例对象的所有属性名字
    NSMutableArray * propertyBaseArr = [NSMutableArray array];
    NSMutableDictionary * propertyBaseDic = [NSMutableDictionary dictionary];

    [ParseXmlData propertyDictionary:propertyBaseDic propertyMutableArray:propertyBaseArr withobj:baseObjModel];
    /*
    (lldb) po propertyBaseDic
    {
    message = NSString;
    result = NSString;
    }
    */
    
    /*
     (lldb) po propertyBaseArr
     <__NSArrayM 0x1702534a0>(
     result,
     message
     )
     */
    NSArray * tmpChildElemet = [rootElement elementsForName:@""];
    return nil;
}
#pragma mark - 获取类的属性数组
+(void)propertyMutableArray:(NSMutableArray *)proNameArr obj:(NSObject *) objt{
    unsigned int outCount;
    objc_property_t * properties = class_copyPropertyList([objt class], &outCount);
    //获取类的属性列表 &outCount就是指向栈中outCount的指针，栈中outCount变量的地址,outCount是属性的总数
//    class_copyPropertyList(<#__unsafe_unretained Class cls#>, <#unsigned int *outCount#>)
    //第二个参数是指针，指向栈中outCount的指针；
    for (int i = 0; i<outCount; i++) {
        objc_property_t property = properties[i];
        const char * properName = property_getName(property);
        if (properName) {
            NSString * propertyName = [NSString stringWithCString:properName encoding:NSUTF8StringEncoding];
            [proNameArr addObject:propertyName];
        }
    }
}
#pragma mark - 获取类的属性类型对应字典
+(void)propertyDictionary:(NSMutableArray *)proDict obj:(NSObject *) objt{
    unsigned int outCount;
    objc_property_t * properties = class_copyPropertyList([objt class], &outCount);
    //获取类的属性列表 &outCount就是指向栈中outCount的指针，栈中outCount变量的地址,outCount是属性的总数
    //    class_copyPropertyList(<#__unsafe_unretained Class cls#>, <#unsigned int *outCount#>)
    //第二个参数是指针，指向栈中outCount的指针；
    for (int i = 0; i<outCount; i++) {
        objc_property_t property = properties[i];
        const char * properName = property_getName(property);
        if (properName) {
            const char * propertyType = getPropertyType(property);
            NSString * name = [NSString stringWithCString:properName encoding:NSUTF8StringEncoding];
            NSString * type = [NSString stringWithCString:propertyType encoding:NSUTF8StringEncoding];
            [proDict setValue:type forKey:name];
        }
    }

}
//将上面两个方法合成一个
#pragma mark - 获取类属性的属性数组 和 属性和类型对应的字典
+(void)propertyDictionary:(NSDictionary *)proDict propertyMutableArray:(NSMutableArray *)proNameArr withobj:(NSObject *) objt{
    unsigned int outCount;
    objc_property_t * properties = class_copyPropertyList([objt class], &outCount);
    //获取类的属性列表 &outCount就是指向栈中outCount的指针，栈中outCount变量的地址,outCount是属性的总数
    //    class_copyPropertyList(<#__unsafe_unretained Class cls#>, <#unsigned int *outCount#>)
    //第二个参数是指针，指向栈中outCount的指针；
    for (int i = 0; i<outCount; i++) {
        objc_property_t property = properties[i];
        const char * properName = property_getName(property);
        if (properName) {
            const char * propertyType = getPropertyType(property);
            NSString * name = [NSString stringWithCString:properName encoding:NSUTF8StringEncoding];
            NSString * type = [NSString stringWithCString:propertyType encoding:NSUTF8StringEncoding];
            [proDict setValue:type forKey:name];
            [proNameArr addObject:name];
        }
    }
    
}

#pragma mark - 获取某个属性的类型
static const char* getPropertyType(objc_property_t property) {
    const char * attributes = property_getAttributes(property);   //内容是："T@"NSString",&,N,V_result"
                                                                  //内容是："T@"NSString",&,N,V_message"
    char buffer[1+strlen(attributes)];
    //attributes-->buffer
    strcpy(buffer, attributes);
    
    char *state = buffer;
    char *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T' && strlen(attribute)>2) {
            
            static char newbuffer[100];
            memset(newbuffer, 0x00, 100);
            strncpy(newbuffer, (attribute + 3), strlen(attribute)-4);
            newbuffer[1 + strlen(attribute)-4] = '\n';
            
            return newbuffer;
            
            
        }else if (attribute[0] == 'T' && strlen(attribute)==2) {
            static char newbuffer[100];
            memset(newbuffer, 0x00, 100);
            strncpy(newbuffer, (attribute + 1), strlen(attribute)-1);
            newbuffer[strlen(attribute)-1] = '\n';
            return newbuffer;
        }
    }

    return "@";
}
@end
