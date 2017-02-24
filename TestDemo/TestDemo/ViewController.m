//
//  ViewController.m
//  TestDemo
//
//  Created by 乔丹丹 on 2017/2/23.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self test];
    
    //const和指针的辨析
    [self testConst];
    
//    //指针的辨析
//    [self testPointer];
    
}

#pragma mark - 指针的辨析
-(void)testPointer{
    //指针的辨析：
    int a = 100;
//    &a; 就是a的地址
    int * p = &a;
    NSLog(@"%d",a);//100    a：就是变量a存储的值
    NSLog(@"%p",p);//0x16fd0de9c  p：就是指针p存储的值，p存储的只是a的地址，也就是通俗的说，p指向了a变量
    NSLog(@"%d",*p);//100  * p 就是p指针所指向的地址所存储的值
    // *p是什么？是指针p所指向的变量 是指针这个值所指向的那个地址所存储的变量的值
    //   & 取地址符 b变量里存的是500 &b取的是b变量的地址，p是指针，指向了变量b的地址
}

#pragma mark - const的辨析
-(void)testConst{

    //const的辨析： const * 和 * const的辨别 const的使用
    
//    [self pointConstZero];
    
//    [self pointConstOne];
    
//    [self pointConstTwo];
    
    /*
     const int * p1 = &b;
     int const * p2 = &b;
     是等同的，const在 * 的左边 是同一种情况
     小总结一下：也就是不能通过指针改变指针所指向的变量的值，但是可以通过变量a自己改变变量的值
     
     */
//    [self pointConstThree];
    // * const ：const在*的右边：说明指针本身不能变，也就是指针的指向不能变
    
//    [self pointConstFour];

}

#pragma mark - const第4种
-(void)pointConstFour{

    //const第4种：
    int b = 500;
    const int * const p4 = &b;
//    p4++;//报错：can not to assign to variable 'p4' with const-qualified type 'const int * const'
//    *p4 = *p4+2;//报错：read0-only variable is not assignable
    //指针的指向不能变，指针指向的对象也不能变
}

#pragma mark - const第3种
-(void)pointConstThree{
    
    //const第3种：
    int b = 500;
    int * const p3 = &b;
//    p3++;//报错：can not assign to variable 'p3' with const-qualified type 'int * const'
    //指针不能变，也就是指针自己的值不能变，也就是指针的指向不能变
}

#pragma mark - const第2种
-(void)pointConstTwo{
    
    //const第2种：
    int b = 500;
    int const * p2 = &b; //*p 不能改变 不能通过 *p变化，但是可以通过变量本身a自己变化
    //也就是不能通过指针改变指针所指向的变量的值
    NSLog(@"%d",*p2);
//    *p2 = *p2+1;
    //同第一种情况，这种情况都是一样的 *p 不能改变
    b++;
    NSLog(@"%d",*p2);
}

#pragma mark - const第1种： const int * p1 ：*p 不能变
-(void)pointConstOne{
    
    //const第1种： const int * p1 ：*p 不能变
    int b = 500;
    int * p = &b;
    const int * p1 = &b; //*p不能变 指针指向的这个变量不能变 但是变量自己可以变？？
    //    int c = 1000;
    
    NSLog(@"%d",b); //500
    NSLog(@"%p",p1); //0x16fd89e9c
    NSLog(@"%p",p);  //0x16fd89e9c
    b++;
    p1++;
    //    p++;
    NSLog(@"%d",b);  //501
    NSLog(@"%p",p1); //0x16fd89ea0 p1指针的指向向高位移动了4
    NSLog(@"%p",p);  //0x16fd89ea0 p1指针的指向向高位移动了4 指针的指向变了
    NSLog(@"---------------");
    //    * p1 = * p +1;//报错 read-only variable is not assignable
    NSLog(@"%d",*p);
    * p = * p +1; //* p +1：指针p存储的地址的 这个地址存储的值+1 也就是指针指向的变量加1
    NSLog(@"%p",p);
    NSLog(@"%d",*p);
    //    NSLog(@"%p",&c);

}

#pragma mark - const第0种：基本的
-(void)pointConstZero{
    //const第0种：
    int b = 500;
    
        b++;
        NSLog(@"%d",b);
    
       const int b1 = 600; //b1变量的值是不能变的
//        b1++;
        //这样就会有错误 can not assign to variable 'b1' with const-qualified type 'const int'
        NSLog(@"%d",b1);
}




#pragma mark -test 1、 objc_selector 的本质是一个char * 字符串

// objc_selector 的定义在源码中并没有给出，网上的说法是映射到一个 char * 字符串
// 也就是本质上是一个 char * 字符串
// 经过下面的实验，确实如此  struct objc_selector *  == SEL == char *

- (void)methedWithStr1:(NSString *)str1 str2:(NSString *)str2 {
    NSLog(@"%@,%@", str1, str2);
}

- (void)test {
    struct objc_selector * sel_1 = @selector(methedWithStr1:str2:);
    SEL sel_2 = @selector(methedWithStr1:str2:);
    if (sel_1 == sel_2) {//会 警告 ： 比较 指向不同类型的指针 其实是一样的
        NSLog(@"一样");    // 确实一样
    } else {
        NSLog(@"不一样");
    }
    // 转为 char *
    char * str_1 = (char *)sel_1;
    printf("%s\n", str_1);  // methedWithStr1:str2:
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
