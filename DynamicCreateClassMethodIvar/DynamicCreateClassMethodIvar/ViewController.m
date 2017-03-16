//
//  ViewController.m
//  DynamicCreateClassMethodIvar
//
//  Created by 乔丹丹 on 2017/3/16.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Dynamic Create";
    
    // 1、动态增加类
    
    //    objc_allocateClassPair(<#__unsafe_unretained Class superclass#>, <#const char *name#>, <#size_t extraBytes#>)
    // 第一个参数，指明superclass，第二个 指明 类的名 第三个参数 指明 额外的内存空间
    
    Class myClass = objc_allocateClassPair([NSObject class], "Person", 0);
    
    // 2. 增加实例变量
    
//    class_addIvar(<#__unsafe_unretained Class cls#>, <#const char *name#>, <#size_t size#>, uint8_t alignment, <#const char *types#>)
    // 第一个参数 指定 class ，第二个参数 指定实例变量的名字 第三个参数 指明 尺寸 size 第四个参数 指明 alignment 第五个参数 指明 Type
    BOOL isSuccess = class_addIvar(myClass, "_name", sizeof(NSString *), 0, "@");
    isSuccess?NSLog(@"添加实例变量成功"):NSLog(@"添加实例变量失败");
    
    // 3.增加方法
    
//    class_addMethod(<#__unsafe_unretained Class cls#>, <#SEL name#>, <#IMP imp#>, <#const char *types#>)
    // 第一个参数 类 第二个参数 方法selector 第三个参数 方法IMP 第四个参数 type
    class_addMethod(myClass, @selector(eat:), (IMP)eat, "V@:");
    
    
    // 5. 创建类的实例
    id instancePerson = [[myClass alloc] init];
    NSLog(@"创建出来的实例对象：%@",instancePerson);
    
    // 6. 给属性赋值
    NSString *str = @"qiao";
    
    // 通过KVC的方式给instancePerson对象的_name属性赋值
    [instancePerson setValue:str forKey:@"_name"];
    
    //调用方法
    [instancePerson eat:@"hamburger"];
    
    // 还有更进一步的 我在方法里如何访问类的属性
    // 就是在 C方法里面 进行获取 创建的类的属性
}



// 4. 添加一个C方法 id self, SEL _cmd,参数是必须的,后面的是需要的参数 可选的 这里 eat:需要一个NSString的参数
static void eat(id self,SEL _cmd,NSString * foodName){
    // 获取类中指定名称实例成员变量的信息
    Ivar ivar = class_getInstanceVariable([self class], "_name");
    
    // 在添加的方法里面 获取 整个成员变量列表
//       Ivar * class_copyIvarList ( Class cls, unsigned intint * outCount );
    unsigned int count;
    class_copyIvarList([self class], &count);
    NSLog(@"%d",count);
    
    // 在添加的类的方法里面 获取类中指定名称实例成员变量的信息
//       Ivar class_getInstanceVariable ( Class cls, const charchar *name );
//    class_getInstanceVariable([self class], "_name");
//    NSLog(@"%@",class_getInstanceVariable([self class], "_name"));//报错了
    // 获取类成员变量的信息
//       Ivar class_getClassVariable ( Class cls, const charchar *name );
    class_getClassVariable([self class], "_name"); //注意上下这两个方法有啥区别啊？ // 这个没有报错
    NSLog(@"%@",class_getClassVariable([self class], "_name"));//这个取出来是null
    
    // 返回名为test的ivar变量的值
    id obj = object_getIvar(self, ivar);
    NSLog(@"%@",obj);
    NSLog(@"eat:参数：%@",foodName);
    NSLog(@"ClassName：%@",NSStringFromClass([self class]));
    
}
//方法的实现
//这个方法实际上没有被调用,但是必须实现否则不会调用addMethodForMyClass()方法
-(void)eat:(NSString *)foodName{
    NSLog(@"我吃%@",foodName);
}

/*
 2017-03-16 11:23:12.050856 DynamicCreateClassMethodIvar[234:12915] 添加实例变量成功
 2017-03-16 11:23:12.051102 DynamicCreateClassMethodIvar[234:12915] 创建出来的实例对象：<Person: 0x170012830>
 2017-03-16 11:23:12.051481 DynamicCreateClassMethodIvar[234:12915] 1
 2017-03-16 11:23:12.051583 DynamicCreateClassMethodIvar[234:12915] qiao
 2017-03-16 11:23:12.051822 DynamicCreateClassMethodIvar[234:12915] eat:参数：hamburger
 2017-03-16 11:23:12.052017 DynamicCreateClassMethodIvar[234:12915] ClassName：Person
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
