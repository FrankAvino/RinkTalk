//
//  RecordEventViewController.m
//  RinkTalkTestingTwo
//
//  Created by Frank Avino on 2/1/15.
//  Copyright (c) 2015 Frank Avino. All rights reserved.
//

#import "RecordEventViewController.h"
#import "EventsListViewController.h"
#import <Parse/Parse.h>


@interface RecordEventViewController ()
@end



@implementation RecordEventViewController

- (IBAction)recordEvent:(id)sender {
    PFObject *Event = [PFObject objectWithClassName:@"Event"];
    Event[@"type"] = self.eventType;
    Event[@"game"] = self.game;
    //Event[@"submittedBy"] = Pointer to Parse User (get from NSUserDefaults)
    
    [Event saveInBackground];
    NSLog(@"%@ recorded", self.eventType);
}

@end
