//
//  PowerPlayViewController.m
//  RinkTalkTestingTwo
//
//  Created by Frank Avino on 3/3/15.
//  Copyright (c) 2015 Frank Avino. All rights reserved.
//

#import "PowerPlayViewController.h"

@interface PowerPlayViewController ()
@property NSDate *now;
@end

@implementation PowerPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)recordPowerPlayPass:(id)sender {
    self.passesPowerPlay = [PFObject objectWithClassName:@"PowerPlayPass"];
    self.passesPowerPlay[@"Type"] = @"N/A";
    self.passesPowerPlay[@"Name"] = self.userName;
    self.passesPowerPlay[@"Email"] = self.userEmail;
    
    self.passesPowerPlayCount = self.passesPowerPlayCount + 1;
    
    //record time of end
    self.now = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"hh:mm:ss";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:self.now]);
    self.passesPowerPlay[@"PassTime"] = [dateFormatter stringFromDate:self.now];
    [self.passesPowerPlay saveInBackground];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
