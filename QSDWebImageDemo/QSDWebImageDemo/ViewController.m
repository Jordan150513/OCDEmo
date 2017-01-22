//
//  ViewController.m
//  QSDWebImageDemo
//
//  Created by 乔丹丹 on 2017/1/22.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "ViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIImage+GIF.h>
#import <FLAnimatedImage/FLAnimatedImageView.h>
#import <FLAnimatedImage.h>

/*
 UIImage (GIF)中的三个方法：
 
 + (UIImage *)sd_animatedGIFNamed:(NSString *)name;
 
 + (UIImage *)sd_animatedGIFWithData:(NSData *)data;
 
 - (UIImage *)sd_animatedImageByScalingAndCroppingToSize:(CGSize)size;
 */

static NSString * urlStringgif = @"https://img2.soufun.com/bbsv2/face/em016.gif";//需要配置证书
static NSString * urlStringgif2 = @"http://o9vi0jo2t.bkt.clouddn.com/client_uploads/images/38/B23B980EFC9F27338390F6B5635F4CAA";
static NSString * urlStringpng = @"http://o9vi0jo2t.bkt.clouddn.com/client_uploads/images/100/803C68E5FA7D8EBE7CCE498C0D1223C8";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SDWeb Demo";
    
    //一般图片
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 80, 80)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:urlStringpng] placeholderImage:[UIImage imageNamed:@"placeholder"]];
//    [imageView sd_setImageWithURL:[NSURL URLWithString:urlStringpng] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        NSLog(@"done");
//    }];
//    [imageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlStringpng]]]];
    [self.view addSubview:imageView];
    
    
//gif图片
    // sd UIImageView是不支持gif，sd中 UIImage (GIF)做了简单的扩展 支持gif

    UIImage * image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlStringgif2] options:NSDataReadingMappedIfSafe error:nil]];
    UIImageView * gifImageView = [[UIImageView alloc] initWithImage:image];
    [image sd_animatedImageByScalingAndCroppingToSize:CGSizeMake(80, 80)];
//    [image sd_animatedGIFWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlStringgif]]];
    [self.view addSubview:gifImageView];
    
    //FLAnimagedImageView
    
//    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlStringgif2]]];
//    FLAnimatedImageView *imageViewFL = [[FLAnimatedImageView alloc] init];
//    imageViewFL.animationImages = [NSArray arrayWithObject:image];
//    imageViewFL.frame = CGRectMake(0.0, 0.0, 100.0, 100.0);
//    [self.view addSubview:imageViewFL];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
