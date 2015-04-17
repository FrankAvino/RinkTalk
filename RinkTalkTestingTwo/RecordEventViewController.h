//
//  HitsOffensiveViewController.h
//  RinkTalkTestingTwo
//
//  Created by Frank Avino on 2/1/15.
//  Copyright (c) 2015 Frank Avino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface RecordEventViewController : UIViewController

@property NSString *eventType;
@property PFObject *game;
@property NSMutableArray *eventsToShow;
@property PFUser *userObj;
@property NSString *guestName;
@end
