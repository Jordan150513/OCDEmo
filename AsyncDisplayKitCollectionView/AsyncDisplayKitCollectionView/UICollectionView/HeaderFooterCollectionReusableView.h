//
//  HeaderFooterCollectionReusableView.h
//  AsyncDisplayKitCollectionView
//
//  Created by 乔丹丹 on 2017/3/7.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderFooterCollectionReusableView : UICollectionReusableView
@property(nonatomic,strong)NSString * text;
-(instancetype)initWithText:(NSString *)text;
-(void)updateHeaderFooterViewText:(NSString *)text;
@end
