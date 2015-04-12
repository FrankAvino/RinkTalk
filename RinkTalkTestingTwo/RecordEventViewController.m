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
#import <AudioToolbox/AudioToolbox.h>

@interface RecordEventViewController ()
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@end


@implementation RecordEventViewController


// TODO make this just a view and not a button, fix colors and stuff
- (IBAction)recordEvent:(id)sender {
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate); // not sure if vibrate works yet, need to test on real device
    self.recordButton.backgroundColor = [UIColor redColor];
    [self performSelector:@selector(changeback) withObject:self afterDelay:0.5];
    
    PFObject *Event = [PFUser objectWithClassName:@"Event"];
    Event[@"type"] = self.eventType;
    Event[@"game"] = self.game;
    
    PFQuery *query = [PFUser query];
    NSString *username = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    [query whereKey:@"username" equalTo:username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *foundUsers, NSError *error) {
        if (!error) {
            NSLog(@"Successfully retrieved %lu user.", (unsigned long)foundUsers.count);
            
            if([foundUsers count] == 1) {
                for (PFUser *foundUser in foundUsers) {
                    Event[@"submittedBy"] = foundUser;
                }
            }
        }
        else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
        [Event saveInBackground];
        NSLog(@"%@ recorded", self.eventType);
    }];
}

-(void)changeback{
    self.recordButton.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [[segue destinationViewController] setGame: self.game]; // pass selected game
}

@end
