//
//  TransitioningDelegate.m
//  Transitioning
//
//  Created by Ilter Cengiz on 09/11/14.
//  Copyright (c) 2014 Ilter Cengiz. All rights reserved.
//

#import "TransitioningDelegate.h"
#import "PresentationController.h"
#import "AnimationController.h"

@interface TransitioningDelegate ()

@property (nonatomic) AnimationController *presented;
@property (nonatomic) AnimationController *dismissed;

@end

@implementation TransitioningDelegate

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return [[PresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self.presented;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.dismissed;
}

#pragma mark - Getter

- (AnimationController *)presented {
    if (!_presented) {
        _presented = [AnimationController new];
        _presented.presentation = YES;
    }
    return _presented;
}

- (AnimationController *)dismissed {
    if (!_dismissed) {
        _dismissed = [AnimationController new];
        _dismissed.presentation = NO;
    }
    return _dismissed;
}

@end
