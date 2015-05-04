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

    
    NSURL *url1 = [[NSBundle mainBundle] URLForResource:self.imgFile withExtension:@"gif"];
    NSData *data1 = [NSData dataWithContentsOfURL:url1];

    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData: data1];
    
    self.tutorialImageView.animatedImage = image;
    self.tutorialLabel.text = self.txtTitle;
    self.descriptionLabel.text = self.txtDescription;
}

@end
