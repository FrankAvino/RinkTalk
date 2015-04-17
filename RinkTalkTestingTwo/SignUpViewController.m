//
//  SignUpViewController.m
//  RinkTalkTestingTwo
//
//  Created by Henry Spindell on 4/5/15.
//  Copyright (c) 2015 Frank Avino. All rights reserved.
//

#import "AppDelegate.h"
#import "SignUpViewController.h"
#import <Parse/Parse.h>

@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassword;
@end

// TODO mulitthreading
// TODO loading symbol
// TODO disable buttons when forms not complete
@implementation SignUpViewController

- (IBAction)completeSignUp:(UIButton *)sender {

    PFUser *user = [PFUser user];
    user.username = self.username.text;
    user.password = self.password.text;
    user.email = self.email.text;
    
    NSString *emailIdentifier = @"@";
    if ([user.username rangeOfString:emailIdentifier].location != NSNotFound) {
        NSLog(@"Username may not contain an @ symbol, please try again.");
        return;
    }
    
    if(![user.password isEqualToString:self.confirmPassword.text]){
        NSLog(@"Passwords do not match, please try again.");
        return;
    }

    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Store the data
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:user.username forKey:@"username"];
            [defaults synchronize];
            // NSLog(@"User defaults data saved");
            
            AppDelegate *appDelegateTemp = [[UIApplication sharedApplication]delegate];
            appDelegateTemp.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
            
        } else {
            NSLog(@"Signup failed: ");
            NSString *errorString = [error userInfo][@"error"];
            NSLog(@"%@", errorString);
            // Show the errorString somewhere and let the user try again.
        }
    }];
    


}

@end
