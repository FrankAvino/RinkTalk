//
//  TurnoversOffensiveViewController.m
//  RinkTalkTestingTwo
//
//  Created by Frank Avino on 2/13/15.
//  Copyright (c) 2015 Frank Avino. All rights reserved.
//

#import "TurnoversViewController.h"

@interface TurnoversViewController ()
@property (weak, nonatomic) IBOutlet UILabel *offTurnoversLabelCount;
@property NSDate *now;

@end

@implementation TurnoversViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)recordOffensiveTurnover:(id)sender {
    
    self.turnovers = [PFObject objectWithClassName:@"Turnovers"];
    self.turnovers[@"Type"] = @"N/A";
    self.turnovers[@"Name"] = self.userName;
    self.turnovers[@"Email"] = self.userEmail;
    
    self.offensiveTurnoversCount = self.offensiveTurnoversCount + 1;
    
    self.offTurnoversLabelCount.text = [NSString stringWithFormat: @"Number of turnovers: %d", self.offensiveTurnoversCount];
    
    //now record timestamp
    self.timeTurnoverCounted = [NSDate date];
    NSTimeInterval executionTime = [self.timeTurnoverCounted timeIntervalSinceDate:self.gameStart];
    NSLog(@"executionTime(Seconds) = %f", executionTime);
    
    NSInteger minutes = floor(executionTime/60);
    NSInteger seconds = round(executionTime - minutes * 60);
    NSString *timeOfTurnover = [NSString stringWithFormat:@"%d:%02d", minutes, seconds];
    NSLog(@"Time of turnover: %@", timeOfTurnover);
    
    self.turnovers[@"Timestamp"] = timeOfTurnover;
    
    //record time of turnover as time of day
    self.now = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"hh:mm:ss";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:self.now]);
    self.turnovers[@"TurnoverTime"] = [dateFormatter stringFromDate:self.now];
    [self.turnovers saveInBackground];
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
