//
//  PerformanceViewController.m
//  RoundCornerDemo
//
//  Created by 乔丹丹 on 2016/12/16.
//  Copyright © 2016年 Fang. All rights reserved.
//

#import "PerformanceViewController.h"
#import "YYFPSLabel.h"

#define IMAGEWidth 80
#define IMAGEHeight 80

#define ITEMWidth
#define ITEMHeight
@interface PerformanceViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) YYFPSLabel *fpsLabel;
@end

@implementation PerformanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"圆角效果";
    
    [self addCollectionView];
    [self addFPSLabel];
}
#pragma mark - 添加collectionView
-(void)addCollectionView{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    //    layout.itemSize = [self getItemSize];
    layout.itemSize = [self getImageSize];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
    NSString * kIdentifier = @"collectionView";
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kIdentifier];
    //要求跟切图的遮盖的颜色一致
    collectionView.backgroundColor = [UIColor colorWithRed:240/255.f green:240/255.f blue:240/255.f alpha:1];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
}
#pragma mark - 添加FPSLabel
-(void)addFPSLabel{
    _fpsLabel = [[YYFPSLabel alloc] initWithFrame:CGRectMake(200, 200, 50, 30)];
    [_fpsLabel sizeToFit];
    [self.view addSubview:_fpsLabel];
}
-(CGSize)getScreenSize{
    return [UIScreen mainScreen].bounds.size;
}
-(CGSize)getImageSize{
    return CGSizeMake(80, 80);
}
#pragma mark - ItemSize
-(CGSize)getItemSize{
    
    CGFloat width = ([self getScreenSize].width-[self getImageSize].width*3)/4+[self getImageSize].width;
    CGFloat height = 25+[self getImageSize].height;
    
    return CGSizeMake(width, height);
}
#pragma mark - CollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 380;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionView" forIndexPath:indexPath];
    [self setContentToCell:cell];
    
    return cell;
}
#pragma mark - 不同方式设置圆角
-(void)setContentToCell:(UICollectionViewCell *) cell {
    switch (self.rowForMethod) {
        case 0:
        {
            //第一种：
            //设置cornerRadius和masksToBounds
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AppIcon60x60"]];
            imageView.layer.cornerRadius = 10.0f;
            imageView.layer.masksToBounds = YES;
//            cell.contentView.autoresizesSubviews = NO;
            imageView.translatesAutoresizingMaskIntoConstraints = NO;
            [cell.contentView addSubview:imageView];
            
//            NSDictionary *dict = NSDictionaryOfVariableBindings(imageView);
//            NSString *horVLF = @"H:|-[imageView]-|";
//            NSString *verVLF = @"V:|-[imageView]-|";
//            NSArray <NSLayoutConstraint *> *horCons = [NSLayoutConstraint constraintsWithVisualFormat:horVLF options:NSLayoutFormatAlignAllCenterX metrics:nil views:dict];
//            NSArray <NSLayoutConstraint *> *verCons = [NSLayoutConstraint constraintsWithVisualFormat:verVLF options:NSLayoutFormatAlignAllCenterY metrics:nil views:dict];
//            [cell.contentView addConstraints:horCons];
//            [cell.contentView addConstraints:verCons];
        }
            break;
        case 1:
        {
            //第二种：
        //UIBezierPath和Core Graphics在图片上画出一个透明的圆
            UIImageView *imageViewTwo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
            imageViewTwo.image = [UIImage imageNamed:@"AppIcon60x60"];
            UIGraphicsBeginImageContextWithOptions(imageViewTwo.bounds.size, NO, [UIScreen mainScreen].scale);
            [[UIBezierPath bezierPathWithRoundedRect:imageViewTwo.bounds cornerRadius:imageViewTwo.frame.size.width] addClip];
            [imageViewTwo drawRect:imageViewTwo.bounds];
            imageViewTwo.image = UIGraphicsGetImageFromCurrentImageContext();
            //结束画图
            UIGraphicsEndImageContext();
            imageViewTwo.translatesAutoresizingMaskIntoConstraints = NO;
            [cell.contentView addSubview:imageViewTwo];

//            NSDictionary *dict = NSDictionaryOfVariableBindings(imageViewTwo);
//            NSString *horVLF = @"H:|-[imageViewTwo]-|";
//            NSString *verVLF = @"V:|-[imageViewTwo]-|";
//            NSArray <NSLayoutConstraint *> *horCons = [NSLayoutConstraint constraintsWithVisualFormat:horVLF options:NSLayoutFormatAlignAllCenterX metrics:nil views:dict];
//            NSArray <NSLayoutConstraint *> *verCons = [NSLayoutConstraint constraintsWithVisualFormat:verVLF options:NSLayoutFormatAlignAllCenterY metrics:nil views:dict];
//            [cell.contentView addConstraints:horCons];
//            [cell.contentView addConstraints:verCons];

        }
            break;
        case 2:
        {
        //第三种：
            //CAShapeLayer和UIBezierPath设置view.layer.mask
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
            imageView.image = [UIImage imageNamed:@"AppIcon60x60"];
            
//            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:imageView.bounds.size];
//            
//            CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
//            //设置大小
//            maskLayer.frame = imageView.bounds;
//            //设置图形样子
//            maskLayer.path = maskPath.CGPath;
//            imageView.layer.mask = maskLayer;
            [cell.contentView addSubview:imageView];
            
            imageView.translatesAutoresizingMaskIntoConstraints = NO;
//            NSDictionary * dict = NSDictionaryOfVariableBindings(imageView);
//            NSString * horVLF = @"H:|-[imageView]-|";
//            NSString * verVLF = @"V:|-[imageView]-|";
//            NSArray <NSLayoutConstraint *> *horCons = [NSLayoutConstraint constraintsWithVisualFormat:horVLF options:NSLayoutFormatAlignAllCenterX metrics:nil views:dict];
//            NSArray <NSLayoutConstraint *> *verCons = [NSLayoutConstraint constraintsWithVisualFormat:verVLF options:NSLayoutFormatAlignAllCenterY metrics:nil views:dict];
//            [cell.contentView addConstraints:horCons];
//            [cell.contentView addConstraints:verCons];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.frame byRoundingCorners:UIRectCornerAllCorners cornerRadii:imageView.frame.size];
            
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
            //设置大小
            maskLayer.frame = imageView.frame;
            //设置图形样子
            maskLayer.path = maskPath.CGPath;
            imageView.layer.mask = maskLayer;
        }
            break;
        case 3:
        {
            //第四种：addsubLayer
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
            [imageView setImage:[UIImage imageNamed:@"AppIcon60x60"]];
            CAShapeLayer * layer = [CAShapeLayer layer];
            UIBezierPath * path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 80, 80)];
            UIBezierPath * circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 80, 80)];
            [path appendPath:circlePath];
            [path setUsesEvenOddFillRule:YES];
            [path addClip];
            layer.path = path.CGPath;
