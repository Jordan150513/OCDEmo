//
//  HeaderFooterCollectionReusableView.m
//  AsyncDisplayKitCollectionView
//
//  Created by 乔丹丹 on 2017/3/7.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "HeaderFooterCollectionReusableView.h"

@interface HeaderFooterCollectionReusableView ()
@property(nonatomic,strong)UILabel * textLabel;

@end

@implementation HeaderFooterCollectionReusableView

-(instancetype) init{
    if (self = [super init]) {
        UILabel * label  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        label.font = [UIFont systemFontOfSize:18.0];
        label.textColor = [UIColor greenColor];
        [self addSubview:label];
        _textLabel = label;
    }
    
    return self;
}
-(void)updateHeaderFooterViewText:(NSString *)text{
    [self.textLabel setText:text];
}

-(UILabel *)textLabel{
    if (_textLabel==nil) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        _textLabel.font = [UIFont systemFontOfSize:15.0];
        _textLabel.textColor = [UIColor greenColor];
//        _textLabel.backgroundColor = [UIColor greenColor];
//        [_textLabel setCenter: self.center]; // 就这句话 非常讨厌 引起的label显示 各种问题 不显示 显示错位置
        [self addSubview:_textLabel];
    }
    return _textLabel;
}
@end
