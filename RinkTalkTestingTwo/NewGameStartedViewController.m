//
//  NewGameStartedViewController.m
//  RinkTalkTestingTwo
//
//  Created by Frank Avino on 2/1/15.
//  Copyright (c) 2015 Frank Avino. All rights reserved.
//

#import "NewGameStartedViewController.h"
#import "VideoTimer.h"
#import "HitsViewController.h"

#import <Parse/Parse.h>

@interface NewGameStartedViewController () <UIAlertViewDelegate>
@property NSString *userName;
@property NSString *userEmail;

@end

@implementation NewGameStartedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    VideoTimer *myTimer = [[VideoTimer alloc] init];
    
    //this value is initiated once we press "Start a new game"
    myTimer.playPressed = [NSDate date];
    
    NSString *alertTitle = @"Please enter your full name and email address!";
    NSString *alertMessage = @"This will be used to match you with your event input.";
    NSString *alertOkButtonText = @"Done";
    
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alertTitle
                                                                                 message:alertMessage
                                            
                                                                          preferredStyle:UIAlertControllerStyleAlert
                                                                        ];
        //We add buttons to the alert controller by creating UIAlertActions:
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:alertOkButtonText
                                                           style:UIAlertControllerStyleAlert
                                                         handler:^(UIAlertAction * action) {
                                                             // access text from text field
                                                             self.userName = ((UITextField *)[alertController.textFields objectAtIndex:0]).text;
                                                             self.userEmail = ((UITextField *)[alertController.textFields objectAtIndex:1]).text;
                                                             NSLog(self.userName);
                                                         }]; //You can use a block here to handle a press on this button
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       [alertController dismissViewControllerAnimated:YES completion:nil];
                                                   }];
        [alertController addAction:actionOk];
    [alertController addAction:cancel];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"First and last name";
        self.userName = textField.text;
        
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Email address";
        self.userEmail = textField.text;
    }];
        [self presentViewController:alertController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"Starting game clock.");
    [[segue destinationViewController] setGameStart:[NSDate date]];
    [[segue destinationViewController] setUserName:self.userName];
    [[segue destinationViewController] setUserEmail:self.userEmail];
}


@end
