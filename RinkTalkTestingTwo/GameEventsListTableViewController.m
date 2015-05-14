//
//  GameEventsListTableViewController.m
//  RinkTalkTestingTwo
//
//  Created by Frank Avino on 4/6/15.
//  Copyright (c) 2015 Frank Avino. All rights reserved.
//

#import "GameEventsListTableViewController.h"
#import <Parse/Parse.h>

@interface GameEventsListTableViewController ()

@property (strong, nonatomic) NSMutableArray *eventsToShow;
@property (strong, nonatomic) NSMutableArray *eventTimesToShow;
@property (strong, nonatomic) NSMutableArray *eventRecordersToShow;


@end

@implementation GameEventsListTableViewController

- (void)viewDidLoad
{
    NSLog(@"Test1");
    [super viewDidLoad];
    _eventsToShow = [[NSMutableArray alloc] init];
    _eventTimesToShow = [[NSMutableArray alloc] init];
    _eventRecordersToShow = [[NSMutableArray alloc] init];
    [self loadEvents];
    NSLog(@"Test2");
}

- (void)loadEvents
{
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"submittedBy"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                
                PFObject *myGame = object[@"game"];
                
                if(myGame.objectId == _game.objectId){
                    //NSLog(@"We have found a game whose event we can display");
                    [_eventsToShow addObject:object[@"type"]];
                    [_eventTimesToShow addObject:object.createdAt];
                    NSString *myUser;
                    if(object[@"submittedBy"]){
                        myUser = object[@"submittedBy"][@"username"];
                    }
                    else{
                        myUser = object[@"guestName"];
                    }
                        //NSLog(@"User: %@", myUser);
                    
                    [_eventRecordersToShow addObject:myUser];
                    [self.tableView reloadData];
                    //NSLog(object[@"type"]);
                    
                }
            }
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //NSLog(@"Number of rows: @%f", _eventsToShow.count);
    
    
    return [_eventsToShow count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListPrototypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"hh:mm:ss a"];
    [timeFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"CST"]];
    NSString *newTime = [timeFormatter stringFromDate:[_eventTimesToShow objectAtIndex:indexPath.row]];
    //NSLog(@"%@ , ", newTime);
    newTime = [@"Rec. " stringByAppendingString: newTime];
    newTime = [newTime stringByAppendingString:@" by "];
    NSString *detailLabel = [newTime stringByAppendingString:[_eventRecordersToShow objectAtIndex:indexPath.row]];
    // Configure the cell...
    cell.textLabel.text = [_eventsToShow objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = detailLabel;
    
    // TODO make font bold if you user recorded a given row
    return cell;
}
@end