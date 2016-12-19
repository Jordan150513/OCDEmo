//
//  SudokuCell.m
//  暴力破解数独
//
//  Created by 王超 on 16/4/10.
//  Copyright © 2016年 WangChao. All rights reserved.
//

#import "SudokuCell.h"

@implementation SudokuCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)updateAppearanceAccordingTo:(SudokuUnit *)unit collectionView:(UICollectionView *)collectionView {
    
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        self.contentView.layer.borderWidth = 3.0f;
        self.contentView.layer.borderColor = [UIColor redColor].CGColor;
    } else {
        self.contentView.layer.borderWidth = 0.0f;
    }
}

@end
