//
//  SudukoUnit.m
//  暴力破解数独
//
//  Created by 王超 on 16/4/10.
//  Copyright © 2016年 WangChao. All rights reserved.
//

#import "SudokuUnit.h"

@interface SudokuUnit () <NSCoding>

@end

@implementation SudokuUnit

- (instancetype)initWithRow:(NSUInteger)row col:(NSUInteger)col {
    if (self = [super init]) {
        _currentRow = row + 1;
        _currentCol = col + 1;
        _section = (row/3)*3 + (col/3 + 1);;
        _currentValue = 0;
        _tempValue = 0;
    }
    return self;
}

- (NSMutableArray *)remainingValues {
    if (_remainingValues == nil) {
        _remainingValues = [NSMutableArray arrayWithObjects:@(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9), nil];
    }
    return _remainingValues;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.currentRow = [[aDecoder decodeObjectForKey:@"currentRow"] integerValue];
        self.currentCol = [[aDecoder decodeObjectForKey:@"currentCol"] integerValue];
        self.currentValue = [[aDecoder decodeObjectForKey:@"currentValue"] integerValue];
        self.section = [[aDecoder decodeObjectForKey:@"section"] integerValue];
        self.remainingValues = [aDecoder decodeObjectForKey:@"remainingValues"];
        self.tempValue = 0;
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:@(self.currentRow) forKey:@"currentRow"];
    [aCoder encodeObject:@(self.currentCol) forKey:@"currentCol"];
    [aCoder encodeObject:@(self.section) forKey:@"section"];
    [aCoder encodeObject:@(self.currentValue) forKey:@"currentValue"];
    [aCoder encodeObject:self.remainingValues forKey:@"remainingValues"];
}

@end
