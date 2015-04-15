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

-(void)viewDidLoad{
    self.eventTypes = [[NSMutableDictionary alloc] init];
    [self.eventTypes setValue:@"Hit" forKey:@"Hits"];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIButton *button = (UIButton *)sender;
    [[segue destinationViewController] setEventType: self.eventTypes[button.titleLabel.text]];
    [[segue destinationViewController] setGame: self.game]; // pass selected game
    RecordEventViewController *destViewController = (RecordEventViewController* )[segue destinationViewController];
    destViewController.navigationItem.title = [@"Record " stringByAppendingString:button.titleLabel.text];
}

// Should we have a "wow" event?

@end
