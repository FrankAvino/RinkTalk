//
//  HitsOffensiveViewController.h
//  RinkTalkTestingTwo
//
//  Created by Frank Avino on 2/1/15.
//  Copyright (c) 2015 Frank Avino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface HitsViewController : UIViewController

@property PFObject *hits;
@property int offensiveHitsCount;
@property NSDate *gameStart;
@property NSDate *timeHitCounted;
@property NSString *userName;
@property NSString *userEmail;

@end
