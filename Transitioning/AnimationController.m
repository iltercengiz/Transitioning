//
//  AnimationController.m
//  Transitioning
//
//  Created by Ilter Cengiz on 09/11/14.
//  Copyright (c) 2014 Ilter Cengiz. All rights reserved.
//

#import "AnimationController.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface AnimationController ()

@property (nonatomic) UIView *overlayView;

@end

@implementation AnimationController

#pragma mark - Duration

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

#pragma mark - Performing the transition

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = fromViewController.view;
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    
    UIView *containerView = [transitionContext containerView];
    
    if ([self isPresentation]) {
        
//        self.overlayView.frame = containerView.bounds;
//        [containerView addSubview:self.overlayView];
        
        [containerView addSubview:toView];
        
        CGRect initialFrame;
        CGRect finalFrame;
        
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
            initialFrame = [transitionContext finalFrameForViewController:toViewController];
            initialFrame.origin.y = CGRectGetHeight(containerView.frame);
            
            finalFrame = [transitionContext finalFrameForViewController:toViewController];
        } else {
            initialFrame = CGRectZero;
            initialFrame.size = (CGSize){.width = CGRectGetWidth(containerView.frame) * 0.8, .height = CGRectGetHeight(containerView.frame) * 0.5};
            initialFrame.origin = (CGPoint){.x = (CGRectGetWidth(containerView.frame) - CGRectGetWidth(initialFrame)) / 2.0, .y = CGRectGetHeight(containerView.frame)};
            
            finalFrame = CGRectZero;
            finalFrame.size = (CGSize){.width = CGRectGetWidth(containerView.frame) * 0.8, .height = CGRectGetHeight(containerView.frame) * 0.5};
            finalFrame.origin = (CGPoint){.x = (CGRectGetWidth(containerView.frame) - CGRectGetWidth(finalFrame)) / 2.0, .y = (CGRectGetHeight(containerView.frame) - CGRectGetHeight(finalFrame)) / 2.0};
        }
        
        toView.frame = initialFrame;
        toView.layer.cornerRadius = 4.0;
        toView.layer.masksToBounds = YES;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0.0
             usingSpringWithDamping:0.5
              initialSpringVelocity:1.0
                            options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             toView.frame = finalFrame;
//                             self.overlayView.alpha = 1.0;
                         } completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                         }];
        
    } else {
        
        CGRect finalFrame;
        
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
            finalFrame = [transitionContext finalFrameForViewController:fromViewController];
            finalFrame.origin.y += CGRectGetHeight(containerView.frame);
        } else {
            finalFrame = fromView.frame;
            finalFrame.origin.y += CGRectGetHeight(containerView.frame);
        }
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] * 2
                              delay:0.0
                            options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             fromView.frame = finalFrame;
                             fromView.transform = CGAffineTransformRotate(fromView.transform, M_PI_4);
//                             self.overlayView.alpha = 0.0;
                         } completion:^(BOOL finished) {
                             [fromView removeFromSuperview];
//                             [self.overlayView removeFromSuperview];
                             [transitionContext completeTransition:YES];
                         }];
        
    }
    
}

#pragma mark - Getter

- (UIView *)overlayView {
    if (!_overlayView) {
        _overlayView = [UIView new];
        _overlayView.alpha = 0.0;
        _overlayView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.32];
    }
    return _overlayView;
}

@end
