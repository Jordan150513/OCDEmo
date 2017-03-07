//
//  ItemNode.m
//  AsyncDisplayKitCollectionView
//
//  Created by 乔丹丹 on 2017/3/7.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "ItemNode.h"

@implementation ItemNode
-(instancetype)initWithText:(NSString *)text{
    self = [super init];
    if (self!=nil) {
        self.text = text;
        [self updateBackgroundColor];
    }
    
    return self;
}

// 根据状态更改 背景颜色
-(void)updateBackgroundColor{

    if (self.isHighlighted) {
        self.backgroundColor = [UIColor grayColor];
    }else if (self.isSelected){
        self.backgroundColor = [UIColor darkGrayColor];
    }else{
        //默认情况下的状态
        self.backgroundColor = [UIColor lightGrayColor];
    }
}

// 状态的更改
-(void)setSelected:(BOOL)selected{

    [super setSelected:selected];
    [self updateBackgroundColor];
}

-(void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    [self updateBackgroundColor];
}
@end
