//
//  PerformanceViewController.m
//  RoundCornerDemo
//
//  Created by 乔丹丹 on 2016/12/16.
//  Copyright © 2016年 Fang. All rights reserved.
//

#import "PerformanceViewController.h"
#define IMAGEWidth 80
#define IMAGEHeight 80

#define ITEMWidth
#define ITEMHeight
@interface PerformanceViewController ()

@end

@implementation PerformanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"圆角效果";
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    layout.itemSize = [self getItemSize];
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
    NSString * kIdentifier = @"collectionView";
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kIdentifier];
    //要求跟切图的遮盖的颜色一致
    collectionView.backgroundColor = [UIColor colorWithRed:240/255.f green:240/255.f blue:240/255.f alpha:1];
    [self.view addSubview:collectionView];
}
-(CGSize)getScreenSize{
    return [UIScreen mainScreen].bounds.size;
}
-(CGSize)getImageSize{
    return CGSizeMake(80, 80);
}
-(CGSize)getItemSize{
    
    CGFloat width = ([self getScreenSize].width-[self getImageSize].width*3)/4+[self getImageSize].width;
    CGFloat height = 25+[self getImageSize].height;
    
    return CGSizeMake(width, height);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
