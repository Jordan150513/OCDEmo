//
//  WQSudokuFlowLayout.m
//  暴力破解数独
//
//  Created by 王超 on 16/4/9.
//  Copyright © 2016年 WangChao. All rights reserved.
//

#import "WQSudokuFlowLayout.h"

const NSUInteger kCollectionViewLeftNRightPadding = 10;

@implementation WQSudokuFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
//    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
//    CGFloat collectionViewWidth = screenWidth - 3*kCollectionViewLeftNRightPadding;
//    CGFloat widthOfEachSudokuCell = collectionViewWidth/9.0f;
//    CGFloat collectionViewHeight = screenHeight - 3*kCollectionViewLeftNRightPadding - 164.0f;
//    CGFloat heightOfEachSudukuCell = collectionViewHeight/9.0f;
//    return CGSizeMake(widthOfEachSudokuCell, heightOfEachSudukuCell);
    CGFloat paddingOfEachSudokuCell = 3.0f;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat widthOfEachSudokuCell =ceil((screenWidth - paddingOfEachSudokuCell*10)/9);
    return CGSizeMake(widthOfEachSudokuCell, widthOfEachSudokuCell);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 3.0f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 3.0f;
}

@end
