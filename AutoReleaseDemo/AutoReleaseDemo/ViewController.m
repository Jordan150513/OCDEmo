//
//  ViewController.m
//  AutoReleaseDemo
//
//  Created by 乔丹丹 on 2017/3/17.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "ViewController.h"

// 参考 http://blog.leichunfeng.com/blog/2015/05/31/objective-c-autorelease-pool-implementation-principle/
@interface ViewController ()

@end
__weak NSString * weakString = nil;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Autorelease Demo";
    
//    // 场景 1
//    NSString * string = [NSString stringWithFormat:@"qiao"];
//    weakString = string;
    
    
//    // 场景 2
//    @autoreleasepool {
//        NSString * string = [NSString stringWithFormat:@"qiao"];
//        weakString = string;
//    }
    
    
    // 场景 3
    NSString * string = nil;
    @autoreleasepool {
        string = [NSString stringWithFormat:@"qiao"];
        weakString = string;
    }
    
    
    NSLog(@"viewDidLoad---string:%@",weakString);
}
-(void)viewWillAppear:(BOOL)animated{

    NSLog(@"viewWillAppear---string:%@",weakString);
}

-(void)viewDidAppear:(BOOL)animated{
  NSLog(@"viewDidAppear---string:%@",weakString);
}

// 场景 1
/*
 viewDidLoad---string:qiao
 viewWillAppear---string:qiao
 viewDidAppear---string:qiao
 */

// 场景 2
/*
 viewDidLoad---string:qiao
 viewWillAppear---string:qiao
 viewDidAppear---string:qiao
 
 */
// 场景 3
/*
 viewDidLoad---string:qiao
 viewWillAppear---string:qiao
 viewDidAppear---string:qiao
 */

// 这个实验demo已经失效了

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
