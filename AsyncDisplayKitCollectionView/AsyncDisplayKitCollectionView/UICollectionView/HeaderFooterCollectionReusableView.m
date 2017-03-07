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
-(instancetype)initWithText:(NSString *)text{
    if (self = [super init]) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont systemFontOfSize:18.0];
        _textLabel.textColor = [UIColor whiteColor];
        [_textLabel setText:text];
        [_textLabel setCenter:self.center];
        [self addSubview:_textLabel];
    }
    
    return self;
}
@end
