//
//  GamesListViewController.m
//  RinkTalkTestingTwo
//
//  Created by Henry Spindell on 4/4/15.
//  Copyright (c) 2015 Frank Avino. All rights reserved.
//

#import "GamesListViewController.h"
#import "EventsListViewController.h"
#import <Parse/Parse.h>

@interface GamesListViewController ()
@end

@implementation GamesListViewController



- (void)viewDidLoad{
    NSDate* now = [NSDate date];
    
    // Load all the upcoming games
    PFQuery *query = [PFQuery queryWithClassName:@"Game"];
    [query whereKey:@"startDate" greaterThan:now];
    [query findObjectsInBackgroundWithBlock:^(NSArray *games, NSError *error) {
        if (!error) {
            NSLog(@"Successfully retrieved %ld games.", games.count);
            self.upcomingGames = [[NSMutableArray alloc] initWithCapacity:games.count];
            
            // stores games in array self.upcomingGames
            for (PFObject *game in games) {
                [self.upcomingGames addObject: game];
            }
            
            // Frank - do something here to display each game as a button
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}


// TODO Need to be at the location to actually enter data?


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIButton *button = (UIButton *)sender;
    // TODO Save and pass selected game
    //[[segue destinationViewController] setGame: [self.upcomingGames objectAtIndex:0]];
    
    UINavigationController *navController = (UINavigationController*)[segue destinationViewController];
    EventsListViewController *destViewController = (EventsListViewController* )[navController topViewController];
    destViewController.navigationItem.title = button.titleLabel.text;
}


@end
