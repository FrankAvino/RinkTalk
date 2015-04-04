//
//  GamesListViewController.m
//  RinkTalkTestingTwo
//
//  Created by Henry Spindell on 4/4/15.
//  Copyright (c) 2015 Frank Avino. All rights reserved.
//

#import "GamesListViewController.h"
#import "EventsListViewController.h"

@interface GamesListViewController ()
@end

@implementation GamesListViewController

// TODO Load all the upcoming games into view from Parse DB

// TODO Need to be at the location to actually enter data?


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIButton *button = (UIButton *)sender;
    UINavigationController *navController = (UINavigationController*)[segue destinationViewController];
    EventsListViewController *destViewController = (EventsListViewController* )[navController topViewController];
    destViewController.navigationItem.title = button.titleLabel.text;
    
    // TODO Save and pass game ID of selected game
}


@end
