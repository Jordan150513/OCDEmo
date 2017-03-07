//
//  SupplementaryNode.m
//  AsyncDisplayKitCollectionView
//
//  Created by 乔丹丹 on 2017/3/7.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "SupplementaryNode.h"
static CGFloat kInsets = 15.0f;
@interface SupplementaryNode ()
@property(nonatomic,strong)ASTextNode * textNode; //有一个ASTextNode 类型的 成员属性
@end

@implementation SupplementaryNode
-(instancetype)initWithText:(NSString *)text{
    self = [super init];
    if (self != nil) {
        _textNode = [[ASTextNode alloc] init];
            // NSDictionary<NSString *,id>  类型 的 第二个参数
        _textNode.attributedText = [[NSAttributedString alloc] initWithString:text attributes:[self textAttributes]];
        [self addSubnode:_textNode];
    }
    
    return self;
}

#pragma mark - 返回 textAttributes 的字典
-(NSDictionary *)textAttributes{
    
    return @{NSFontAttributeName:[UIFont systemFontOfSize:18],
             NSForegroundColorAttributeName:[UIColor whiteColor]
             };
}

-(ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    ASCenterLayoutSpec * center = [[ASCenterLayoutSpec alloc] init];
    center.centeringOptions = ASCenterLayoutSpecCenteringXY;
    center.child = self.textNode;
    
    UIEdgeInsets  insets = UIEdgeInsetsMake(kInsets, kInsets, kInsets, kInsets);
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:insets child:center];
}
@end
