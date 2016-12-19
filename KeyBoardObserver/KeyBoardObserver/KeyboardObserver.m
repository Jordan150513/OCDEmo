//
//  KeyBoardObeserver.m
//  onepage
//
//  Created by wangchao on 16/4/14.
//  Copyright © 2016年 Saunter Studio. All rights reserved.
//

#import "KeyboardObserver.h"

@interface KeyboardObserver ()
@property (strong, nonatomic) NSNotificationCenter *keyboardObserver;
@property (assign, nonatomic) BOOL keyboardObserverEnabled;
@property (strong, nonatomic) KeyboardInfo *keyboardInfo;
@property (assign, nonatomic) NSInteger appearNotificationCount;
@property (copy, nonatomic) AnimatWhenKeyboardAppear animateWhenKeyboardAppear;
@property (copy, nonatomic) AnimatWhenKeyboardDisappear animatedWhenKeyboardDisappear;

@end

@implementation KeyboardObserver

- (instancetype)initWithAnimateWhenKeyboardAppear:(AnimatWhenKeyboardAppear)animateWhenKeyboardAppear animateWhenKeyboardDisappear:(AnimatWhenKeyboardDisappear)animatedWhenKeyboardDisappear {
    if (self = [super init]) {
        self.animateWhenKeyboardAppear = animateWhenKeyboardAppear;
        self.animatedWhenKeyboardDisappear = animatedWhenKeyboardDisappear;
        self.appearNotificationCount = 0;
    }
    return self;
}

#pragma mark - dealloc

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)handleKeyboardWithNotification:(NSNotification *)notification action:(KeyboardAction)action {
//    NSLog(@"%@", notification);
    NSDictionary *userInfo = notification.userInfo;
    NSTimeInterval animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    CGRect frameBegin = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect frameEnd = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat currentHeight = frameEnd.size.height;
    CGFloat previousHeight = self.keyboardInfo.height;
    CGFloat heightIncrement = currentHeight - previousHeight;
    BOOL isSameKeyboardAction;
    if (action == self.keyboardInfo.keyboardAction) {
        isSameKeyboardAction = YES;
    } else {
        isSameKeyboardAction = NO;
    }
    self.keyboardInfo = [[KeyboardInfo alloc] initWithAnimationDuration:animationDuration
                                                         animationCurve:animationCurve
                                                             frameBegin:frameBegin
                                                               frameEnd:frameEnd
                                                        heightIncrement:heightIncrement
                                                         keyboardAction:action
                                                   isSameKeyboardAction:isSameKeyboardAction];
}

#pragma mark - UIKeyBoardNotification

- (void)keyboardWillShow:(NSNotification *)notification {
    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateBackground) {
        return;
    }
    [self handleKeyboardWithNotification:notification action:KeyboardAction_Show];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateBackground) {
        return;
    }
    if (self.keyboardInfo.keyboardAction == KeyboardAction_Show) {
        [self handleKeyboardWithNotification:notification action:KeyboardAction_Show];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateBackground) {
        return;
    }
    [self handleKeyboardWithNotification:notification action:KeyboardAction_Hide];
}

- (void)keyboardDidHide:(NSNotification *)notification {
    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateBackground) {
        return;
    }
    self.keyboardInfo = nil;
}

#pragma mark - Setter

- (void)setAnimateWhenKeyboardAppear:(AnimatWhenKeyboardAppear)animateWhenKeyboardAppear {
    self.keyboardObserverEnabled = YES;
    _animateWhenKeyboardAppear = animateWhenKeyboardAppear;
}

- (void)setAnimatedWhenKeyboardDisappear:(AnimatWhenKeyboardDisappear)animatedWhenKeyboardDisappear {
    self.keyboardObserverEnabled = YES;
    _animatedWhenKeyboardDisappear = animatedWhenKeyboardDisappear;
}

- (void)setKeyboardObserverEnabled:(BOOL)keyboardObserverEnabled {
    if (_keyboardObserverEnabled != keyboardObserverEnabled) {
        self.keyboardObserver = keyboardObserverEnabled ? [NSNotificationCenter defaultCenter] : nil;
        _keyboardObserverEnabled = keyboardObserverEnabled;
    }
}

- (void)setKeyboardObserver:(NSNotificationCenter *)keyboardObserver {
    if (_keyboardObserver != keyboardObserver) {
        [_keyboardObserver removeObserver:self];
    }
    if (keyboardObserver) {
        [keyboardObserver addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [keyboardObserver addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        [keyboardObserver addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        [keyboardObserver addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    }
    _keyboardObserver = keyboardObserver;
}

- (void)setKeyboardInfo:(KeyboardInfo *)keyBoardInfo {
    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateBackground) {
        return;
    }
    
    if (!keyBoardInfo.isSameKeyboardAction || keyBoardInfo.heightIncrement != 0) {
        [UIView animateWithDuration:keyBoardInfo.animationDuration delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            [UIView setAnimationCurve:keyBoardInfo.animationCurve];
            switch (keyBoardInfo.keyboardAction) {
                case KeyboardAction_Show:
                    self.animateWhenKeyboardAppear(0, keyBoardInfo.height, keyBoardInfo.heightIncrement);
                    self.appearNotificationCount += 1;
                    break;
                case KeyboardAction_Hide:
                    self.animatedWhenKeyboardDisappear(keyBoardInfo.height);
                    self.appearNotificationCount = 0;
                    break;
                default:
                    break;
            }
        } completion:^(BOOL finished) {
        }];
    }
}

@end

@implementation KeyboardInfo

- (instancetype)initWithAnimationDuration:(NSTimeInterval)animationDuration
                           animationCurve:(UIViewAnimationCurve)animationCurve
                               frameBegin:(CGRect)frameBegin
                                 frameEnd:(CGRect)frameEnd
                          heightIncrement:(CGFloat)heightIncrement
                           keyboardAction:(KeyboardAction)keyboardAction
                     isSameKeyboardAction:(BOOL)isSameKeyboardAction {
    if (self = [super init]) {
        _animationDuration = animationDuration;
        _animationCurve = animationCurve;
        _frameBegin = frameBegin;
        _frameEnd = frameEnd;
        _heightIncrement = heightIncrement;
        _keyboardAction = keyboardAction;
        _isSameKeyboardAction = isSameKeyboardAction;
    }
    return self;
}

- (CGFloat)height {
    return _frameEnd.size.height;
}

@end




