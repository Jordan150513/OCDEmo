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

//__weak NSString * weakV = nil;
__weak NSString * copyV = nil;
__weak NSString * strongV = nil;
__weak NSString * assignV = nil;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"View Controller";
//    self.weakProperty = [NSString stringWithFormat:@"weakValue" ];
    self.strongProperty = [NSString stringWithFormat:@"strongValue"];
    self.assignProperty = [NSString stringWithFormat:@"assignValue"];
    self.copyProperty = [NSString stringWithFormat:@"copyValue"];
//    weakV = self.weakProperty;
    copyV = self.copyProperty;
    strongV = self.strongProperty;
    assignV = self.assignProperty;
    
    
}
/*
 首先 是assign置为nil了 在viewdidload里赋值后，ViewDidLoad执行完成之后，assign的置为nil,这个是由自动释放池drain的时候 释放掉的
 然后返回的时候 strong置为nil了，这个控制器销毁的时候，调用了objc_removeAssociates的时候，关联属性被移除。其strong属性也置为nil了。
 
 weak什么时候置为了nil？
 copy什么时候置为nil？
 理论说的是 跟strong一起，在控制器被销毁的时候 调用了objc_removeAssociates，进行了置为nil，但是我单独跟踪copy，并没有跟踪到置为了nil？什么情况？
 疑问？

 */

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    NSLog(@"%@",self.copyProperty);
    NSLog(@"%@",self.strongProperty);
//    NSLog(@"%@",self.assignProperty);
    //这里会报错 EXC_BAD_ACCESS self.assignProperty 会在ViewDidLoad之后就释放掉了。所以在这里访问的时候，就会访问到
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
