//
//  EventsListViewController.m
//  RinkTalkTestingTwo
//
//  Created by Frank Avino on 2/1/15.
//  Copyright (c) 2015 Frank Avino. All rights reserved.
//

#import "EventsListViewController.h"
#import "RecordEventViewController.h"
#import <Parse/Parse.h>

@interface EventsListViewController () <UIAlertViewDelegate>

@property NSString *userName;
@property NSString *userEmail;

@end



@implementation EventsListViewController

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIButton *button = (UIButton *)sender;
    [[segue destinationViewController] setEventType: button.titleLabel.text];
    RecordEventViewController *destViewController = (RecordEventViewController* )[segue destinationViewController];
    destViewController.navigationItem.title = [@"Record " stringByAppendingString:button.titleLabel.text];
    
    // TODO Pass game ID of selected game
}


@end
