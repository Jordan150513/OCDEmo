//
//  ViewController.m
//  暴力破解数独
//
//  Created by 王超 on 16/4/9.
//  Copyright © 2016年 WangChao. All rights reserved.
//
//优化：
//1、准备添加一个cleanBtn，填写的时候清除填写，或者破解成功之后清除可以Reset重新再来填写破解
//2、界面显示进行优化，3*3模块明显示出来
//3、界面布局适配
#import "ViewController.h"
#import "WQSudokuFlowLayout.h"
#import "SudokuCell.h"
#import "SudokuUnit.h"
#import "Masonry.h"

static const NSUInteger ksudokuTotalCount = 81;

typedef struct {
    NSUInteger currentRow;
    NSUInteger currentCol;
} LocationUnit;

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (strong, nonatomic) IBOutlet UICollectionView *sudokuCollectionView;

@property (weak, nonatomic) IBOutlet UIButton *editorButton;
@property (weak, nonatomic) IBOutlet UIButton *breakButton;

@property (strong, nonatomic) NSIndexPath *selectedIndexPath;
@property (assign, nonatomic) BOOL collectionViewCanEditing;
@property (strong, nonatomic) NSArray *sudokuArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupEditorBaseView];
    [self setupBaseView];
    [self setupSudokuCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UI

- (void)setupEditorBaseView {
    [self.editorButton setTitle:@"完成" forState:UIControlStateSelected];
    [self.editorButton setSelected:NO];
    self.collectionViewCanEditing = self.editorButton.selected;
    self.breakButton.hidden = self.editorButton.selected;;
}

- (void)setupSudokuCollectionView {
    CGFloat paddingOfEachSudokuCell = 3.0f;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width - paddingOfEachSudokuCell;
    CGFloat widthOfEachSudokuCell =ceil((screenWidth - paddingOfEachSudokuCell*10)/9);
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = paddingOfEachSudokuCell;
    layout.minimumInteritemSpacing = paddingOfEachSudokuCell;
    layout.itemSize = CGSizeMake(widthOfEachSudokuCell, widthOfEachSudokuCell);
    
    self.sudokuCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.sudokuCollectionView.delegate = self;
    self.sudokuCollectionView.dataSource = self;
    self.sudokuCollectionView.bounces = NO;
    self.sudokuCollectionView.scrollEnabled = NO;
    self.sudokuCollectionView.backgroundColor = [UIColor yellowColor];
    [self.sudokuCollectionView registerNib:[UINib nibWithNibName:@"SudokuCell" bundle:nil] forCellWithReuseIdentifier:@"SudokuCell"];
    [self.view addSubview:self.sudokuCollectionView];
    [self.sudokuCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.width.and.height.equalTo(@(screenWidth));
    }];
}

- (void)setupBaseView {
    NSUInteger numberCount = 9;
    CGFloat widthOfEachNumber = [UIScreen mainScreen].bounds.size.width/numberCount;
    for(int i = 0; i < numberCount; i ++) {
        CGFloat numberButtonX = i * widthOfEachNumber;
        UIButton *numberButton = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *numberString = [NSString stringWithFormat:@"%d", (i+1)];
        [numberButton setTitle:numberString forState:UIControlStateNormal];
        numberButton.backgroundColor = [UIColor brownColor];
        numberButton.tag = i + 1;
        [numberButton addTarget:self action:@selector(numberButtonInBaseViewDidTouch:) forControlEvents:UIControlEventTouchUpInside];
        [self.baseView addSubview:numberButton];
        [numberButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.baseView.mas_centerY);
            make.leading.equalTo(self.baseView.mas_leading).with.offset(numberButtonX+2);
            make.width.and.height.equalTo(@(widthOfEachNumber-3));
        }];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return ksudokuTotalCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SudokuCell *sudokuCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SudokuCell" forIndexPath:indexPath];
    sudokuCell.cellUnitInfo = [self getCorrectUnitAccrodingToIndexPath:indexPath];
    return sudokuCell;
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.collectionViewCanEditing) {
        return YES;
    }
    return NO;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndexPath = indexPath;
}

#pragma mark - IBAction

