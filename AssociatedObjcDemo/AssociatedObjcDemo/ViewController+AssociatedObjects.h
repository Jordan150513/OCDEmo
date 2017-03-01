//
//  ViewController+AssociatedObjects.h
//  AssociatedObjcDemo
//
//  Created by 乔丹丹 on 2017/2/28.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (AssociatedObjects)

@property(nonatomic,strong) NSString * strongProperty;
@property(nonatomic,assign) NSString * assignProperty;
//@property(nonatomic,weak) NSString * weakProperty;
@property(nonatomic,copy) NSString * copyProperty;
@end
