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
    _eventTypes = [[NSMutableDictionary alloc] init];
    [_eventTypes setValue:@"Hit" forKey:@"Hits"];
    [_eventTypes setValue:@"Offensive Zone Faceoff" forKey:@"Offensive Zone Faceoffs"];
    [_eventTypes setValue:@"Defensive Zone Faceoff" forKey:@"Defensive Zone Faceoffs"];
    [_eventTypes setValue:@"Neutral Zone Faceoff" forKey:@"Neutral Zone Faceoffs"];
    [_eventTypes setValue:@"Penalty" forKey:@"Penalties"];
    [_eventTypes setValue:@"Goal" forKey:@"Goals"];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIButton *button = (UIButton *)sender;
    
    if (![[segue identifier] isEqualToString:@"Admin Login"]) {
    
        [[segue destinationViewController] setEventType: _eventTypes[button.titleLabel.text]];
        [[segue destinationViewController] setGame: _game]; // pass selected game
    
        if (_guestName){
            [[segue destinationViewController] setGuestName: _guestName];
        }

        RecordEventViewController *destViewController = (RecordEventViewController* )[segue destinationViewController];
        destViewController.navigationItem.title = [@"Record " stringByAppendingString:button.titleLabel.text];
    }
    
}

@end
