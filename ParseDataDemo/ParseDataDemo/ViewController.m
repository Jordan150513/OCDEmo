//
//  ViewController.m
//  ParseDataDemo
//
//  Created by 乔丹丹 on 2016/12/13.
//  Copyright © 2016年 Fang. All rights reserved.
//

#import "ViewController.h"
#import "ParseXmlData.h"
#import "SHRegisterDesignerModel.h"
#import "SimpleModel.h"

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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * simpleXmlStr = @"<root><result>”1”</result><message>“操作成功”</message></root>";
    SimpleModel * simpleModel = [SimpleModel praseSimpleXmlStr:simpleXmlStr];
    
    NSString * xmlStr1 = @"<root><result>”1”</result><message>“操作成功”</message><loginmsg><soufunId>1234567</soufunId><soufunName>dandan</soufunName><realName>qiaodan</realName></loginmsg></root>";
    
//    SHRegisterDesignerModel * model = [SHRegisterDesignerModel praseSHRegisterDesignerModel:xmlStr1];
//    model.result;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
