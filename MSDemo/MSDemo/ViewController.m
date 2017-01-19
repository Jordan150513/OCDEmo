//
//  ViewController.m
//  MSDemo
//
//  Created by 乔丹丹 on 2017/1/19.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController ()
@property(nonatomic,strong)UIView * redView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    
    UIView * redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    self.redView = redView;
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.equalTo(@30);
    }];
    
//    [self make];
    [self update];
//    [self remake];
}

-(void)make{
    // 之前已经设置了，再次make，无效
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.equalTo(@90);
    }];
}

-(void)update{
    //更新,之前有的没有更改的约束会保留，有变动的，更新约束
    [self.redView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).with.offset(50);
//        make.trailing.equalTo(self.view);
//        make.top.equalTo(self.view);
        make.height.equalTo(@90);
    }];
}

-(void)remake{
    //全部约束都再来设置，不会用之前有的，删除之前的约束，用心约束
    [self.redView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).with.offset(50);
        make.trailing.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.equalTo(@90);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
