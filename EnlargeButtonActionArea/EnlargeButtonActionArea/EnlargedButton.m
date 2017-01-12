//
//  EnlargedButton.m
//  EnlargeButtonActionArea
//
//  Created by 乔丹丹 on 2017/1/9.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "EnlargedButton.h"

@implementation EnlargedButton

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    
    //通过修改bounds 的x,y 值就可以只向X 轴或者Y轴的某一个方向扩展
    //当bounds 的X 为负,Y 为0,就只向X的正方向扩展点击区域,反之亦然
    //当bounds 的Y 为负,X 为0,就只向Y的正方向扩展点击区域,反之亦然
    //当bounds 的Y 为0,X 为0,widthDelta,heightDelta来控制扩大的点击区域 ,这个是同时向X 轴正负方向或者同时向Y轴的正负方向
    CGRect bounds = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    //90 是希望的X 轴或者Y轴方向的点击区域的宽度或者高度
//    CGFloat widthDelta = 90-bounds.size.width;
    CGFloat heightDelta = 90-bounds.size.height;
    //注意这里是负数，扩大了之前的bounds的范围
    bounds = CGRectInset(bounds, 0, -0.5*heightDelta);
//    bounds = CGRectInset(bounds, 0, 0);//还是之前的范围，不会扩大相应区域
    return CGRectContainsPoint(bounds, point);
    
}
@end


