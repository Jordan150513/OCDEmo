//
//  TwoViewController.m
//  DDFloatView
//
//  Created by 乔丹丹 on 16/8/13.
//  Copyright © 2016年 Jordan. All rights reserved.
//

#import "TwoViewController.h"
#import "FloatView.h"

@interface TwoViewController ()

@property(nonatomic,strong)FloatView * floatView;
@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"FloatView2";
    self.floatView = [[FloatView alloc] initWithFrame:CGRectMake(200, 200, 100, 100)];
    [self.view addSubview:self.floatView];
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    panGes.minimumNumberOfTouches = 1;
    panGes.maximumNumberOfTouches = 1;
    [self.floatView addGestureRecognizer:panGes];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGes {
    CGPoint currentPoint = [panGes locationInView:self.view];
    self.floatView.center = currentPoint;
    
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