- (IBAction)eidtorButtonInEditorBaseViewDidTouc:(UIButton *)sender {
    if (sender.selected) {
        [self.editorButton setSelected:NO];
        self.collectionViewCanEditing = self.editorButton.selected;
        self.breakButton.hidden = self.editorButton.selected;
        if (self.selectedIndexPath) {
            SudokuCell *selectedCell = (SudokuCell *)[self.sudokuCollectionView cellForItemAtIndexPath:self.selectedIndexPath];
            [selectedCell setSelected:NO];
            self.selectedIndexPath = nil;
        }
        [self findTheOnlyValueAndFill];
        NSData *sudokuData = [NSKeyedArchiver archivedDataWithRootObject:self.sudokuArray];
        [[NSUserDefaults standardUserDefaults] setObject:sudokuData forKey:@"sudokuData"];
    } else {
        [self.editorButton setSelected:YES];
        self.collectionViewCanEditing = self.editorButton.selected;
        self.breakButton.hidden = self.editorButton.selected;
    }
}

- (IBAction)breakeButtonInEditorBaseViewDidTouch:(UIButton *)sender {
    static NSInteger row = 0;
    static NSInteger col = 0;
    for (row = 0; row < 9; row ++) {
        for (col = 0; col < 9; col ++) {
            SudokuUnit *unit = [[self.sudokuArray objectAtIndex:row] objectAtIndex:col];
            if (unit.currentValue > 0) {
                continue;
            }
            
            NSLog(@"============>>>继续往前走......Row:%ld Col:%ld", row, col);
            for (NSInteger i = 0; i < unit.remainingValues.count; i ++) {
                NSInteger tempValue = [[unit.remainingValues objectAtIndex:i] integerValue];
                if (tempValue <= unit.tempValue && i == (unit.remainingValues.count - 1)) {
                    unit.tempValue = 0;
                    
                    SudokuUnit *previousSudokuUnitU = nil;
                    for (NSInteger index = row; index >= 0; index --) {
                        NSArray *tempArray = [self.sudokuArray objectAtIndex:index];
                        NSInteger maxCol = col;
                        if (index < row) {
                            maxCol = 8;
                        }
                        for (NSInteger k = maxCol; k >= 0; k --) {
                            SudokuUnit *kUnit = [tempArray objectAtIndex:k];
                            if (kUnit.tempValue > 0) {
                                previousSudokuUnitU = kUnit;
                                break;
                            }
                        }
                        if (previousSudokuUnitU) {
                            break;
                        }
                    }
                    if (previousSudokuUnitU == nil) {
                        NSLog(@"==========>>> 游戏结束，无解");
                        return;
                    }
                    
                    NSLog(@"全填完了======>>>需要回溯......");
                    NSInteger previousUnitRow = (previousSudokuUnitU.currentRow - 1);
                    NSInteger previousUnitCol = (previousSudokuUnitU.currentCol - 1);
                    if (previousUnitCol > 0) {
                        row = previousUnitRow;
                        col = previousUnitCol - 1;
                    } else if (previousUnitCol == 0) {
                        col = 8;
                        row = previousUnitRow - 1;
                    }
                    break;
                }
                
                if (tempValue <= unit.tempValue) {
                    continue;
                }
                
                BOOL isExistInSection = [self existInSection:unit.section
                                                       value:tempValue
                                             dataSourceArray:self.sudokuArray];
                
                BOOL isExistInRowCol = [self existInRow:unit.currentRow
                                                    col:unit.currentCol
                                                  value:tempValue
                                        dataSourceArray:self.sudokuArray];
                
                if (!isExistInSection && !isExistInRowCol) {
                    unit.tempValue = tempValue;
                    NSLog(@"==========>>>找到了可选值......");
                    break;
                }
                
                if (i == unit.remainingValues.count - 1) {
                    unit.tempValue = 0;
                    NSLog(@"没值可填======>>>需要回溯......");
                    
                    SudokuUnit *previousSudokuUnit = nil;
                    for (NSInteger index = row; index >= 0; index --) {
                        NSArray *tempArray = [self.sudokuArray objectAtIndex:index];
                        NSInteger maxCol = col;
                        if (index < row) {
                            maxCol = 8;
                        }
                        for (NSInteger k = maxCol; k >= 0; k --) {
                            SudokuUnit *kUnit = [tempArray objectAtIndex:k];
                            if (kUnit.tempValue > 0) {
                                previousSudokuUnit = kUnit;
                                break;
                            }
                        }
                        if (previousSudokuUnit) {
                            break;
                        }
                    }
                    if (previousSudokuUnit == nil) {
                        NSLog(@"==========>>> 游戏结束，无解");
                        return;
                    }
                    
                    NSInteger previousUnitRow = (previousSudokuUnit.currentRow - 1);
                    NSInteger previousUnitCol = (previousSudokuUnit.currentCol - 1);
                    if (previousUnitCol > 0) {
                        row = previousUnitRow;
                        col = previousUnitCol - 1;
                    } else if (previousUnitCol == 0) {
                        col = 8;
                        row = previousUnitRow - 1;
                    }
                    break;
                }
            }
        }
    }
    
    [self fillAllBlanks];
}

