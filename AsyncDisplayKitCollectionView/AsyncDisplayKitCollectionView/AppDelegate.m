//
//  AppDelegate.m
//  AsyncDisplayKitCollectionView
//
//  Created by 乔丹丹 on 2017/3/7.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "AppDelegate.h"
// 用AsyncDisplayKit实现的
//#import "ViewController.h"
// 用Apple源生控件实现的
#import "NativeViewController.h"
// 用GIFNetworkImageNode实现的gif动图的展示 跟SDWebImage对比
#import "GIFNetworkImageNodeViewController.h"

// ASViewController 和 tabBar 的Demo 跟源生的实现方式进行对比 看好处在哪里 有什么不同的
// UIWindow 的自定义的子类
#import "WindowWithStatusBarUnderlay.h"
//tabBar 三个控制器
#import "PhotoFeedListKitViewController.h"
#import "PhotoFeedNodeController.h"
#import "PhotoFeedViewController.h"

#import "Utilities.h"



@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
    /*
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.window.backgroundColor = [UIColor whiteColor];
    // 用AsyncDisplayKit实现的 CollectionView
//    ViewController * vc = [[ViewController alloc] init];
    // 用 UICollectionView 实现的 CollectionView
//    NativeViewController * vc = [[NativeViewController alloc] init];
    // GIFNetworkImageNode 实现的gif 图片下载 和 SD进行对比 
    GIFNetworkImageNodeViewController * vc = [[GIFNetworkImageNodeViewController alloc] init];
    UINavigationController * navc = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = navc;
    [self.window makeKeyWindow];
    [self.window makeKeyAndVisible];

   */
    //***********************************************//
    //****** ASViewController 和 tabBar 的Demo*******//
    //***********************************************//
    
    // 这个UIWindow的子类window 对于 设置status bar opaque(不透明)是很有必要的
    _window = [[WindowWithStatusBarUnderlay alloc] init];
    _window.backgroundColor = [UIColor whiteColor];
    
    // 设置TabBar的各个控制器
    
    // ASDK Home Feed viewController & navController
    PhotoFeedNodeController * vcASDK = [[PhotoFeedNodeController alloc] init];
    UINavigationController * navcASDK = [[UINavigationController alloc] initWithRootViewController:vcASDK];
    navcASDK.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@""] tag:0];
    navcASDK.hidesBarsOnSwipe = YES;
    
    // ListKit Home Feed viewController & navController
    PhotoFeedListKitViewController * vcListKit = [[PhotoFeedListKitViewController alloc] init];
    UINavigationController * navcListKit = [[UINavigationController alloc] initWithRootViewController:vcListKit];
    navcListKit.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@""] tag:0];
    navcListKit.hidesBarsOnSwipe = YES;
    
    // UIKit Home Feed viewController & navController
    PhotoFeedViewController * vcUIKit = [[PhotoFeedViewController alloc] init];
    UINavigationController * navcUIKit = [[UINavigationController alloc] initWithRootViewController:vcUIKit];
    navcUIKit.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@""] tag:0];
    navcUIKit.hidesBarsOnSwipe = YES;
    
    // UITabBarController
    UITabBarController * tabBarC = [[UITabBarController alloc] init];
    tabBarC.viewControllers = @[navcUIKit,navcASDK,navcListKit];
    tabBarC.delegate = self;
    [[UITabBar appearance] setTintColor:[UIColor darkBlueColor]];
    
    _window.rootViewController = tabBarC;
//    [_window makeKeyWindow];
    [_window makeKeyAndVisible];
    
    
    // Nav Bar appearance
    NSDictionary * attributeDict = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:attributeDict];
    [[UINavigationBar appearance] setBarTintColor:[UIColor darkBlueColor]];
    [[UINavigationBar appearance] setTranslucent:NO];
    
    // iOS8 hides the status bar in landscape orientation, this forces the status bar hidden status to NO
//    [application setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
//    [application setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    
//    [UIViewController prefersStatusBarHidden...]替换
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
