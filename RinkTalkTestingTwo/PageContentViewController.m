//
//  PageContentViewController.m
//  RinkTalkTestingTwo
//
//  Created by Henry Spindell on 5/4/15.
//  Copyright (c) 2015 Frank Avino. All rights reserved.
//

#import "PageContentViewController.h"

@implementation PageContentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tutorialImageView.image = [UIImage imageNamed:self.imgFile];
    self.tutorialLabel.text = self.txtTitle;
    self.descriptionLabel.text = self.txtDescription;
}

@end
