//
//  DismissSegue.m
//  RinkTalkTestingTwo
//
//  Created by Henry Spindell on 5/5/15.
//  Copyright (c) 2015 Frank Avino. All rights reserved.
//

// credit: http://jeffreysambells.com/2014/02/19/dismissing-a-modal-view-using-a-storyboard-segue

#import "DismissSegue.h"

@implementation DismissSegue

- (void)perform {
    UIViewController *sourceViewController = self.sourceViewController;
    [sourceViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end