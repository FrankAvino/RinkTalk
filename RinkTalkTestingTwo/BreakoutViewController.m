//
//  BreakoutViewController.m
//  RinkTalkTestingTwo
//
//  Created by Frank Avino on 3/3/15.
//  Copyright (c) 2015 Frank Avino. All rights reserved.
//

#import "BreakoutViewController.h"

@interface BreakoutViewController ()
@property (weak, nonatomic) IBOutlet UIButton *breakoutStartBtn;
@property (weak, nonatomic) IBOutlet UIButton *breakoutEndBtn;
@property NSDate *now;

@end

@implementation BreakoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.breakoutEndBtn setEnabled:NO];
    [self.breakoutEndBtn setAlpha:0.42];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//start button starts clock at zero, and end button stores how long the breakout lasted
- (IBAction)startBreakout:(id)sender {
    //[sender setEnabled:false];
    //now record timestamp
    self.timeBreakoutStarted = [NSDate date];
    
    self.breakout = [PFObject objectWithClassName:@"Breakout"];
    
    [self.breakoutStartBtn setEnabled:NO];
    [self.breakoutStartBtn setAlpha:0.42];
    [self.breakoutEndBtn setEnabled:YES];
    [self.breakoutEndBtn setAlpha:1.0];
    
    //record time of start
    self.now = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"hh:mm:ss";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:self.now]);
    self.breakout[@"BreakoutStartTime"] =[dateFormatter stringFromDate:self.now];
    self.breakout[@"Name"] = self.userName;
    self.breakout[@"Email"] = self.userEmail;
    [self.breakout saveInBackground];
     }
- (IBAction)endBreakout:(id)sender {
    //[sender setEnabled:false];
    self.timeBreakoutEnded = [NSDate date];
    
    self.breakout = [PFObject objectWithClassName:@"Breakout"];
    
    [self.breakoutEndBtn setEnabled:NO];
    [self.breakoutEndBtn setAlpha:0.42];
    [self.breakoutStartBtn setEnabled:YES];
    [self.breakoutStartBtn setAlpha:1.0];
    
    
    NSTimeInterval executionTime = [self.timeBreakoutEnded timeIntervalSinceDate:self.timeBreakoutStarted];
    NSLog(@"executionTime(Seconds) = %f", executionTime);
    
    NSInteger minutes = floor(executionTime/60);
    NSInteger seconds = round(executionTime - minutes * 60);
    NSString *timeOfBreakout = [NSString stringWithFormat:@"%d:%02d", minutes, seconds];
    NSLog(@"Length of breakout: %@", timeOfBreakout);
    
    // NSTimeInterval timeSincePlayPressed = [self.timeHitCounted timeIntervalSinceDate:self.playPressed];
    
    self.breakout[@"Timestamp"] = timeOfBreakout;
    
    //record time of end
    self.now = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"hh:mm:ss";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:self.now]);
    self.breakout[@"BreakoutEndTime"] = [dateFormatter stringFromDate:self.now];
    self.breakout[@"Name"] = self.userName;
    self.breakout[@"Email"] = self.userEmail;
    [self.breakout saveInBackground];
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
