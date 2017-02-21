//
//  ComponentThreeViewController.m
//  ZuJianHuaDemo
//
//  Created by 乔丹丹 on 2017/2/21.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "ComponentThreeViewController.h"
#import "MediatorTwo.h"

@interface ComponentThreeViewController ()
@property(nonatomic,strong)NSString * someId;
@end

@implementation ComponentThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"component 3";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 第二种组件化方式
+ (void)initComponent {
    [[MediatorTwo sharedInstance] registerURLPattern:@"weread://bookDetail" toHandler:^(NSDictionary *param) {
        ComponentThreeViewController *vcThree = [[ComponentThreeViewController alloc] initWithSomeid:param[@"someId"]];
//        UINavigationController * navc = [UIApplication sharedApplication].keyWindow.rootViewController.navigationController;
//        //取不出来navigationController，取出来是nil，所以不能成功跳转
//        [navc pushViewController:vcThree animated:YES];
        //这里没有实现跳转哎？什么情况？？
        //改成下面这样就跳转成功了
        UINavigationController * navc = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        [navc pushViewController:vcThree animated:YES];
    }];
}

-(instancetype)initWithSomeid:(NSString *)someId{
    if(self = [super init]){
        
    }
    self.someId = someId;
    return self;
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
