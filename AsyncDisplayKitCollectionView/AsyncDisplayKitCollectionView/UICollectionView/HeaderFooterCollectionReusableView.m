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
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
        _textLabel.font = [UIFont systemFontOfSize:18.0];
        _textLabel.textColor = [UIColor whiteColor];
        [_textLabel setText:text];
        [_textLabel setCenter:self.center];
        [self addSubview:_textLabel];
    }
    
    return self;
}

-(void)updateHeaderFooterViewText:(NSString *)text{
    [_textLabel setText:text];
}
@end