- (void)fillAllBlanks {
    for (int row = 0; row < 9; row ++) {
        for (int col = 0; col < 9; col ++) {
            SudokuUnit *unit = [[self.sudokuArray objectAtIndex:row] objectAtIndex:col];
            NSUInteger index = (unit.currentRow-1) * 9 + (unit.currentCol-1);
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
            SudokuCell *unitCell = (SudokuCell *)[self.sudokuCollectionView cellForItemAtIndexPath:indexPath];
            if (unit.currentValue >0) {
                unitCell.numberLabel.text = [NSString stringWithFormat:@"%ld", unit.currentValue];
            } else if(unit.tempValue > 0) {
                unitCell.numberLabel.text = [NSString stringWithFormat:@"%ld", unit.tempValue];
            } else {
                NSLog(@"😢😢😢😢😢😢回溯算法有误......");
            }
        }
    }
}


- (SudokuUnit *)getFirstBlackUnitInArray:(NSArray *)dataSourceArray {
    SudokuUnit *firstBlankUnit = nil;
    for (int index = 0; index < 9; index ++) {
        for (int i = 0; i < 9; i ++) {
            SudokuUnit *unit = [[dataSourceArray objectAtIndex:index] objectAtIndex:i];
            if (unit.currentValue < 1) {
                firstBlankUnit = unit;
                break;
            }
        }
        if (firstBlankUnit) {
            break;
        }
    }
    return firstBlankUnit;
}


#pragma mark - Helper

- (void)numberButtonInBaseViewDidTouch:(UIButton *)sender {
    if (self.collectionViewCanEditing) {
        if (self.selectedIndexPath) {
            SudokuCell *selectedCell = (SudokuCell *)[self.sudokuCollectionView cellForItemAtIndexPath:self.selectedIndexPath];
            BOOL isExistInSection = [self existInSection:selectedCell.cellUnitInfo.section
                                                   value:sender.tag
                                         dataSourceArray:self.sudokuArray];
            BOOL isExistInRowCol = [self existInRow:selectedCell.cellUnitInfo.currentRow
                                                col:selectedCell.cellUnitInfo.currentCol
                                              value:sender.tag
                                    dataSourceArray:self.sudokuArray];
            if (!isExistInSection && !isExistInRowCol) {
                selectedCell.numberLabel.text = [NSString stringWithFormat:@"%ld", (long)sender.tag];
                selectedCell.cellUnitInfo.currentValue = sender.tag;
                [selectedCell.cellUnitInfo.remainingValues removeAllObjects];
                [self updateRemainingValuesAccordingTo:selectedCell dataSourceArray:self.sudokuArray];
            }
        }
    }
}

- (SudokuUnit *)getCorrectUnitAccrodingToIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = indexPath.row/9;
    NSUInteger col = indexPath.row%9;
    SudokuUnit *unit = [[self.sudokuArray objectAtIndex:row] objectAtIndex:col];
    return unit;
}

- (LocationUnit)covertToLocationUnitAccrodingToIndexPath:(NSIndexPath *)indexPath {
    LocationUnit locationUnit;
    locationUnit.currentRow = indexPath.row/9 + 1;
    locationUnit.currentCol = indexPath.row%9 + 1;
    return locationUnit;
}

- (BOOL)existInSection:(NSInteger)section value:(NSInteger)value dataSourceArray:(NSArray *)dataSourceArray {
    NSInteger startRow = ((section-1)/3)*3;
    NSInteger startCol = ((section-1)%3)*3;
    NSInteger endRow = startRow + 3;
    NSInteger endCol = startCol + 3;
    for(NSInteger row = startRow; row < endRow; row ++) {
        for (NSInteger col = startCol; col < endCol; col ++) {
            SudokuUnit *unit = [[dataSourceArray objectAtIndex:row] objectAtIndex:col];
            if (unit.currentValue == value) {
                return YES;
            }
            if (unit.tempValue == value) {
                return YES;
            }
        }
    }
    return NO;
}

