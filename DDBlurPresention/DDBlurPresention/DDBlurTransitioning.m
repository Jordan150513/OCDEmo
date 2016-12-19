//
//  DDBlurTransitioning.m
//  DDBlurPresention
//
//  Created by 乔丹丹 on 16/6/2.
//  Copyright © 2016年 Fang. All rights reserved.
//

#import "DDBlurTransitioning.h"

@implementation DDBlurTransitioning
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{

    return 0.5;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController * fromeViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView * fromeView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    UIView * containerView = [transitionContext containerView];
    if (self.isPresentation) {
        [containerView addSubview:toView];
    }
    
    UIViewController * animatingViewController = self.isPresentation?toViewController:fromeViewController;
    UIView * animatingView = self.isPresentation?toView:fromeView;
    
    CGRect onScreenFrame = [transitionContext finalFrameForViewController:animatingViewController];
    CGRect offScreenFrame = CGRectOffset(onScreenFrame, 0, onScreenFrame.size.height);
    
    CGRect initialFrame = self.isPresentation ? offScreenFrame : onScreenFrame;
    CGRect finalFrame = self.isPresentation ? onScreenFrame : offScreenFrame;
    animatingView.frame = initialFrame;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:300.0 initialSpringVelocity:5.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        animatingView.frame = finalFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}
@end
