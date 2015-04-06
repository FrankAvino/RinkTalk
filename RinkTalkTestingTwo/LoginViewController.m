//
//  LoginViewController.m
//  RinkTalkTestingTwo
//
//  Created by Henry Spindell on 4/4/15.
//  Copyright (c) 2015 Frank Avino. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *emailOrUsername;
@end

@implementation LoginViewController

// TODO mulitthreading
// TODO loading symbol
- (IBAction)logIn:(UIButton *)sender {
    NSString *username = self.emailOrUsername.text;
    
    // check for @ symbol
    NSString *emailIdentifier = @"@";
    if ([username rangeOfString:emailIdentifier].location != NSNotFound) {
        //"username" contains the email identifier @, therefore this is an email. Pull down the username.
        PFQuery *query = [PFUser query];
        [query whereKey:@"email" equalTo:username];
        NSArray *foundUsers = [query findObjects];
        
        if([foundUsers count] == 1) {
            for (PFUser *foundUser in foundUsers) {
                username = [foundUser username];
            }
        }
    }
    
    [PFUser logInWithUsernameInBackground:username password:self.password.text block:^(PFUser *user, NSError *error){
        if (user) {
            // Store the data
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:user.username forKey:@"username"];
            [defaults synchronize];
            NSLog(@"User defaults data saved");
            
            AppDelegate *appDelegateTemp = [[UIApplication sharedApplication]delegate];
            appDelegateTemp.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
            
        } else {
            NSLog(@"Login failed: ");
            NSString *errorString = [error userInfo][@"error"];
            NSLog(@"%@", errorString);
        }
    }];
}

@end
