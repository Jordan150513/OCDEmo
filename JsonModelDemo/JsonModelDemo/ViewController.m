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
    
    //JsonModel 实现原理的学习------------------
    
    NSString * myJson = @"{ \"id\": 10, \"country\": \"Germany\", \"dialCode\": 49, \"isInEurope\": true }";
    NSError *error;
    CountryModel *country = [[CountryModel alloc] initWithString:myJson error:&error];
    NSLog(@"%@",country);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
