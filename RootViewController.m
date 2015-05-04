//
//  RootViewController.m
//  RinkTalkTestingTwo
//
//  Created by Henry Spindell on 5/4/15.
//  Copyright (c) 2015 Frank Avino. All rights reserved.
//

#import "RootViewController.h"
//RinkTalk helps coaches find time to teach your kids.

@implementation RootViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    _arrPageTitles = @[@"What is a hit?",@"This is a hit.",@"This is not a hit."];
    _arrPageDescriptions = @[@"There are certain things to look for.", @"He makes strong intentional contact with his shoulders.", @"It doesn't count if you miss."];
    _arrPageImages =@[@"RinkDiagram.png",@"hit.gif",@"missed_hit.gif"];
    // Create page view controller
    self.PageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.PageViewController.dataSource = self;
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.PageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    // Change the size of page view controller
    self.PageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    [self addChildViewController:_PageViewController];
    [self.view addSubview:_PageViewController.view];
    [self.PageViewController didMoveToParentViewController:self];
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    if ((index == 0) || (index == NSNotFound))
    {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    if (index == NSNotFound)
    {
        return nil;
    }
    index++;
    if (index == [self.arrPageTitles count])
    {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}


- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.arrPageTitles count] == 0) || (index >= [self.arrPageTitles count])) {
        return nil;
    }
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.imgFile = self.arrPageImages[index];
    pageContentViewController.txtTitle = self.arrPageTitles[index];
    pageContentViewController.txtDescription = self.arrPageDescriptions[index];
    pageContentViewController.pageIndex = index;
    return pageContentViewController;
}

-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.arrPageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}


@end
