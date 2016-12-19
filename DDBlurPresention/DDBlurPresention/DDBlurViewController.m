//
//  DDBlurViewController.m
//  DDBlurPresention
//
//  Created by 乔丹丹 on 16/6/2.
//  Copyright © 2016年 Fang. All rights reserved.
//

#import "DDBlurViewController.h"
#import "DDBlurPresenter.h"

@interface DDBlurViewController ()
@property(nonatomic,strong)DDBlurPresenter * presenter;
@end

@implementation DDBlurViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    if (self) {
        [self DD_commonSetup];
    }
    return self;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self DD_commonSetup];
    }
    return  self;
}
-(void)DD_commonSetup{
    self.modalPresentationStyle = UIModalPresentationCustom;
    
    _presenter = [[DDBlurPresenter alloc] init];
    _blurStyle = UIBlurEffectStyleDark;
    _presenter.blurStyle = _blurStyle;
    //----------------
    self.transitioningDelegate = _presenter;
}

-(void)setBlurStyle:(UIBlurEffectStyle)blurStyle{
    if (blurStyle != _blurStyle) {
        _blurStyle = blurStyle;
        _presenter.blurStyle = _blurStyle;
    }
}

@end
