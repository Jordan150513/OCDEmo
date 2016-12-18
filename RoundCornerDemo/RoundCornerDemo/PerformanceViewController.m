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
@interface PerformanceViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation PerformanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"圆角效果";
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    layout.itemSize = [self getItemSize];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
//    collectionView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    NSString * kIdentifier = @"collectionView";
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kIdentifier];
    //要求跟切图的遮盖的颜色一致
    collectionView.backgroundColor = [UIColor colorWithRed:240/255.f green:240/255.f blue:240/255.f alpha:1];
    collectionView.delegate = self;
    collectionView.dataSource = self;
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

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 80;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionView" forIndexPath:indexPath];
    [self setContentToCell:cell];
    
    return cell;
}
-(void)setContentToCell:(UICollectionViewCell *) cell {
    switch (self.rowForMethod) {
        case 0:
        {
            //设置cornerRadius和masksToBounds
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AppIcon60x60"]];
            imageView.layer.cornerRadius = 10.0f;
            imageView.layer.masksToBounds = YES;
            cell.contentView.autoresizesSubviews = NO;
            imageView.translatesAutoresizingMaskIntoConstraints = NO;
            [cell.contentView addSubview:imageView];
            NSDictionary *dict = NSDictionaryOfVariableBindings(imageView);
            NSString *horVLF = @"H:|-[imageView]-|";
            NSString *verVLF = @"V:|-[imageView]-|";
            NSArray <NSLayoutConstraint *> *horCons = [NSLayoutConstraint constraintsWithVisualFormat:horVLF options:NSLayoutFormatAlignAllCenterX metrics:nil views:dict];
            NSArray <NSLayoutConstraint *> *verCons = [NSLayoutConstraint constraintsWithVisualFormat:verVLF options:NSLayoutFormatAlignAllCenterY metrics:nil views:dict];
            [cell.contentView addConstraints:horCons];
            [cell.contentView addConstraints:verCons];
        }
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        case 5:
            
            break;

        default:
            break;
    }
}
- (void)didReceiveMemoryWarning{
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
