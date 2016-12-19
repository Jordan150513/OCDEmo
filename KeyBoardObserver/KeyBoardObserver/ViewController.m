//
//  ViewController.m
//  KeyBoardObserver
//
//  Created by 乔丹丹 on 16/6/3.
//  Copyright © 2016年 Fang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITextView * textView = [[UITextView alloc] init];
    textView.frame = CGRectMake(100, 100, 100, 100);
    textView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:textView];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
