//
//  BigRedView.m
//  ResponderDemo
//
//  Created by 乔丹丹 on 2017/3/1.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "BigRedView.h"

@interface BigRedView ()
@property(nonatomic,strong)UIButton * leftBtn;
@property(nonatomic,strong)UIButton * rightBtn;
@end
@implementation BigRedView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createSubView];
    }
    return self;
}

-(void)createSubView{
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setTitle:@"left" forState:UIControlStateNormal];
    [leftBtn setFrame:CGRectMake(10, 30, 50, 50)];
    [leftBtn setBackgroundColor:[UIColor lightGrayColor]];
    [leftBtn addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftBtn];
    self.leftBtn = leftBtn;
    
    UIButton * rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"right" forState:UIControlStateNormal];
    [rightBtn setFrame:CGRectMake(80, 30, 50, 50)];
    [rightBtn setBackgroundColor:[UIColor lightGrayColor]];
    [rightBtn addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtn];
    self.rightBtn = rightBtn;
    
    UITapGestureRecognizer * tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundClick:)];
    [self addGestureRecognizer:tapGes];
}

#pragma mark - 响应 事件
-(void)backgroundClick:(id)sender{
    NSLog(@"backgroundClicked");
}

-(void)leftClick:(UIButton *)sender{
    NSLog(@"left");
}

-(void)rightClick:(UIButton *)sender{
    NSLog(@"right");
}


//BigRedView的touch事件
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%ld",event.allTouches.count);
    //验证手指数和UIEvent对象的数量
    //UITouch对象中存储的信息
    [event.allTouches enumerateObjectsUsingBlock:^(UITouch * _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"%@--%@------%f---------%f",obj.window,obj.view,[obj preciseLocationInView:self].x,[obj preciseLocationInView:self].y);
    }];
}

//#pragma mark - 重写 覆写该方法 可以指定子类的相应View
//-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    return self.leftBtn;
//}
//效果是：
//点击了 right 响应的是left
//点击了 left 响应的是left
//点击自己 没有反应 backgroundClicked 没有执行 touchbegin也没执行
//点击了自己 也会进入该hitTest方法，但是返回的是自己的子空间，但是点击范围却不在子控件的范围内
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    return YES;
}
@end
