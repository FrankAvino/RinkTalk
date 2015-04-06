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
    PFObject *Event = [PFUser objectWithClassName:@"Event"];
    Event[@"type"] = self.eventType;
    Event[@"game"] = self.game;
    
    PFQuery *query = [PFUser query];
    NSString *username = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    [query whereKey:@"username" equalTo:username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *foundUsers, NSError *error) {
        if (!error) {
            NSLog(@"Successfully retrieved %ld user.", foundUsers.count);
            
            if([foundUsers count] == 1) {
                for (PFUser *foundUser in foundUsers) {
                    Event[@"submittedBy"] = foundUser; // pointer to a parse User
                }
            }
        }
        else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
        [Event saveInBackground];
        NSLog(@"%@ recorded", self.eventType);
    }];
}

@end
