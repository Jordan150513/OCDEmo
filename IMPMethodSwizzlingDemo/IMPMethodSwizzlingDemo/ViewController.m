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
 就是+load()和+initialize()有什么区别？
 那个时候没有回答上来，没有辨识到，需要去探究！！！
 
 //参考：https://developer.apple.com/reference/objectivec/nsobject NSObject Class Reference
 
 class func load()
 
 Invoked whenever a class or category is added to the Objective-C runtime; implement this method to perform class-specific behavior upon loading.
 当类被添加进入运行时的时候，就会触发+load()方法，将类加载进运行时
 
 The load() message is sent to classes and categories that are both dynamically loaded and statically linked, but only if the newly loaded class or category implements a method that can respond.
 The order of initialization is as follows:
 All initializers in any framework you link to.
 All +load methods in your image.
 All C++ static initializers and C/C++ __attribute__(constructor) functions in your image.
 All initializers in frameworks that link to you.
 In addition:
 A class’s +load method is called after all of its superclasses’ +load methods.
 A category +load method is called after the class’s own +load method.
 In a custom implementation of load() you can therefore safely message other unrelated classes from the same image, but any load() methods implemented by those classes may not have run yet.
 Important
 Custom implementations of the load method for Swift classes bridged to Objective-C are not called automatically
 
 当动态加载和链接库的时候load()消息会被发送给该类或者分类，只有仅当新加载到运行时的类或者分类才会相应发送这个消息。
 initialization的顺序：
 链入框架的所有initializers
 镜像中的所有+load()
 所有C++静态的initializers和镜像中的C/C++ __attribute__(constructor)构造方法
 链入的库的所有的initializers
 
 另外：
 类所有的父类的+load执行完之后才执行这个类的load方法
 类的原本的load方法执行完之后，才执行分类的load方法
 在一个自定义实现的load()中，给其他相关的类发送消息是安全的，但是这些类的load()方法还没有运行
 
 重要的一点：
 Swift自定义load()桥接OC代码之后，不会自动调用
 
 class func initialize()
 
 Initializes the class before it receives its first message.
 在接收消息之前，初始化类
 
 The runtime sends initialize() to each class in a program just before the class, or any class that inherits from it, is sent its first message from within the program. Superclasses receive this message before their subclasses.
 The runtime sends the initialize() message to classes in a thread-safe manner. That is, initialize() is run by the first thread to send a message to a class, and any other thread that tries to send a message to that class will block until initialize() completes.
 The superclass implementation may be called multiple times if subclasses do not implement initialize()—the runtime will call the inherited implementation—or if subclasses explicitly call [super initialize]. If you want to protect yourself from being run multiple times, you can structure your implementation along these lines:

 对于每一个类，runtime都会在（这个类或者）这个类的任何分类之前发送initialize()消息给这个类，这个消息是这个类的第一个接收到的消息，父类的这个消息会早于子类接收到。（父类的+initialize()会比子类的先调用）
 运行时会在一个线程安全的机制下发送initialize()消息给这个类，也就是说，initialize()是被第一个的线程来发送消息给这个类的，在initialize()消息发送完成之前，任何其他的线程都必须被阻塞。
 如果子类没有实现initialize()，那么就会调用父类的initialize()，子类也可能会明确的[super initialize]调用父类的实现。initialize()的调用有继承性
 
 
 -(instancetype)init
 
 */

+(void)load{
    NSLog(@"%@ %s", [self class], __FUNCTION__);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method viewDidLoad = class_getInstanceMethod(self, @selector(viewDidLoad));
        
        Method viewDidLoadSwizzlingMethond = class_getInstanceMethod(self, @selector(viewDidLoadSwizzlingMethond));
        
        method_exchangeImplementations(viewDidLoad, viewDidLoadSwizzlingMethond);
    });
}

+(void)initialize{
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

-(instancetype)init{
    if (self = [super init]) {
        
    }
    NSLog(@"%@ %s", [self class], __FUNCTION__);
    return self;
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
