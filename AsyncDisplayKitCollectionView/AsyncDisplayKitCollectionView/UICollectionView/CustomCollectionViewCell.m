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

//这个int不会被调用，所以 我们重新写了一个可以实现复用init方法，调用这个方法，不知道能不能实现 创建cell的时候 就有了Label成员变量，不会在设置label text的时候才去懒加载创建label
-(instancetype) init{

    if (self = [super init]) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 30)];
        label.font = [UIFont systemFontOfSize:15.0];
        label.textColor = [UIColor whiteColor];
        [label setCenter: self.center];
        _textLabel = label;
        [self addSubview:label];
        //设置默认的背景颜色就好 不需要再添加判断 状态改变的时候 添加状态变化之后的颜色就好
        self.backgroundColor = [UIColor lightGrayColor];
//        [self updateBackgroundColor];
    }
    return self;
}

-(void)updateCellText:(NSString *)text{
    [self.textLabel setText:text];
    
}

-(UILabel *)textLabel{
    if (_textLabel==nil) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 30)];
        _textLabel.font = [UIFont systemFontOfSize:15.0];
        _textLabel.textColor = [UIColor greenColor];
//        _textLabel.backgroundColor = [UIColor greenColor];
//        [_textLabel setCenter: self.center];
        [self addSubview:_textLabel];
    }
    return _textLabel;
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
