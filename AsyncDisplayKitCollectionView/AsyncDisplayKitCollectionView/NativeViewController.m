//
//  NativeViewController.m
//  AsyncDisplayKitCollectionView
//
//  Created by 乔丹丹 on 2017/3/7.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "NativeViewController.h"
#import "CustomCollectionViewCell.h"
#import "HeaderFooterCollectionReusableView.h"

@interface NativeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView * collectionView;
@end

@implementation NativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Apple Native CollectionView";
    UICollectionViewLayout * layout = [[UICollectionViewLayout alloc] init];
//    layout.
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
   
    // collectionView cell 类 注册
    [self.collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    // collectionView header footer 注册 类
    [self.collectionView registerClass:[HeaderFooterCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerFooter"];

    [self.view addSubview:self.collectionView];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

// 自定义 collectionView 的cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString * text = [NSString stringWithFormat:@"(%ld,%ld)say hi.",indexPath.section,indexPath.item];
    CustomCollectionViewCell * cell = [[CustomCollectionViewCell alloc] initWIthText:text];
    
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    BOOL isHeader = [kind isEqualToString:UICollectionElementKindSectionHeader];
    NSString * text = isHeader?@"header":@"footer";

    HeaderFooterCollectionReusableView * headerFooterView = [[HeaderFooterCollectionReusableView alloc] initWithText:text];
    [headerFooterView setBackgroundColor:isHeader?[UIColor redColor]:[UIColor blueColor]];
    return headerFooterView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
