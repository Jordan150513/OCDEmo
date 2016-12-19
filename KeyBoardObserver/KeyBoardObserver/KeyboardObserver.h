//
//  KeyBoardObeserver.h
//  onepage
//
//  Created by wangchao on 16/4/14.
//  Copyright © 2016年 Saunter Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^AnimatWhenKeyboardAppear)(NSInteger appearNotificationCount, CGFloat keyboardHeight, CGFloat keyboardHeightIncrement);
typedef void (^AnimatWhenKeyboardDisappear)(CGFloat keyboardHeight);

@interface KeyboardObserver : NSObject

- (instancetype)initWithAnimateWhenKeyboardAppear:(AnimatWhenKeyboardAppear)animateWhenKeyboardAppear
                     animateWhenKeyboardDisappear:(AnimatWhenKeyboardDisappear)animatedWhenKeyboardDisappear;
@end

typedef NS_ENUM(NSUInteger, KeyboardAction) {
    KeyboardAction_Show = 0,
    KeyboardAction_Hide,
};

@interface KeyboardInfo : NSObject

@property (assign, nonatomic) NSTimeInterval animationDuration;
@property (assign, nonatomic) UIViewAnimationCurve animationCurve;

@property (assign, nonatomic) CGRect frameBegin;
@property (assign, nonatomic) CGRect frameEnd;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat heightIncrement;

@property (assign, nonatomic) KeyboardAction keyboardAction;
@property (assign, nonatomic) BOOL isSameKeyboardAction;

- (instancetype)initWithAnimationDuration:(NSTimeInterval)animationDuration
                           animationCurve:(UIViewAnimationCurve)animationCurve
                               frameBegin:(CGRect)frameBegin
                                 frameEnd:(CGRect)frameEnd
                          heightIncrement:(CGFloat)heightIncrement
                           keyboardAction:(KeyboardAction)keyboardAction
                     isSameKeyboardAction:(BOOL)isSameKeyboardAction;

@end