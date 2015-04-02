//
//  HitsOffensiveViewController.m
//  RinkTalkTestingTwo
//
//  Created by Frank Avino on 2/1/15.
//  Copyright (c) 2015 Frank Avino. All rights reserved.
//

#import "HitsViewController.h"
#import "NewGameStartedViewController.h"

#import <Parse/Parse.h>

@interface HitsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *offHitsLabelCount;
@property NSDate *now;

@end

@implementation HitsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Pressing the "play" button on the video
    //self.gameStart = [NSDate date]; //(this worked!)
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)recordOffenseHit:(id)sender {
    
    self.hits = [PFObject objectWithClassName:@"Hits"];
    self.hits[@"Type"] = @"N/A";
    self.hits[@"Name"] = self.userName;
    self.hits[@"Email"] = self.userEmail;

    self.offensiveHitsCount = self.offensiveHitsCount + 1;

    self.offHitsLabelCount.text = [NSString stringWithFormat: @"Number of hits: %d", self.offensiveHitsCount];
    
    //now record timestamp
    self.timeHitCounted = [NSDate date];
    NSTimeInterval executionTime = [self.timeHitCounted timeIntervalSinceDate:self.gameStart];
    NSLog(@"executionTime(Seconds) = %f", executionTime);
    
    NSInteger minutes = floor(executionTime/60);
    NSInteger seconds = round(executionTime - minutes * 60);
    NSString *timeOfHit = [NSString stringWithFormat:@"%d:%02d", minutes, seconds];
    NSLog(@"TimeOfHit: %@", timeOfHit);
    
   // NSTimeInterval timeSincePlayPressed = [self.timeHitCounted timeIntervalSinceDate:self.playPressed];
    
    self.hits[@"Timestamp"] = timeOfHit;
    
    
    //record time of hit as time of day
    self.now = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"hh:mm:ss";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:self.now]);
    self.hits[@"TimeOfHit"] = [dateFormatter stringFromDate:self.now];;
    [self.hits saveInBackground];
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
