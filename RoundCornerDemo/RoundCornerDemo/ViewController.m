//
//  ViewController.m
//  RoundCornerDemo
//
//  Created by 乔丹丹 on 2016/12/16.
//  Copyright © 2016年 Fang. All rights reserved.
//

#import "ViewController.h"
#import "PerformanceViewController.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray * dataSourceArr;
@property(nonatomic,strong)NSArray * descSourceArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置圆角的5种方式";
    
    [self setDefaultData];
    [self createUI];
}
-(void)setDefaultData{
    NSArray * dataSourceArr = @[@"方式1",@"方式2",@"方式3",@"方式4",@"方式5"];
    self.dataSourceArr = dataSourceArr;
    NSArray * descSourceArr = @[@"设置cornerRadius和masksToBounds",@"UIBezierPath和Core Graphics在图片上画出一个透明的圆",@"CAShapeLayer和UIBezierPath设置view.layer.mask",@"addsubLayer",@"两个imageView遮盖显示,切图配合提供"];
    self.descSourceArr = descSourceArr;
}
#pragma mark - 创建界面
-(void)createUI{
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-200) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:tableView];
    UILabel * descLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, [UIScreen mainScreen].bounds.size.height-80, [UIScreen mainScreen].bounds.size.width-40, 80)];
    descLabel.numberOfLines = 0;
    [descLabel setText:@"图片大小和collectionView的Item大小一样的，避免了布局，项目中肯定需要布局"];
    [self.view addSubview:descLabel];
}
#pragma mark - tableViewDelegate方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArr.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * reuseIdentifierSte = @"cell";
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifierSte];
    [cell.textLabel setText:self.dataSourceArr[indexPath.row]];
    [cell.detailTextLabel setText:self.descSourceArr[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PerformanceViewController * pVC = [[PerformanceViewController alloc] init];
    pVC.rowForMethod = indexPath.row;
    [self.navigationController pushViewController:pVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
