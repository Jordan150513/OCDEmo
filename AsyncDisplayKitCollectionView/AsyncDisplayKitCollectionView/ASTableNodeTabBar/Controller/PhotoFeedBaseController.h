//
//  PhotoFeedBaseController.h
//  AsyncDisplayKitCollectionView
//
//  Created by 乔丹丹 on 2017/3/8.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "PhotoFeedModel.h"

@interface PhotoFeedBaseController : ASViewController
@property(nonatomic,strong,readonly)PhotoFeedModel * photoFeedModel;
@property(nonatomic,strong,readonly)UITableView * tableView;

- (void)refreshFeed;
- (void)insertNewRows:(NSArray *)newPhotos;

#pragma mark - Subclasses must override these methods

- (void)loadPage;
- (void)requestCommentsForPhotos:(NSArray *)newPhotos;

@end
