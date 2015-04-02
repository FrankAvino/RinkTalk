//
//  PowerPlayViewController.h
//  RinkTalkTestingTwo
//
//  Created by Frank Avino on 3/3/15.
//  Copyright (c) 2015 Frank Avino. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PowerPlayViewController : UIViewController

@property PFObject *passesPowerPlay;
@property int passesPowerPlayCount;
@property NSDate *gameStart;
@property NSDate *timePassCounted;
@property NSString *userName;
@property NSString *userEmail;

@end
