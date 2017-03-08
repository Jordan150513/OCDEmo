//
//  CustomCollectionViewCell.h
//  AsyncDisplayKitCollectionView
//
//  Created by 乔丹丹 on 2017/3/7.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import <UIKit/UIKit.h>
// collectionView 的 cell的自定义
@interface CustomCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)NSString * text;
-(instancetype)initWIthText:(NSString *)text;
-(void)updateCellText:(NSString *)text;
@end
