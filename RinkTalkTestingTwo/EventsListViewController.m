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
@end

@implementation EventsListViewController

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIButton *button = (UIButton *)sender;
    [[segue destinationViewController] setEventType: button.titleLabel.text];
    RecordEventViewController *destViewController = (RecordEventViewController* )[segue destinationViewController];
    destViewController.navigationItem.title = [@"Record " stringByAppendingString:button.titleLabel.text];
    
    // TODO Pass selected game
    NSString *value = self.game.objectId;
    NSLog(@"%@", value);
}


@end
