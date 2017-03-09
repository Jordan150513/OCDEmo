//
//  PhotoFeedBaseController.m
//  AsyncDisplayKitCollectionView
//
//  Created by 乔丹丹 on 2017/3/8.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "PhotoFeedBaseController.h"

@interface PhotoFeedBaseController ()
@property(nonatomic,strong)UIActivityIndicatorView * activityIndicatorView;
@end

@implementation PhotoFeedBaseController

// -loadView is guaranteed to be called on the main thread and is the appropriate place to
// set up an UIKit objects you may be using.
// -loadView 保证 会被在主线程调用 所以 -loadView 是恰当的地方 来创建一个你将要使用的 UIKit 对象

-(void)loadView{

    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)refreshFeed{

}
- (void)insertNewRows:(NSArray *)newPhotos{

}

#pragma mark - Subclasses must override these methods

//- (void)loadPage;
//- (void)requestCommentsForPhotos:(NSArray *)newPhotos;

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
