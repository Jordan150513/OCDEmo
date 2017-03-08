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
//-(instancetype)initWithText:(NSString *)text{
//    if (self = [super init]) {
//        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
//        _textLabel.font = [UIFont systemFontOfSize:18.0];
//        _textLabel.textColor = [UIColor whiteColor];
//        _textLabel.backgroundColor = [UIColor greenColor];
//        [_textLabel setText:text];
//        [_textLabel setCenter:self.center];
//        [self addSubview:_textLabel];
//    }
//    
//    return self;
//}

-(instancetype) init{
    if (self = [super init]) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        _textLabel.font = [UIFont systemFontOfSize:18.0];
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.backgroundColor = [UIColor greenColor];
        [_textLabel setCenter:self.center];
        [self addSubview:_textLabel];
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
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.backgroundColor = [UIColor greenColor];
        [_textLabel setCenter: self.center];
        [self addSubview:_textLabel];
    }
    return _textLabel;
}
@end
