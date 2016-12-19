//
//  DDBlurPresenter.h
//  DDBlurPresention
//
//  Created by 乔丹丹 on 16/6/2.
//  Copyright © 2016年 Fang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DDBlurPresenter : NSObject<UIViewControllerTransitioningDelegate>
@property(nonatomic,assign)UIBlurEffectStyle blurStyle;
@end
