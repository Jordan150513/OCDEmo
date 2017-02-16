//
//  ViewController.m
//  IMPMethodSwizzlingDemo
//
//  Created by 乔丹丹 on 2017/2/16.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
@interface ViewController ()

@end

@implementation ViewController
/*
 这里会引申一个问题：
 就是load()和init()有什么区别？
 那个时候没有回答上来，没有辨识到，需要去探究！！！
 */
+(void)load{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method viewDidLoad = class_getInstanceMethod(self, @selector(viewDidLoad));
        
        Method viewDidLoadSwizzlingMethond = class_getInstanceMethod(self, @selector(viewDidLoadSwizzlingMethond));
        
        method_exchangeImplementations(viewDidLoad, viewDidLoadSwizzlingMethond);
    });
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"viewDidLoad调用了");
}


-(void)viewDidLoadSwizzlingMethond{//调用viewDidLoad的时候会来到这里
    
    [self viewDidLoadSwizzlingMethond];//这句会跑去调用viewDidLoad方法的实现
    NSLog(@"viewDidLoadSwizzlingMethond调用了");//调用完viewDidLoad，会执行这一句
}
/*
 运行输出：
  IMPMethodSwizzlingDemo[1132:286302] viewDidLoad调用了
  IMPMethodSwizzlingDemo[1132:286302] viewDidLoadSwizzlingMethond调用了
 
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
