//
//  GamesListViewController.m
//  RinkTalkTestingTwo
//
//  Created by Henry Spindell on 4/4/15.
//  Copyright (c) 2015 Frank Avino. All rights reserved.
//

#import "GamesListViewController.h"
#import "EventsListViewController.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface GamesListViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@end

@implementation GamesListViewController


- (IBAction)logout:(UIBarButtonItem *)sender {
    // Delete User credential from NSUserDefaults and other data related to user
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"username"];
    
    AppDelegate *appDelegateTemp = [[UIApplication sharedApplication]delegate];
    
    UIViewController* rootController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
    UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:rootController];
    appDelegateTemp.window.rootViewController = navigation;
}

- (void)viewDidLoad{
    // start animating spinner
    [_spinner startAnimating];
    
    NSDate* now = [NSDate date];
    
    // Load all the upcoming games
    // it's async so it doesn't need to be in a different thread?
    PFQuery *query = [PFQuery queryWithClassName:@"Game"];
    //[query whereKey:@"startDate" greaterThan:now];
    [query findObjectsInBackgroundWithBlock:^(NSArray *games, NSError *error) {
        if (!error) {
             NSLog(@"Successfully retrieved %lu games.", (unsigned long)games.count);
            _upcomingGames = [[NSMutableArray alloc] initWithCapacity:games.count];
            
            // stores games in array self.upcomingGames
            for (PFObject *game in games) {
                [_upcomingGames addObject: game];
            }
            
            // Frank - do something here to display each game as a button
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
        // make spinner disappear
        [_spinner stopAnimating];
    }];
}


// TODO Need to be at the location to actually enter data? maybe later


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIButton *button = (UIButton *)sender;
    UINavigationController *navController = (UINavigationController*)[segue destinationViewController];
    EventsListViewController *destViewController = (EventsListViewController* )[navController topViewController];
    destViewController.navigationItem.title = button.titleLabel.text;
    

    if ([[segue identifier] isEqualToString:@"St. Viator"]) {
        destViewController.game = [_upcomingGames objectAtIndex:1]; // pass selected game
    }
    
    if (_guestName){
        destViewController.guestName = _guestName;
    }

}

@end
