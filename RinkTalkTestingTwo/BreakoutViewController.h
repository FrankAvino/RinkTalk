//
//  BreakoutViewController.h
//  RinkTalkTestingTwo
//
//  Created by Frank Avino on 3/3/15.
//  Copyright (c) 2015 Frank Avino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface BreakoutViewController : UIViewController

@property PFObject *breakout;
@property NSDate *timeBreakoutStarted;
@property NSDate *timeBreakoutEnded;
@property NSString *userName;
@property NSString *userEmail;
@property NSDate *gameStart;

@end
