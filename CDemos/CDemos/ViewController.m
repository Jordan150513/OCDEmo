//
//  ViewController.m
//  CDemos
//
//  Created by 乔丹丹 on 17/1/30.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"C Demos";
    
    simpleFunc();
    printName();
    
}


int simpleFunc(void){
    int num;
    num = 1;
    printf("i am a simple ");
    printf("computer !");
    printf("my favorate number is %d because it is the first !\n",num);
    
    
    float weight;
    float value;
    printf("please input your weight in pounds \n");
    //在Xcode中，scanf()方法，竟然没有等键盘的输入？？？？
    scanf("%f",&weight);
    value = 1700.0*weight*14.5833;
    printf("is worth $ %.2f.\n",value);
    printf("--------------\n");
    int x = 100;
    printf("dec = %d; octal = %o; hex = %x;\n",x,x,x);
    printf("dec = %d; octal = %#o; hex = %#x;\n",x,x,x);
    //可以用这种角度来优化之前写的颜色的渐进效果，随机数的选择范围渐进变小
    return 0;
}

int printName(){
    //printf()执行完之后不会自动换行。
    //记得有一个方法，可以输出之后自动换行的？？？
    printf("qiao dan");
    printf("qiao \n dan");
    printf("qiao");
    printf("dan");
    printf("\n------------------\n");
    return 0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
