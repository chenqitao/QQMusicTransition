//
//  QTNarrowtransition.m
//  QQMusicTranstioning
//
//  Created by mac chen on 15/10/19.
//  Copyright © 2015年 陈齐涛. All rights reserved.
//

#import "QTNarrowtransition.h"
#import "QTFirstViewController.h"
#import "QTSecondViewController.h"

@implementation QTNarrowtransition
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.6f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    //获取两个VC 和 动画发生的容器
    QTSecondViewController *fromVC = (QTSecondViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    QTFirstViewController *toVC   = (QTFirstViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UIView *snapShotView = [fromVC.secondIV snapshotViewAfterScreenUpdates:NO];
    UIView *snapShotNavView = [fromVC.navigationView snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame = [containerView convertRect:fromVC.secondIV.frame fromView:fromVC.secondIV.superview];
    snapShotNavView.frame = [containerView convertRect:fromVC.navigationView.frame fromView:fromVC.navigationView.superview];
    fromVC.secondIV.hidden = YES;
    fromVC.navigationView.hidden = YES;
    
    //设置第二个控制器视图控件的位置、透明度
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    toVC.firstIV.hidden = YES;
    
    //把动画前后的两个ViewController加到容器中,顺序很重要,snapShotView在上方
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapShotView];
    [containerView addSubview:snapShotNavView];
    
    //动起来。第二个控制器的透明度0~1；让截图SnapShotView的位置更新到最新；
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:0.6f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
        toVC.view.alpha = 1.0;
        snapShotView.frame = [containerView convertRect:toVC.firstIV.frame fromView:toVC.view];
        snapShotNavView.frame = [containerView convertRect:CGRectMake(0, -64, [UIScreen mainScreen].bounds.size.width, 64) fromView:fromVC.view];
    } completion:^(BOOL finished) {
        //回来的时候，小图片要显示
        toVC.firstIV.hidden = NO;
        [snapShotView removeFromSuperview];
        [snapShotNavView removeFromSuperview];
        //告诉系统动画结束
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}



@end
