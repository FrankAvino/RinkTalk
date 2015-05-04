//
//  PageContentViewController.h
//  RinkTalkTestingTwo
//
//  Created by Henry Spindell on 5/4/15.
//  Copyright (c) 2015 Frank Avino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLAnimatedImage.h"

@interface PageContentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *tutorialLabel;
@property (weak, nonatomic) IBOutlet FLAnimatedImageView *tutorialImageView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property NSUInteger pageIndex;
@property NSString *imgFile;
@property NSString *txtTitle;
@property NSString *txtDescription;
@end
