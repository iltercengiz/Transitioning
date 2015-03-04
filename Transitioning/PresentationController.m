//
//  PresentationController.m
//  Transitioning
//
//  Created by Ilter Cengiz on 09/11/14.
//  Copyright (c) 2014 Ilter Cengiz. All rights reserved.
//

#import "PresentationController.h"

@implementation PresentationController

#pragma mark - Init

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController {
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self) {
        _visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        _visualEffectView.alpha = 0.0;
    }
    return self;
}

#pragma mark - Size and Layout

- (CGRect)frameOfPresentedViewInContainerView {
    
    CGRect presentedViewFrame = CGRectZero;
    CGRect containerViewBounds = self.containerView.bounds;
    
    presentedViewFrame.size = [self sizeForChildContentContainer:self.presentedViewController withParentContainerSize:containerViewBounds.size];
    presentedViewFrame.origin = CGPointMake((CGRectGetWidth(containerViewBounds) - CGRectGetWidth(presentedViewFrame)) / 2.0, (CGRectGetHeight(containerViewBounds) - CGRectGetHeight(presentedViewFrame)) / 2.0);
    
    return presentedViewFrame;
    
}

- (void)containerViewWillLayoutSubviews {
    self.visualEffectView.frame = self.containerView.bounds;
    self.presentedView.frame = [self frameOfPresentedViewInContainerView];
}

#pragma mark - Tracking the transition

- (void)presentationTransitionWillBegin {
    
    UIView *containerView = self.containerView;
    UIViewController *presentedViewController = self.presentedViewController;
    
    self.visualEffectView.frame = containerView.bounds;
    self.visualEffectView.alpha = 0.0;
    
    [containerView insertSubview:self.visualEffectView atIndex:0];
    
    if (presentedViewController.transitionCoordinator) {
        [presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            self.visualEffectView.alpha = 1.0;
        } completion:nil];
    } else {
        self.visualEffectView.alpha = 1.0;
    }
    
}

- (void)dismissalTransitionWillBegin {
    
    UIViewController *presentedViewController = self.presentedViewController;
    
    if (presentedViewController.transitionCoordinator) {
        [presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            self.visualEffectView.alpha = 0.0;
        } completion:nil];
    } else {
        self.visualEffectView.alpha = 0.0;
    }
    
}

#pragma mark - Content container

- (CGSize)sizeForChildContentContainer:(id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
    return CGSizeMake(parentSize.width * 0.8, parentSize.height * 0.5);
}

@end
