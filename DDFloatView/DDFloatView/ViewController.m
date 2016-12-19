//
//  ViewController.m
//  DDFloatView
//
//  Created by 乔丹丹 on 16/8/13.
//  Copyright © 2016年 Jordan. All rights reserved.
//

#import "ViewController.h"
#import "TwoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Float View";
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"Next" forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(100, 100, 70, 40)];
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(nextViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
-(void)nextViewController{
    TwoViewController * vcT = [[TwoViewController alloc] init];
    [self.navigationController pushViewController:vcT animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
