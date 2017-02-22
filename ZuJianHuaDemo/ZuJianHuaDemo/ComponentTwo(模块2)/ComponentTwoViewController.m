//
//  ComponentTwoViewController.m
//  ZuJianHuaDemo
//
//  Created by 乔丹丹 on 2017/2/21.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "ComponentTwoViewController.h"

@interface ComponentTwoViewController ()
@property(nonatomic,strong)NSString * someId;
@property(nonatomic,assign)NSInteger type;
@end

@implementation ComponentTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"component 2";
}
//给Mediator使用
+(UIViewController *)createComponentTwoViewController:(NSString *)someId andType:(NSInteger)type{
    return [[ComponentTwoViewController alloc] initWithId:someId andType:type];
    
}

-(instancetype)initWithId:(NSString *)id andType:(NSInteger)type{
    if(self = [super init]){
        
    }
    self.someId = id;
    self.type = type;
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
