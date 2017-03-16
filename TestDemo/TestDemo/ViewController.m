//
//  ViewController.m
//  TestDemo
//
//  Created by 乔丹丹 on 2017/2/23.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "ViewController.h"
//#import "QDObject.h"
#import <objc/runtime.h>
#import <objc/objc.h>
#import <objc/message.h>
#import "Son.h"
#import "TestIMP.h"


@interface ViewController ()

@property(nonatomic)NSArray * arrDefault;
@property(nonatomic,strong)NSArray * arrStrong;
@property(nonatomic,weak)NSArray * arrWeak;
@property(nonatomic,assign)NSArray * arrAssign;

@property(copy)NSMutableArray * nameCopyArray;
// 没有指明是nonatomic 就说明是 atomic 的

@property(nonatomic,copy)NSString * string;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"test everything";
    
    //test search IMP
    [self testSearchIMP];
    
    // test Message
//    [self testMessage];
    
    // KVO 还没有成功出发方法，找原因
//    [self testKVO];
    
//    [self testMRCARC];
    
//    [self test_objc_storeWeak];
    
//    QDObject * objInstance = [[QDObject alloc] init];
    
//    [self test];
    
    //const和指针的辨析
//    [self testConst];
    
//    //指针的辨析
//    [self testPointer];
    
    // NSArray 的 copy 的测试
//    [self testNSMutableArrayCopy];
    
    // test NSMutableArray 为nil的时候 操作 会不会崩溃
//    [self testArrayNil];
    
    // test Father & Son Class
//    [self testFatherAndSon];
    
    // test Dispatch Sync Main Queue
//    [self testDispatchSync];
}

#pragma mark - test search IMP
-(void)testSearchIMP{
    
    TestIMP * testInstance1 = [[TestIMP alloc] init];
//    TestIMP * testInstance2 = [[TestIMP alloc] init];
    
}

#pragma mark - test Message
-(void)testMessage{
    
    Son * son = [[Son alloc] init];
    [son logTheSonMessage];
    [son logTheFatherMessage];
//    [son logNone];
//    objc_msgSend(son,@selector(logNone));
   // 我怎么创建出来一个unrecognized selector send to instance例子呢
    
    //  给类的实例发送消息，会先通过实例的isa到类的方法列表里寻找方法，如果没有，到父类的方法列表里寻找方法。
    // 如果在最顶层的父类中，依然没有对应的方法，就会报错 unrecognized selector send to instance
    // 但是在崩溃之前 objc的运行时会给出三次拯救程序崩溃的机会
    
    // 1.Method resolution
    // 2.Fast forwarding
    // 3.Normal forwarding
}
#pragma mark - test KVO 观察者模式
-(void)testKVO{
    
    [self.string addObserver:self forKeyPath:@"array" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    //   addObserver:<#(nonnull NSObject *)#> forKeyPath:<#(nonnull NSString *)#> options:<#(NSKeyValueObservingOptions)#> context:<#(nullable void *)#>]
    
    self.string = [NSString stringWithFormat:@"qiao"];
    NSString * stringNew = [NSString stringWithFormat:@"dan"];
    self.string = stringNew;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"array"]) {
        //是我要观察的那个
        NSLog(@"是我要观察的那个");
    }
}
#pragma mark - test Dispatch Sync Main Queue
-(void)testDispatchSync{
    
    NSLog(@"1");
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"2");
    });
    NSLog(@"3");
}


#pragma mark - test Father & Son Class
-(void)testFatherAndSon{
    Son * son = [[Son alloc] init];
    NSLog(@"%@",son);
}

#pragma mark - test NSMutableArray 为nil的时候 操作 会不会崩溃
-(void)testArrayNil{
    NSMutableArray * array = [NSMutableArray arrayWithObjects:@"qiao",@"dan",@"er", nil];
    array = nil;
    [array removeAllObjects];
    NSLog(@"%@",array);
}

