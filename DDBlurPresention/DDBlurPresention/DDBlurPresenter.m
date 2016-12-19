//
//  DDBlurPresenter.m
//  DDBlurPresention
//
//  Created by 乔丹丹 on 16/6/2.
//  Copyright © 2016年 Fang. All rights reserved.
//

#import "DDBlurPresenter.h"
#import "DDBlurPresentationController.h"
#import "DDBlurTransitioning.h"

@interface DDBlurPresenter ()<DDBlurPresentationControllerDelegate>

@property(nonatomic,strong)DDBlurPresentationController * animationController;
@end

@implementation DDBlurPresenter
-(instancetype)init{
    self = [super init];
    if (self) {
        _blurStyle = UIBlurEffectStyleDark;
    }
    return  self;
}
-(DDBlurPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    if (!self.animationController) {
        self.animationController = [[DDBlurPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting style:self.blurStyle];
        self.animationController.dd_presentationDelegate = self;
    }
    return self.animationController;
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{

    DDBlurTransitioning *transition = [DDBlurTransitioning new];
    transition.isPresentation = YES;
    return transition;
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    DDBlurTransitioning *transition = [DDBlurTransitioning new];
    transition.isPresentation = NO;
    return transition;
}
- (void)setBlurStyle:(UIBlurEffectStyle)blurStyle {
    if (_blurStyle != blurStyle) {
        _blurStyle = blurStyle;
        self.animationController.blurStyle = blurStyle;
    }
}
//代理方法
-(void)presentationControllerDidDismissed:(DDBlurPresentationController *)controller {
    self.animationController = nil;
}
@end
