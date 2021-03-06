//
//  CADisplayLinkViewController.m
//  NSTimerAndCADisplayLinkDemo
//
//  Created by 乔丹丹 on 16/12/19.
//  Copyright © 2016年 com.home.zxb. All rights reserved.
//

#import "CADisplayLinkViewController.h"

@interface CADisplayLinkViewController ()
@property(nonatomic,strong)UIView * containerView;
@property (nonatomic, strong) UIImageView *ballView;
@property (nonatomic, strong) CADisplayLink *timer;
@property (nonatomic, assign) CFTimeInterval duration;
@property (nonatomic, assign) CFTimeInterval timeOffset;
@property (nonatomic, assign) CFTimeInterval lastStep;
@property (nonatomic, strong) id fromValue;
@property (nonatomic, strong) id toValue;
@end

@implementation CADisplayLinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"CADisplayLink";
    
    _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 500)];
    [self.view addSubview:_containerView];
    _containerView.backgroundColor = [UIColor lightGrayColor];
    
    UIImage * image = [UIImage imageNamed:@"bubble_right"];
    _ballView = [[UIImageView alloc] initWithImage:image];
    [_containerView addSubview:_ballView];
    [self animate2];
}


- (void)animate2
{
    //设置初始位置
    self.ballView.center = CGPointMake(150, 32);
    //配置animation参数
    self.duration = 1.0;
    self.timeOffset = 0.0;
    self.fromValue = [NSValue valueWithCGPoint:CGPointMake(150, 32)];
    self.toValue = [NSValue valueWithCGPoint:CGPointMake(150, 268)];
    //stop the timer if it's already running
    [self.timer invalidate];
    //start the timer
    self.lastStep = CACurrentMediaTime();
    self.timer = [CADisplayLink displayLinkWithTarget:self
                                             selector:@selector(step2:)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop]
                     forMode:NSDefaultRunLoopMode];
                      //NSDefaultRunLoopMode---标准优先级
                      //NSRunLoopCommonModes---高优先级
                      //UITrackingRunLoopMode---用于UIScrollView和别的控件的动画
}

- (void)step2:(CADisplayLink *)timer
{
    //calculate time delta
    CFTimeInterval thisStep = CACurrentMediaTime();
    CFTimeInterval stepDuration = thisStep - self.lastStep;
    self.lastStep = thisStep;
    //update time offset
    self.timeOffset = MIN(self.timeOffset + stepDuration, self.duration);
    //get normalized time offset (in range 0 - 1)
    float time = self.timeOffset / self.duration;
    //apply easing
    time = bounceEaseOut2(time);
    //插入位置
    id position = [self interpolate2FromValue:self.fromValue toValue:self.toValue
                                        time:time];
    //移动到新位置
    self.ballView.center = [position CGPointValue];
    //已经执行外全部动画
    if (self.timeOffset >= self.duration) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (id)interpolate2FromValue:(id)fromValue toValue:(id)toValue time:(float)time
{
    if ([fromValue isKindOfClass:[NSValue class]]) {
        //get type
        const char *type = [(NSValue *)fromValue objCType];
        if (strcmp(type, @encode(CGPoint)) == 0) {
            CGPoint from = [fromValue CGPointValue];
            CGPoint to = [toValue CGPointValue];
            CGPoint result = CGPointMake(interpolate2(from.x, to.x, time), interpolate2(from.y, to.y, time));
            return [NSValue valueWithCGPoint:result];
        }
    }
    //provide safe default implementation
    return (time < 0.5)? fromValue: toValue;
}
//计算渐进时间
float bounceEaseOut2(float t)
{
    if (t < 4/11.0) {
        return (121 * t * t)/16.0;
    } else if (t < 8/11.0) {
        return (363/40.0 * t * t) - (99/10.0 * t) + 17/5.0;
    } else if (t < 9/10.0) {
        return (4356/361.0 * t * t) - (35442/1805.0 * t) + 16061/1805.0;
    }
    return (54/5.0 * t * t) - (513/25.0 * t) + 268/25.0;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //replay animation on tap
    [self animate2];
}

float interpolate2(float from, float to, float time)
{
    return (to - from) * time + from;
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
