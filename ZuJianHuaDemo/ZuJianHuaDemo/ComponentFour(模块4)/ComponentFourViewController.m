//
//  ComponentFourViewController.m
//  ZuJianHuaDemo
//
//  Created by 乔丹丹 on 2017/2/21.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "ComponentFourViewController.h"
#import "ProtocolMediator.h"

@interface ComponentFourViewController ()
@property(nonatomic,strong)NSString * someId;
@end

@implementation ComponentFourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"组件 4";
    // protocol-class 注册表的方式
    
}


//+ (void)initComponent
//{
//    [[ProtocolMediator sharedInstance] registerProtocol:@protocol(ComponentFourProtocol) forClass:[self class];
//}
//     
//- (UIViewController *)compFourController:(NSString *)someId{
//         ComponentFourViewController * vcFour= [[ComponentFourViewController alloc] initWithSomeId:someId];
//         return vcFour;
//}

 -(instancetype)initWithSomeid:(NSString *)someId{
     if(self = [super init]){
         
     }
     self.someId = someId;
     return self;
 }
//- (UIImage *)coverImageWithsomeId:(NSString *)someId{
//    
//}




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
