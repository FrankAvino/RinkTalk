//
//  RootViewController.h
//  RinkTalkTestingTwo
//
//  Created by Henry Spindell on 5/4/15.
//  Copyright (c) 2015 Frank Avino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"
@interface RootViewController : UIViewController
<UIPageViewControllerDataSource>

@property (nonatomic,strong) UIPageViewController *PageViewController;
@property (nonatomic,strong) NSArray *arrPageTitles;
@property (nonatomic,strong) NSArray *arrPageDescriptions;
@property (nonatomic,strong) NSArray *arrPageImages;

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index;
@end