//            layer.fillColor = [UIColor whiteColor].CGColor;//改成跟北京色一致的
            layer.fillColor = [UIColor colorWithRed:240/255.f green:240/255.f blue:240/255.f alpha:1].CGColor;
            layer.fillRule = kCAFillRuleEvenOdd;
            [imageView.layer addSublayer:layer];
            [cell.contentView addSubview:imageView];
            
//            imageView.translatesAutoresizingMaskIntoConstraints = NO;
//            NSDictionary * dict = NSDictionaryOfVariableBindings(imageView);
//            NSString * horVLF = @"H:|-[imageView]-|";
//            NSString * verVLF = @"V:|-[imageView]-|";
//            NSArray <NSLayoutConstraint *> *horCons = [NSLayoutConstraint constraintsWithVisualFormat:horVLF options:NSLayoutFormatAlignAllCenterX metrics:nil views:dict];
//            NSArray <NSLayoutConstraint *> *verCons = [NSLayoutConstraint constraintsWithVisualFormat:verVLF options:NSLayoutFormatAlignAllCenterY metrics:nil views:dict];
//            [cell.contentView addConstraints:horCons];
//            [cell.contentView addConstraints:verCons];

        }
            break;
        case 4:
            //两个imageView遮盖显示,切图配合提供
        {
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
            [imageView setImage:[UIImage imageNamed:@"AppIcon60x60"]];
            [cell.contentView addSubview:imageView];
            
            UIImageView * imageViewCover = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
            [imageViewCover setImage:[UIImage imageNamed:@"cover@2x"]];
            [cell.contentView addSubview:imageViewCover];
        }
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
