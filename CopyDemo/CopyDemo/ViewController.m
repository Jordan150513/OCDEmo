//
//  ViewController.m
//  CopyDemo
//
//  Created by 乔丹丹 on 2016/11/28.
//  Copyright © 2016年 Fang. All rights reserved.
//

#import "ViewController.h"
#import "QDPerson.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //1、深copy
    NSMutableArray *arr1=[[NSMutableArray alloc] initWithObjects:@"a", @"b", @"c", nil];
    NSMutableArray *arr2=[[NSMutableArray alloc] init];
    arr2=[arr1 mutableCopy];
    [arr1 removeObject:@"b"];
    //arr1:@"a", @"c"
    //arr2:@"a", @"b", @"c"
    
    
    NSMutableArray * juZhen = [[NSMutableArray alloc] initWithObjects:@[@1,@2,@3,@4,@5],@[@1,@2,@3,@4,@5],@[@1,@2,@3,@4,@5],@[@1,@2,@3,@4,@5],@[@1,@2,@3,@4,@5], nil];
    for (int i = 0; i<5; i++) {
        NSLog(@"%p",juZhen[i]);
    };
    NSMutableArray * tmpArr = [juZhen[0] mutableCopy];
    [tmpArr setObject:@7 atIndexedSubscript:0];
    [tmpArr removeObjectAtIndex:0];
    [tmpArr insertObject:@7 atIndex:0];
//    NSLog(@"%lu",(unsigned long)[juZhen[0] objectAtIndex:0]);
    //juZhen没有变
    //只有tmpArr变 7 2 3 4 5
    
    NSMutableArray * arrJuZhen = [NSMutableArray arrayWithObjects:@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5, nil];
    //修改第2行3列为7
    NSInteger  lineNO = 2;
    NSInteger  arrowNO = 3;
    NSInteger  index = (lineNO - 1)*5 + arrowNO;
    arrJuZhen[index] = @7;
    //修改成功
    
   NSInteger color = 0xffffff - 0x111111;
    //如何将一个NSInteger，按照十六进制输入
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
