//
//  ComponentOneViewController.m
//  ZuJianHuaDemo
//
//  Created by 乔丹丹 on 2017/2/21.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "ComponentOneViewController.h"

@interface ComponentOneViewController ()
@property(nonatomic,strong)NSString * someid;
@end

@implementation ComponentOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"component 1";
    
}
//给Mediator使用
+ (UIViewController *)createComponentOneViewController:(NSString *)someId{
    ComponentOneViewController * vcOne = [[ComponentOneViewController alloc] initWithId:someId];
    return vcOne;
}

-(instancetype)initWithId:(NSString *)id{
    if(self = [super init]){
    
    }
    self.someid = id;
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
