//
//  ViewController.m
//  DDBlurPresention
//
//  Created by 乔丹丹 on 16/6/1.
//  Copyright © 2016年 Fang. All rights reserved.
//

#import "ViewController.h"
#import "PresentedViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    PresentedViewController * pvc = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"showLight"]) {
        pvc.blurStyle = UIBlurEffectStyleLight;
    }else{
        pvc.blurStyle = UIBlurEffectStyleDark;
    }
}
@end
