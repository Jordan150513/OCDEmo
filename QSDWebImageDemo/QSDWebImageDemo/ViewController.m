//
//  ViewController.m
//  QSDWebImageDemo
//
//  Created by 乔丹丹 on 2017/1/22.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "ViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>


/*
 UIImage (GIF)中的三个方法：
 
 + (UIImage *)sd_animatedGIFNamed:(NSString *)name;
 
 + (UIImage *)sd_animatedGIFWithData:(NSData *)data;
 
 - (UIImage *)sd_animatedImageByScalingAndCroppingToSize:(CGSize)size;
 */

static NSString * urlStringgif = @"https://img2.soufun.com/bbsv2/face/em016.gif";
static NSString * urlStringpng = @"http://o9vi0jo2t.bkt.clouddn.com/client_uploads/images/100/803C68E5FA7D8EBE7CCE498C0D1223C8";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SDWeb Demo";
    
    //一般图片
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 80, 80)];
//    [imageView sd_setImageWithURL:[NSURL URLWithString:urlStringpng] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    [imageView sd_setImageWithURL:[NSURL URLWithString:urlStringpng] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        NSLog(@"done");
    }];
//    [imageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlStringpng]]]];
    [self.view addSubview:imageView];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
