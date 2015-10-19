//
//  QTFirstViewController.m
//  QQMusicTranstioning
//
//  Created by mac chen on 15/10/17.
//  Copyright © 2015年 陈齐涛. All rights reserved.
//

#import "QTFirstViewController.h"
#import "QTSecondViewController.h"
#import "QTZoomtransition.h"

@interface QTFirstViewController ()<UINavigationControllerDelegate>
{
    NSTimer *timer;
}
@end

@implementation QTFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"first";

    self.view.backgroundColor = [UIColor whiteColor];
    _firstIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, self.view.bounds.size.height - 60, 50, 50)];
    _firstIV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(transition)];
    [_firstIV addGestureRecognizer:tap];
    _firstIV.image = [UIImage imageNamed:@"before.jpg"];
    _firstIV.layer.cornerRadius = 25;
    _firstIV.layer.masksToBounds = YES;
    [self.view addSubview:_firstIV];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.delegate = self;
    self.navigationController.navigationBarHidden = NO;
    [self repeatRotate];
}

- (void)repeatRotate {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.duration = 2;
    animation.fromValue = [NSNumber numberWithDouble:0.0];
    animation.toValue = [NSNumber numberWithDouble:2*M_PI];
    animation.repeatCount = 1000;
    [_firstIV.layer addAnimation:animation forKey:@"IVRotate"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)transition{
    [self.navigationController pushViewController:[QTSecondViewController new] animated:YES];

}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if ([toVC isKindOfClass:[QTSecondViewController class]]) {
        QTZoomtransition *zoomTransition = [[QTZoomtransition alloc]init];
        return zoomTransition;
    }
    else {
        return nil;
    }


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
