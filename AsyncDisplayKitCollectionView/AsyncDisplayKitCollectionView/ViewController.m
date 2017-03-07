//
//  ViewController.m
//  AsyncDisplayKitCollectionView
//
//  Created by 乔丹丹 on 2017/3/7.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "ViewController.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "ItemNode.h"
#import "SupplementaryNode.h"

/*
 * 目前还有一个很奇怪的问题 ，就是布局的问题
 * 1、组内最后一个感觉布局很奇怪啊 
 * 2、横屏过来的时候 每组的布局还不一样
 */

@interface ViewController ()<ASCollectionDelegate,ASCollectionDataSource>
// ASCollectionNode 对应 UICollectionView
@property(nonatomic,strong)ASCollectionNode * collectionNode;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"AsyncDsiplayKit Demo";
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.headerReferenceSize = CGSizeMake(50.0, 50.0);
    layout.footerReferenceSize = CGSizeMake(50.0, 50.0);
    
//    self.collectionNode = [[ASCollectionNode alloc] initWithCollectionViewLayout:layout];
    self.collectionNode = [[ASCollectionNode alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    //出现问题 要找原因 不要盲目 只要出现了问题 那肯定是自己的原因 要么就是自己的原因导致的不谨慎的
    self.collectionNode.delegate = self;
    self.collectionNode.dataSource = self;
    
    // simple resize. default is UIViewAutoresizingNone
    self.collectionNode.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.collectionNode.backgroundColor = [UIColor whiteColor];
    
    [self.collectionNode registerSupplementaryNodeOfKind:UICollectionElementKindSectionHeader];
    [self.collectionNode registerSupplementaryNodeOfKind:UICollectionElementKindSectionFooter];
    
    [self.view addSubnode:self.collectionNode];
    
}

#pragma mark - dataSource
-(ASCellNodeBlock)collectionNode:(ASCollectionNode *)collectionNode nodeBlockForItemAtIndexPath:(NSIndexPath *)indexPath{
    // 组内的 cell 单元格的定义
    NSString * text = [NSString stringWithFormat:@"(%ld,%ld) say hi.",indexPath.section,indexPath.item];
    return ^{
        return [[ItemNode alloc] initWithText:text];
    };
}
// 这个方法 实现了什么 底层如何实现的
-(ASCellNode *)collectionNode:(ASCollectionNode *)collectionNode nodeForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    NSString * text = [kind isEqualToString:UICollectionElementKindSectionHeader]?@"Header":@"Footer";
    SupplementaryNode * node = [[SupplementaryNode alloc] initWithText:text];
    // footer 还是 header 的自定义node
    BOOL isHeaderSection = [kind isEqualToString:UICollectionElementKindSectionHeader];
    node.backgroundColor = isHeaderSection?[UIColor blueColor]:[UIColor redColor];
    return node;
}

-(NSInteger)collectionNode:(ASCollectionNode *)collectionNode numberOfItemsInSection:(NSInteger)section{
    // 每组 10 个
    return 10;
}

-(NSInteger)numberOfSectionsInCollectionNode:(ASCollectionNode *)collectionNode{
    //一共有 100 组
    return 100;
    
}

// ??? 这个方法实现了什么 底层实现了什么？？
-(void)collectionNode:(ASCollectionNode *)collectionNode willBeginBatchFetchWithContext:(ASBatchContext *)context{
    NSLog(@"Fetch additional content!");
    [context completeBatchFetching:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
