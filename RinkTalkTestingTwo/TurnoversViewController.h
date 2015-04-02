//
//  TurnoversOffensiveViewController.h
//  RinkTalkTestingTwo
//
//  Created by Frank Avino on 2/13/15.
//  Copyright (c) 2015 Frank Avino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface TurnoversViewController : UIViewController

@property PFObject *turnovers;
@property int offensiveTurnoversCount;
@property NSDate *gameStart;
@property NSDate *timeTurnoverCounted;
@property NSString *userName;
@property NSString *userEmail;

@end
