//
//  DDBlurPresentationController.h
//  DDBlurPresention
//
//  Created by 乔丹丹 on 16/6/2.
//  Copyright © 2016年 Fang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DDBlurPresentationController;

@protocol DDBlurPresentationControllerDelegate <NSObject>

- (void)presentationControllerDidDismissed:(DDBlurPresentationController *)controller;

@end

@interface DDBlurPresentationController : UIPresentationController

@property(nonatomic,assign)UIBlurEffectStyle blurStyle;
@property(nonatomic,weak)id<DDBlurPresentationControllerDelegate> dd_presentationDelegate;
- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController style:(UIBlurEffectStyle)style;
@end
