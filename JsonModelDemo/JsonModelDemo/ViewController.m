//
//  ViewController.m
//  JsonModelDemo
//
//  Created by 乔丹丹 on 2017/1/25.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "ViewController.h"
#import "CountryModel.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"JsonModel";
    
    //  1、JsonModel 实现原理的学习------------------
    //    核心就是用class_copyPropertyList得到类的属性列表，在遍历列表，用property_getAttributes得到每个属性的类型，最后用kvc，接可以得到所有的值。
    
//    2、 ESJosnFormat 和 MJExtension的配合使用 解析Model的实现原理
    
    // a. 只有一层的数据
    NSString * myJson = @"{ \"id\": 10, \"country\": \"Germany\", \"dialCode\": 49, \"isInEurope\": true }";
    NSError *error;
    CountryModel *country = [[CountryModel alloc] initWithString:myJson error:&error];
    NSLog(@"%@",country);
    NSLog(@"%@",country.country);
    
    // b. 层数嵌套的数据
    
    // c. 有数组嵌套的数据
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
