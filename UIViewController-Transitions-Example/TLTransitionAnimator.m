//
//  TLTransitionAnimator.m
//  UIViewController-Transitions-Example
//
//  Created by Ash Furrow on 2013-07-18.
//  Copyright (c) 2013 Teehan+Lax. All rights reserved.
//

#import "TLTransitionAnimator.h"

@implementation TLTransitionAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
//    // Get the 'from' and 'to' views/controllers.
//    UIViewController *fromVC = [transitionContext viewControllerForKey:
//                                UITransitionContextFromViewControllerKey];
//    UIViewController *toVC = [transitionContext viewControllerForKey:
//                              UITransitionContextToViewControllerKey];
//    // viewForKey is only available on iOS8+.
//    BOOL hasViewForKey = [transitionContext
//                          respondsToSelector:@selector(viewForKey:)];
//    UIView *fromView = hasViewForKey ?
//    [transitionContext viewForKey:UITransitionContextFromViewKey] :
//    fromVC.view;
//    UIView *toView = hasViewForKey ?
//    [transitionContext viewForKey:UITransitionContextToViewKey] :
//    toVC.view;
//    UIView *container = [transitionContext containerView];
//    
//    // iOS8 has a bug where viewForKey:to returns nil.
//    // The workaround is:
//    // A) get the 'toView' from 'toVC'.
//    // B) manually add the 'toView' to the container's
//    // superview (eg the root window) after the completeTransition
//    // call, as automatically happens on iOS7 where things work properly.
//    BOOL toViewNilBug = toView == nil;
//    if (!toView) { // Workaround by getting it from the view.
//        toView = toVC.view;
//    }
//    UIView *containerSuper = container.superview;
    
    
    
    
    // Grab the from and to view controllers from the context
//    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    // Set our ending frame. We'll modify this later if we have to
    CGRect endFrame = CGRectMake(80, 280, 160, 100);
    
//    NSLog(@"from view: %@",fromViewController.view);
//    NSLog(@"to view: %@",toViewController.view);
    
    if (self.presenting) {
        fromView.userInteractionEnabled = NO;
        
        [transitionContext.containerView addSubview:fromView];
        [transitionContext.containerView addSubview:toView];
        
        CGRect startFrame = endFrame;
        startFrame.origin.x += 320;
        
        toView.frame = startFrame;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromView.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
            toView.frame = endFrame;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
    else {
        toView.userInteractionEnabled = YES;
        
        [transitionContext.containerView addSubview:toView];
        [transitionContext.containerView addSubview:fromView];
        
        endFrame.origin.x += 320;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toView.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
            fromView.frame = endFrame;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}

@end