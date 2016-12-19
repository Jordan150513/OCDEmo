//
//  FloatView.m
//  DDFloatView
//
//  Created by 乔丹丹 on 16/8/13.
//  Copyright © 2016年 Jordan. All rights reserved.
//

#import "FloatView.h"

@interface FloatView ()
@property(nonatomic,assign)BOOL isBoom;//Menu是否处于开放状态

@end

@implementation FloatView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isBoom = NO;
        self.backgroundColor = [UIColor greenColor];
        [self creatUI];
        
    }
    return self;
}
-(void)creatUI{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor lightGrayColor]];
    [btn setFrame:CGRectMake(0, 0, 44, 44)];
    [btn setTitle:@"点我" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(openOrClouse) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}
-(void)openOrClouse{
    self.isBoom = !self.isBoom;
    NSLog(@"%d",self.isBoom);
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGes {
    CGPoint currentPoint = [panGes locationInView:self.superview];
    self.center = currentPoint;
    
}


//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    // 拿到UITouch就能获取当前点
//    UITouch *touch = [touches anyObject];
//    // 获取当前点
//    CGPoint curP = [touch locationInView:self];
//    // 获取上一个点
//    CGPoint preP = [touch previousLocationInView:self];
//    // 获取手指x轴偏移量
//    CGFloat offsetX = curP.x - preP.x;
//    // 获取手指y轴偏移量
//    CGFloat offsetY = curP.y - preP.y;
//    NSLog(@"%f", offsetX);
//    // 移动当前view
//    self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY);
//}
//// 触摸事件被迫打断(电话打来)
//- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
//{
//}
////手抬起的时候调用
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"%s",__func__);
//}
-(void)dealloc{
    
}

@end
