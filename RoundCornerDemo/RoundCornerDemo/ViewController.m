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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"N种设置圆角的方式";
    NSArray * dataSourceArr = @[@"方式1",@"方式2",@"方式3",@"方式4",@"方式5",@"方式6"];
    self.dataSourceArr = dataSourceArr;
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-100) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:tableView];
}
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
    [cell.detailTextLabel setText:@"如何实现的描述"];
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
