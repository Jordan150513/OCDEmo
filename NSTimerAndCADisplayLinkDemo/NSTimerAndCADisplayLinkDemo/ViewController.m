//
//  ViewController.m
//  NSTimerAndCADisplayLinkDemo
//
//  Created by 乔丹丹 on 16/12/19.
//  Copyright © 2016年 com.home.zxb. All rights reserved.
//

#import "ViewController.h"
#import "NSTimerViewController.h"
#import "CADisplayLinkViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"NSTimer和CADisplayLink";
    
    UIButton * timerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [timerButton setTitle:@"NSTimer" forState:UIControlStateNormal];
    [timerButton setFrame:CGRectMake(100, 100, 150, 30)];
    [timerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    timerButton.tag = 1000;
    [self.view addSubview:timerButton];
    
    UIButton * caDisplayLingkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [caDisplayLingkButton setTitle:@"CADisplayLink" forState:UIControlStateNormal];
    [caDisplayLingkButton setFrame:CGRectMake(100, 150, 150, 30)];
    [caDisplayLingkButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    caDisplayLingkButton.tag = 2000;
    [self.view addSubview:caDisplayLingkButton];
    
    [timerButton addTarget:self action:@selector(clickToJump:) forControlEvents:UIControlEventTouchUpInside];
    [caDisplayLingkButton addTarget:self action:@selector(clickToJump:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)clickToJump:(UIButton *)button{
    if (button.tag==1000) {
       //NSTimer
        NSTimerViewController * vc = [[NSTimerViewController alloc] init];
//        [self presentViewController:vc animated:YES completion:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(button.tag == 2000){
       //CADisplayLink
        CADisplayLinkViewController * vc = [[CADisplayLinkViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
//        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
