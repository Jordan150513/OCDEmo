//
//  ViewController.m
//  AssociatedObjcDemo
//
//  Created by 乔丹丹 on 2017/2/28.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "ViewController.h"
#import "ViewController+AssociatedObjects.h"
@interface ViewController ()

@end

__weak NSString * weakV = nil;
__weak NSString * strongV = nil;
__weak NSString * assignV = nil;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"View Controller";
    self.weakProperty = @"weakValue";
    self.strongProperty = @"strongValue";
    self.assignProperty = @"assignValue";
    weakV = self.weakProperty;
    strongV = self.strongProperty;
    assignV = self.assignProperty;
    
    
}

-(void)viewWillDisappear:(BOOL)animated{

}
-(void)dealloc{
    NSLog(@"%@",self);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
