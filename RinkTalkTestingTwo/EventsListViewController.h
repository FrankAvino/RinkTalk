//
//  NewGameStartedViewController.h
//  RinkTalkTestingTwo
//
//  Created by Frank Avino on 2/1/15.
//  Copyright (c) 2015 Frank Avino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface EventsListViewController : UIViewController
@property PFObject *game;
@property NSMutableDictionary *eventTypes;
@property NSString *guestName;
@end