- (BOOL)existInRow:(NSInteger)row col:(NSInteger)col value:(NSInteger)value dataSourceArray:(NSArray *)dataSourceArray {
    for (NSInteger i = 0; i < 9; i ++) {
        SudokuUnit *unit = [[dataSourceArray objectAtIndex:row-1] objectAtIndex:i];
        if (unit.currentValue == value) {
            return YES;
        }
        if (unit.tempValue == value) {
            return YES;
        }
    }
    for (NSInteger j = 0; j < 9; j ++) {
        SudokuUnit *unit = [[dataSourceArray objectAtIndex:j] objectAtIndex:col-1];
        if (unit.currentValue == value) {
            return YES;
        }
        if (unit.tempValue == value) {
            return YES;
        }
    }
    return NO;
}

- (void)updateRemainingValuesAccordingTo:(SudokuCell *)tempCell dataSourceArray:(NSArray *)dataSourceArray {
    NSInteger startRow = ((tempCell.cellUnitInfo.section-1)/3)*3;
    NSInteger startCol = ((tempCell.cellUnitInfo.section-1)%3)*3;
    NSInteger endRow = startRow + 3;
    NSInteger endCol = startCol + 3;
    for(NSInteger row = startRow; row < endRow; row ++) {
        for (NSInteger col = startCol; col < endCol; col ++) {
            SudokuUnit *unit = [[dataSourceArray objectAtIndex:row] objectAtIndex:col];
            [unit.remainingValues enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj integerValue] == tempCell.cellUnitInfo.currentValue) {
                    [unit.remainingValues removeObjectAtIndex:idx];
                    *stop = YES;
                }
            }];
        }
    }
    
    for (NSInteger i = 0; i < 9; i ++) {
        SudokuUnit *unit = [[dataSourceArray objectAtIndex:tempCell.cellUnitInfo.currentRow-1] objectAtIndex:i];
        [unit.remainingValues enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj integerValue] == tempCell.cellUnitInfo.currentValue) {
                [unit.remainingValues removeObjectAtIndex:idx];
                *stop = YES;
            }
        }];
    }
    
    for (NSInteger j = 0; j < 9; j ++) {
        SudokuUnit *unit = [[dataSourceArray objectAtIndex:j] objectAtIndex:tempCell.cellUnitInfo.currentCol-1];
        [unit.remainingValues enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj integerValue] == tempCell.cellUnitInfo.currentValue) {
                [unit.remainingValues removeObjectAtIndex:idx];
                *stop = YES;
            }
        }];
    }
}

- (void)findTheOnlyValueAndFill {
    for (int row = 0; row < 9; row ++) {
        for (int col = 0; col < 9; col ++) {
            SudokuUnit *unit = [[self.sudokuArray objectAtIndex:row] objectAtIndex:col];
            if (unit.remainingValues.count == 1) {
                unit.currentValue = [[unit.remainingValues firstObject] integerValue];
                [unit.remainingValues removeAllObjects];
                
                NSUInteger index = (unit.currentRow-1) * 9 + (unit.currentCol-1);
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
                SudokuCell *unitCell = (SudokuCell *)[self.sudokuCollectionView cellForItemAtIndexPath:indexPath];
                unitCell.numberLabel.text = [NSString stringWithFormat:@"%ld", unit.currentValue];
                [self updateRemainingValuesAccordingTo:unitCell dataSourceArray:self.sudokuArray];
                
                [self findTheOnlyValueAndFill];
            }
        }
    }
}

#pragma mark - getter

- (NSArray *)sudokuArray {
    if (_sudokuArray == nil) {
        NSData *sudokuData = [[NSUserDefaults standardUserDefaults] objectForKey:@"sudokuData"];
        sudokuData = nil;
        if (sudokuData) {
            _sudokuArray = [NSKeyedUnarchiver unarchiveObjectWithData:sudokuData];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self fillAllBlanks];
                [self findTheOnlyValueAndFill];
            });
        } else {
            NSMutableArray *sudokuArrayM = [NSMutableArray arrayWithCapacity:9];
            for (int row = 0; row < 9; row ++) {
                NSMutableArray<SudokuUnit *> *tempArrayM = [NSMutableArray<SudokuUnit *> arrayWithCapacity:9];
                for (int col = 0; col < 9; col ++) {
                    SudokuUnit *unit = [[SudokuUnit alloc] initWithRow:row col:col];
                    [tempArrayM addObject:unit];
                }
                [sudokuArrayM addObject:[tempArrayM copy]];
            }
            _sudokuArray = [sudokuArrayM copy];
        }
    }
    return _sudokuArray;
}

@end
