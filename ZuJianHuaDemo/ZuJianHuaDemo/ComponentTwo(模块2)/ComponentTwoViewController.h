//
//  ComponentTwoViewController.h
//  ZuJianHuaDemo
//
//  Created by 乔丹丹 on 2017/2/21.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComponentTwoViewController : UIViewController
-(instancetype)initWithId:(NSString *)id andType:(NSInteger)type;
+(UIViewController *)createComponentTwoViewController:(NSString *)someId andType:(NSInteger)type;
@end
