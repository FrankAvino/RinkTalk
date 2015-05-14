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
@property (weak, nonatomic) IBOutlet UILabel *hitsRecordedCount;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property int eventsCount;
@end


@implementation RecordEventViewController

-(void)viewDidLoad{
    if (!_guestName){
        PFQuery *query = [PFUser query];
        NSString *username = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
        [query whereKey:@"username" equalTo:username];
        [query findObjectsInBackgroundWithBlock:^(NSArray *foundUsers, NSError *error) {
            if (!error) {
                NSLog(@"Successfully retrieved %lu user.", (unsigned long)foundUsers.count);
                
                if([foundUsers count] == 1) {
                    for (PFUser *foundUser in foundUsers) {
                        _userObj = foundUser;
                    }
                }
            }
            else {
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
    }
    
    _eventsCount = 0;
    
}

// TODO make this just a view and not a button
- (IBAction)recordEvent:(id)sender {
    NSLog(@"Test1");
    _eventsCount++;
    _hitsRecordedCount.text = [NSString stringWithFormat:@"Hits recorded: %d", _eventsCount];
      NSLog(@"Test2");
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    
    _recordButton.backgroundColor = [UIColor colorWithRed:0.00 green:1.00 blue:0.00 alpha:1.0];
    [self performSelector:@selector(changeback) withObject:self afterDelay:0.5];
      NSLog(@"Test5");
    PFObject *Event = [PFUser objectWithClassName:@"Event"];
    NSLog(@"Test6");
    
    
    Event[@"type"] = _eventType; //error
    NSLog(@"Test7");
    Event[@"game"] = _game;
    
    NSLog(@"Test3");
    
    if (!_guestName){
        Event[@"submittedBy"] = _userObj;
    }
    else{
        Event[@"guestName"] = [@"(guest)" stringByAppendingString:_guestName];
    }
    
    NSLog(@"Test4");
    
    [Event saveInBackground];
    //NSLog(@"%@ recorded", _eventType);

}

-(void)changeback{
    _recordButton.backgroundColor = [UIColor colorWithRed:0.00 green:0.16 blue:0.31 alpha:1.0];
    
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [[segue destinationViewController] setGame: _game]; // pass selected game
}

@end
