//
//  ViewController.m
//  KVODemo
//
//  Created by 乔丹丹 on 2017/3/17.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()
@property(nonatomic,strong)Person *aPerson;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"KVO Demo";
    Person * aPerson = [[Person alloc] init];
    _aPerson = aPerson;
    //添加监听
    [_aPerson addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [aPerson setName:@"qiao"];
    
    [aPerson setName:@"dan"];
    //总算是实现了
}

// 实现监听
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"name"]) {
        NSLog(@"旧值：%@",[change objectForKey:@"old"]);
        NSLog(@"新值：%@",[change objectForKey:@"new"]);
    }
}

-(void)dealloc{
    [_aPerson removeObserver:self forKeyPath:@"name"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
