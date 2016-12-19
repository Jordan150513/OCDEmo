//
//  DDBlurPresentationController.m
//  DDBlurPresention
//
//  Created by 乔丹丹 on 16/6/2.
//  Copyright © 2016年 Fang. All rights reserved.
//

#import "DDBlurPresentationController.h"

@interface DDBlurPresentationController ()
@property(nonatomic,strong)UIView * effectContainerView;
@property(nonatomic,strong)UIVisualEffectView * dimmingView;
@end

@implementation DDBlurPresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController style:(UIBlurEffectStyle)style{

    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self) {
        UIBlurEffect * effect = [UIBlurEffect effectWithStyle:style];
        _dimmingView = [[UIVisualEffectView alloc] initWithEffect:effect];
        _blurStyle = style;
        _effectContainerView = [UIView new];
        _effectContainerView.alpha = 0.0;
    }
    return self;
}
-(void)presentationTransitionWillBegin{
    self.effectContainerView.frame = self.containerView.bounds;
    self.dimmingView.frame = self.containerView.bounds;
    [self.effectContainerView insertSubview:self.dimmingView atIndex:0];
    [self.containerView insertSubview:self.effectContainerView atIndex:0];
    self.effectContainerView.alpha = 0.0;
    id<UIViewControllerTransitionCoordinator> coordinator = [self.presentedViewController transitionCoordinator];
    if (coordinator) {
        [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            self.effectContainerView.alpha = 1.0;
        } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            
        }];
    }else{
    self.effectContainerView.alpha = 1.0;
    }
}
-(void)dismissalTransitionWillBegin{
    id<UIViewControllerTransitionCoordinator> coordinator = [self.presentedViewController transitionCoordinator];
    if (coordinator) {
        [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            self.effectContainerView.alpha = 0.0;
        } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            
        }];
    }else{
        self.effectContainerView.alpha = 0.0;
    }
}
-(void)dismissalTransitionDidEnd:(BOOL)completed{

    if (completed) {
        if (self.dd_presentationDelegate && [self.dd_presentationDelegate respondsToSelector:@selector(presentationControllerDidDismissed:)]) {
            [self.dd_presentationDelegate presentationControllerDidDismissed:self];
        }
    }
}
-(void)containerViewWillLayoutSubviews{
    self.effectContainerView.frame = self.containerView.bounds;
    self.dimmingView.frame = self.containerView.bounds;
    self.presentedView.frame = self.containerView.bounds;
}
-(BOOL)shouldPresentInFullscreen{

    return YES;
}
-(UIModalPresentationStyle)adaptivePresentationStyle{

    return UIModalPresentationCustom;
}
-(void)setBlurStyle:(UIBlurEffectStyle)blurStyle{
    if (blurStyle != _blurStyle) {
        _blurStyle = blurStyle;
        UIView *previousDimmingView = _dimmingView;
        
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:blurStyle];
        self.dimmingView = [[UIVisualEffectView alloc] initWithEffect:effect];
        NSArray *subviews = [self.effectContainerView subviews];
        for (UIView *view in subviews) {
            if (view == previousDimmingView) {
                self.dimmingView.frame = previousDimmingView.frame;
                [self.effectContainerView insertSubview:self.dimmingView aboveSubview:previousDimmingView];
                [previousDimmingView removeFromSuperview];
            }
        }

    }
}
@end
