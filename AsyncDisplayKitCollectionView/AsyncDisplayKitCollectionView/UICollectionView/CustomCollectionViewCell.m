//
//  CustomCollectionViewCell.m
//  AsyncDisplayKitCollectionView
//
//  Created by 乔丹丹 on 2017/3/7.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@interface CustomCollectionViewCell ()
@property(nonatomic,strong)UILabel * textLabel;
@end

@implementation CustomCollectionViewCell
-(instancetype)initWIthText:(NSString *)text{
    self = [super init];
    if (self!=nil) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont systemFontOfSize:15.0];
        _textLabel.textColor = [UIColor whiteColor];
        [_textLabel setCenter: self.center];
        [_textLabel setText:text];
        [self addSubview:_textLabel];
        
        [self updateBackgroundColor];
    }
    return self;
}
- (void)updateBackgroundColor
{
    if (self.highlighted) {
        self.backgroundColor = [UIColor grayColor];
    } else if (self.selected) {
        self.backgroundColor = [UIColor darkGrayColor];
    } else {
        self.backgroundColor = [UIColor lightGrayColor];
    }
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    [self updateBackgroundColor];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    [self updateBackgroundColor];
}
@end
