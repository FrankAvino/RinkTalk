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
    [_spinner startAnimating];
    
    NSDate *now = [NSDate date];
    
    // Load all the upcoming games
    PFQuery *query = [PFQuery queryWithClassName:@"Game"];
    [query whereKey:@"startDate" greaterThan:now];
    [query findObjectsInBackgroundWithBlock:^(NSArray *games, NSError *error) {
        if (!error) {
             NSLog(@"Successfully retrieved %lu games.", (unsigned long)games.count);
            _upcomingGames = [[NSMutableArray alloc] initWithCapacity:games.count];
            
            for (PFObject *game in games) {
                [_upcomingGames addObject: game];
            }
            
            // TODO dynamically generate game button list
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
        [_spinner stopAnimating];
    }];
}


// TODO Need to be at the location to actually enter data? maybe later


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIButton *button = (UIButton *)sender;

    if ([[segue identifier] isEqualToString:@"Team1"]) {
        EventsListViewController *destViewController = (EventsListViewController* ) [segue destinationViewController];
        destViewController.navigationItem.title = button.titleLabel.text;
        destViewController.game = [_upcomingGames objectAtIndex:0]; // pass selected game
        
        if (_guestName){
            destViewController.guestName = _guestName;
        }
    }

}

@end
