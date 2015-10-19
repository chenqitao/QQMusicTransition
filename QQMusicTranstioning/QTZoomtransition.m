//
//  QTZoomtransition.m
//  QQMusicTranstioning
//
//  Created by mac chen on 15/10/17.
//  Copyright © 2015年 陈齐涛. All rights reserved.
//

#import "QTZoomtransition.h"
#import  "QTFirstViewController.h"
#import "QTSecondViewController.h"

@implementation QTZoomtransition
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.6f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    NSLog(@"%@",transitionContext);
    //获取两个VC 和 动画发生的容器
    QTFirstViewController *fromVC = (QTFirstViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    QTSecondViewController *toVC   = (QTSecondViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UIView * snapShotView = [fromVC.firstIV snapshotViewAfterScreenUpdates:NO];
    //取出第一个控制器里面图片的rect
    snapShotView.frame  = [containerView convertRect:fromVC.firstIV.frame fromView:fromVC.firstIV.superview];
    fromVC.firstIV.hidden = YES;
    
    //设置第二个控制器视图控件的位置、透明度
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 1;
    toVC.secondIV.hidden = YES;
    
    //把动画前后的两个ViewController加到容器中,顺序很重要,snapShotView在上方
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapShotView];
    
   // 动起来。第二个控制器的透明度0~1；让截图SnapShotView的位置更新到最新；
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:0.6f initialSpringVelocity:0.5f options:UIViewAnimationOptionCurveLinear animations:^{
        toVC.view.alpha = 1.0;
        snapShotView.frame = [containerView convertRect:toVC.secondIV.frame fromView:toVC.view];
        toVC.navigationView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
    } completion:^(BOOL finished) {
        //为了让回来的时候,小图片能够显示
        toVC.secondIV.hidden = NO;
        fromVC.firstIV.hidden = NO;
        [snapShotView removeFromSuperview];
        //告诉系统动画结束
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];

    


}



@end
