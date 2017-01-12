//
//  AssociatedObjectViewController.m
//  RunLoopDemos
//
//  Created by 乔丹丹 on 2017/1/12.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "AssociatedObjectViewController.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface AssociatedObjectViewController ()
@property (nonatomic, assign) BOOL disabledDD;
@end

@implementation AssociatedObjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"AssociatedObject Demo";
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(100, 100, 100, 50)];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
   
}
-(void)setDisabledDD:(BOOL)disabledDD{
    objc_setAssociatedObject(self, @selector(disabledDD), @(disabledDD), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    //    OS_OBJECT_CLASS_IMPLEMENTS_PROTOCOL_IMPL(<#name#>, <#proto#>)
}

-(BOOL)disabledDD{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

-(void)click:(UIButton *)button{
    NSLog(@"button 点击了");
    
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
