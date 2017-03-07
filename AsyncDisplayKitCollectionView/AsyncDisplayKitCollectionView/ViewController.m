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
    NSString * text = [NSString stringWithFormat:@"(%ld,%ld) say hi.",indexPath.section,indexPath.item];
    return ^{
        return [[ItemNode alloc] initWithText:text];
    };
}

-(ASCellNode *)collectionNode:(ASCollectionNode *)collectionNode nodeForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
  NSString * text = [kind isEqualToString:UICollectionElementKindSectionHeader]?@"Header":@"Footer";
    SupplementaryNode * node = [[SupplementaryNode alloc] initWithText:text];
    BOOL isHeaderSection = [kind isEqualToString:UICollectionElementKindSectionHeader];
    node.backgroundColor = isHeaderSection?[UIColor blueColor]:[UIColor redColor];
    return node;
}

-(NSInteger)collectionNode:(ASCollectionNode *)collectionNode numberOfItemsInSection:(NSInteger)section{
    return 10;
}

-(NSInteger)numberOfSectionsInCollectionNode:(ASCollectionNode *)collectionNode{
    return 100;
    
}

// ???
-(void)collectionNode:(ASCollectionNode *)collectionNode willBeginBatchFetchWithContext:(ASBatchContext *)context{
    NSLog(@"Fetch additional content!");
    [context completeBatchFetching:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
