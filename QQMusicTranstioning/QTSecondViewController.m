//
//  QTSecondViewController.m
//  QQMusicTranstioning
//
//  Created by mac chen on 15/10/17.
//  Copyright © 2015年 陈齐涛. All rights reserved.
//

#import "QTSecondViewController.h"
#import "QTFirstViewController.h"
#import "QTNarrowtransition.h"

@interface QTSecondViewController ()<UINavigationControllerDelegate>

{
    UIButton  *backBtn;         /**< 返回按钮*/
    UILabel   *titleLab;        /**< 标题*/
    
}
@end

@implementation QTSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    [self creatUI];
    [self creatNavigationView];
}

- (void)creatUI {
    self.view.backgroundColor = [UIColor whiteColor];
    _secondIV = [[UIImageView alloc]initWithFrame:CGRectMake(50, 100, self.view.bounds.size.width-100 , self.view.bounds.size.width-100)];
    _secondIV.userInteractionEnabled = YES;
    _secondIV.image = [UIImage imageNamed:@"before.jpg"];
    _secondIV.layer.cornerRadius = (self.view.bounds.size.width-100)/2;
    _secondIV.layer.masksToBounds = YES;
    [self.view addSubview:_secondIV];
}

- (void)creatNavigationView {
    _navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, -64, self.view.frame.size.width, 64)];
    _navigationView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_navigationView];
    
    backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(5, 20, 30, 30);
    [backBtn setImage:[UIImage imageNamed:@"icon_back@2x"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(popFirstVC) forControlEvents:UIControlEventTouchUpInside];
    [_navigationView addSubview:backBtn];
    
    titleLab = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 50, 20, 100, 30)];
    titleLab.textColor = [UIColor whiteColor];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = @"second";
    [_navigationView addSubview:titleLab];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self setAnimationRotate:_secondIV.layer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)popFirstVC {
    [self.navigationController popToRootViewControllerAnimated:YES];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

}

- (void)setAnimationRotate:(CALayer *)layer {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.duration = 2;
    animation.fromValue = [NSNumber numberWithDouble:0.0];
    animation.toValue = [NSNumber numberWithDouble:2*M_PI];
    animation.repeatCount = 1000;
    [layer addAnimation:animation forKey:@"IVRotate"];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if ([toVC isKindOfClass:[QTFirstViewController class]]) {
        QTNarrowtransition *narrowTransition = [QTNarrowtransition new];
        return narrowTransition;
    }
    else {
        return nil;
    }

}



@end
