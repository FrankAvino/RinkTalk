//
//  PenaltyKillViewController.m
//  RinkTalkTestingTwo
//
//  Created by Frank Avino on 3/3/15.
//  Copyright (c) 2015 Frank Avino. All rights reserved.
//

#import "PenaltyKillViewController.h"

@interface PenaltyKillViewController ()
@property NSDate *now;
@end

@implementation PenaltyKillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)recordIcingPenaltyKill:(id)sender {
    self.icingPenaltyKill = [PFObject objectWithClassName:@"PenaltyKillIcing"];
    self.icingPenaltyKill[@"Type"] = @"N/A";
    self.icingPenaltyKill[@"Name"] = self.userName;
    self.icingPenaltyKill[@"Email"] = self.userEmail;
    
    self.icingPenaltyKillCount = self.icingPenaltyKillCount + 1;
    
    //record time of icing
    self.now = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"hh:mm:ss";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:self.now]);
    self.icingPenaltyKill[@"IcingTime"] = [dateFormatter stringFromDate:self.now];
    [self.icingPenaltyKill saveInBackground];
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
