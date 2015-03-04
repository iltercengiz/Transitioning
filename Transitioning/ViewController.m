//
//  ViewController.m
//  Transitioning
//
//  Created by Ilter Cengiz on 09/11/14.
//  Copyright (c) 2014 Ilter Cengiz. All rights reserved.
//

#import "ViewController.h"
#import "MenuViewController.h"
#import "TransitioningDelegate.h"

@interface ViewController ()

@property (nonatomic) TransitioningDelegate *customTransitioningDelegate;

@end

@implementation ViewController

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - IBActions

- (IBAction)menu:(id)sender {
    
    MenuViewController *mvc = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    
    mvc.modalPresentationStyle = UIModalPresentationCustom;
    mvc.transitioningDelegate = self.customTransitioningDelegate;

    [self presentViewController:mvc animated:YES completion:nil];
    
}

- (IBAction)unwind:(UIStoryboardSegue *)segue {
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"MenuSegue"]) {
        
    }
}

#pragma mark - Getter

- (TransitioningDelegate *)customTransitioningDelegate {
    if (!_customTransitioningDelegate) {
        _customTransitioningDelegate = [TransitioningDelegate new];
    }
    return _customTransitioningDelegate;
}

@end
