//
//  ItemNode.h
//  AsyncDisplayKitCollectionView
//
//  Created by 乔丹丹 on 2017/3/7.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

//自定义一个 ASTextCellNode 子类的 ItemNode node类型 组内的 cell单元小格子 node
@interface ItemNode : ASTextCellNode
-(instancetype)initWithText:(NSString *)text;
@end
