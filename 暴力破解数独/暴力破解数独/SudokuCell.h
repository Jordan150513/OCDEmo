//
//  SudokuCell.h
//  暴力破解数独
//
//  Created by 王超 on 16/4/10.
//  Copyright © 2016年 WangChao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SudokuUnit.h"

@interface SudokuCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic)SudokuUnit *cellUnitInfo;

- (void)updateAppearanceAccordingTo:(SudokuUnit *)unit collectionView:(UICollectionView *)collectionView;
@end
