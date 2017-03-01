//
//  ViewController.m
//  ResponderDemo
//
//  Created by 乔丹丹 on 2017/3/1.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "ViewController.h"
#import "BigRedView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Responder Demo";
    
    BigRedView * bigView = [[BigRedView alloc] initWithFrame:CGRectMake(30, 60, 250, 300)];
    bigView.backgroundColor = [UIColor redColor];
    [self.view addSubview:bigView];
    
//    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [leftBtn setTitle:@"left" forState:UIControlStateNormal];
//    [leftBtn setFrame:CGRectMake(10, 30, 50, 50)];
//    [leftBtn setBackgroundColor:[UIColor lightGrayColor]];
//    [leftBtn addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
//    [bigView addSubview:leftBtn];
//    
//    UIButton * rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightBtn setTitle:@"right" forState:UIControlStateNormal];
//    [rightBtn setFrame:CGRectMake(80, 30, 50, 50)];
//    [rightBtn setBackgroundColor:[UIColor lightGrayColor]];
//    [rightBtn addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
//    [bigView addSubview:rightBtn];
//    
//    UITapGestureRecognizer * tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundClick:)];
//    [bigView addGestureRecognizer:tapGes];
    
}

//-(void)backgroundClick:(id)sender{
//    NSLog(@"backgroundClicked");
//}
//
//-(void)leftClick:(UIButton *)sender{
//    NSLog(@"left");
//}
//
//-(void)rightClick:(UIButton *)sender{
//    NSLog(@"right");
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