// 当NSmutableArray用copy修饰的时候，会遇到什么问题
#pragma mark - 当NSmutableArray用copy修饰的时候，会遇到什么问题
-(void)testNSMutableArrayCopy{
    NSMutableArray * array = [NSMutableArray arrayWithObjects:@"qiao",@"dan",@"erGouzi", nil];
//    [array removeObjectAtIndex:0];   // 在这 可以正常 没有问题
    self.nameCopyArray = array;
    [self.nameCopyArray removeObjectAtIndex:0];  //这里就会奔溃，找不到这个方法
    // Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[__NSArrayI removeObjectAtIndex:]: unrecognized selector sent to instance 0x174245e50'
    
    // 说明用 copy 修饰 NSMutableArray属性的时候， setter方法里是copy，copy是不可变的copy，所以是没有草垛的方法的
}

#pragma mark - MRC & ARC
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"Default:%@",self.arrDefault);
    NSLog(@"Strong:%@",self.arrStrong);
//    NSLog(@"Assign:%@",self.arrAssign);//报错，访问了已经释放了的内存地址
    NSLog(@"Weak:%@",self.arrWeak);
    // 打印出来是 null weak释放回收之后，会赋值nil（是在强引用归零的时候，什么时候强引用归零了？这个就一个弱引用，所以弱引用赋值之后，代码块执行完之后，会检查，没有强引用就释放掉了，所以后来我们就看不到了） 但是assign不会在强引用归零的时候进行置为nil的操作
    NSLog(@"--------------------\n");
}

#pragma mark - MRC & ARC
-(void)testMRCARC{
    
    self.arrDefault = [NSArray arrayWithObjects:[NSString stringWithFormat:@"defaultARR"], nil];
    self.arrWeak = [NSArray arrayWithObjects:[NSString stringWithFormat:@"weakARR"], nil];
    self.arrAssign = [NSArray arrayWithObjects:[NSString stringWithFormat:@"assignARR"], nil];;
    self.arrStrong = [NSArray arrayWithObjects:[NSString stringWithFormat:@"strongARR"], nil];
    
    NSLog(@"%@",self.arrDefault);
    NSLog(@"%@",self.arrStrong);
    NSLog(@"%@",self.arrAssign);
    NSLog(@"%@",self.arrWeak);
    NSLog(@"--------------------\n");
}

#pragma mark - objc_storeWeak && objc_removeWeak
-(void)test_objc_storeWeak{

    id a = [NSObject new];
    id b = [NSObject new];
    id c;
    printf("a------%p\n",a);
    printf("b------%p\n",b);
    printf("c------%p\n",c);
    /*
     输出：
     a------0x17401c670
     b------0x17401c6a0
     c------0x0
     a b 地址相差了 48个单位 说明
     */
    objc_storeWeak(&c, a);
    
    printf("a------%p\n",a);
    printf("b------%p\n",b);
    printf("c------%p\n",c);
    /*
     输出：
     a------0x170012c20
     b------0x170012bf0
     c------0x0
     
     a------0x170012c20
     b------0x170012bf0
     c------0x170012c20
     */
    objc_storeWeak(&c, b);  // 报错
    /*
     为什么会报错：
     c是之前通过直接把a store进来的 没有经过注册，所以 进行第二次store的时候，要remove旧值，在remove的时候就会需要进行验证entry->inline_referrers[i]数组中是否有entry->inline_referrers[i] == old_referrer，有的话 就将这个数组的元素置为nil，所以这个不会找到旧值
     */
    printf("a------%p\n",a);
    printf("b------%p\n",b);
    printf("c------%p\n",c);
    
    /*
     输出效果：
     a------0x170016300
     b------0x170016310
     c------0x0
     a------0x170016300
     b------0x170016310
     c------0x170016300
     objc[1396]: Attempted to unregister unknown __weak variable at 0x16fd6de98. This is probably incorrect use of objc_storeWeak() and objc_loadWeak(). Break on objc_weak_error to debug.
     
     a------0x170016300
     b------0x170016310
     c------0x170016310
     */
    
    //为什么会造出来这个错呢？
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

#pragma mark - selector的本质是char * 的验证
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
    
    
    //还可以这样获取 SEL的name
     char * nameGet = sel_getName(sel_1);
    NSLog(@"--------------%s",nameGet);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
