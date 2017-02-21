//
//  ComponentOneViewController.h
//  ZuJianHuaDemo
//
//  Created by 乔丹丹 on 2017/2/21.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComponentOneViewController : UIViewController

-(instancetype)initWithId:(NSString *)id;
+ (UIViewController *)createComponentOneViewController:(NSString *)someId;
@end
