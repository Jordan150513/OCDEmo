//
//  SudukoUnit.h
//  暴力破解数独
//
//  Created by 王超 on 16/4/10.
//  Copyright © 2016年 WangChao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SudokuUnit : NSObject

@property (nonatomic, assign) NSUInteger section;
@property (nonatomic, assign) NSUInteger currentValue;
@property (nonatomic, assign) NSUInteger currentRow;
@property (nonatomic, assign) NSUInteger currentCol;
@property (strong, nonatomic) NSMutableArray *remainingValues;

@property (nonatomic, assign) NSUInteger tempValue;

- (instancetype)initWithRow:(NSUInteger)row col:(NSUInteger)col;

@end
