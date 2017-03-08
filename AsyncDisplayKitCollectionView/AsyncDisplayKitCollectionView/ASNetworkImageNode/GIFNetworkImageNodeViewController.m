//
//  GIFNetworkImageNodeViewController.m
//  AsyncDisplayKitCollectionView
//
//  Created by 乔丹丹 on 2017/3/8.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "GIFNetworkImageNodeViewController.h"
#import <ASImageNode.h>
#import <ASNetworkImageNode.h>
// ASNetworkImageNode 和 ASImageNode 的区别

@interface GIFNetworkImageNodeViewController ()

@end

@implementation GIFNetworkImageNodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"GIF NetworkImageNode";
    
     static NSString * gifUrls = @"https://s-media-cache-ak0.pinimg.com/originals/07/44/38/074438e7c75034df2dcf37ba1057803e.gif";
    static NSString * gifUrl = @"http://s-media-cache-ak0.pinimg.com/originals/07/44/38/074438e7c75034df2dcf37ba1057803e.gif";
    ASNetworkImageNode * node = [[ASNetworkImageNode alloc] init];
    node.URL = [NSURL URLWithString:gifUrl];//从全局区域 拷贝到 堆区域？？？是不是？
//    node.frame = self.view.bounds;
    [node setFrame:self.view.bounds];
//    node.autoresizingMask = UIViewAutoresizingFlexibleWidth;  // = 1 << 1,  0x0000000000000002 = 2
//    node.autoresizingMask = UIViewAutoresizingFlexibleHeight;  //  = 1 << 4, 0x0000000000000010 = 16  “|” 或  就是 加
    node.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight; //0x0000000000000012 = 18
    node.contentMode = UIViewContentModeScaleAspectFit;
//    node.backgroundColor = [UIColor redColor]; 看来是node 添加上去了 就是没有加载出来 好吧 现在才加载出来  超级慢慢慢 哈哈哈 我还以为是bug呢 ！！！
    [self.view addSubnode:node];
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
