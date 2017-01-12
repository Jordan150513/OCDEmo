//
//  ViewController.m
//  EnlargeButtonActionArea
//
//  Created by 乔丹丹 on 2017/1/9.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "ViewController.h"
#import "EnlargedButton.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"Click1" forState:UIControlStateNormal];
    [button1 setFrame:CGRectMake(100, 100, 100, 40)];
    [button1 setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:button1];
    
    EnlargedButton * button2 = [EnlargedButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"Click2" forState:UIControlStateNormal];
    [button2 setFrame:CGRectMake(100, 200, 100, 40)];
    [button2 setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:button2];
    
//        [button1 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button2 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)buttonClicked:(UIButton *)button{
    NSLog(@"点击啦");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
