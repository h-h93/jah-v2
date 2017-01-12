//
//  mainTabController.m
//  jah v2
//
//  Created by Hanif Hussain on 21/10/2016.
//  Copyright © 2016 Hanif Hussain. All rights reserved.
//

#import "mainTabController.h"

@interface mainTabController ()

@end

@implementation mainTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    
    //CGFloat screenWidth = self.view.frame.size.width;
    //self.tabBar.frame =CGRectMake(0,0,self.view.frame.size.height - 320,self.view.frame.size.width);
    // Do any additional setup after loading the view.
    
   
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [self.tabBar invalidateIntrinsicContentSize];
    
    CGFloat tabSize = 70.0;
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if (UIInterfaceOrientationIsLandscape(orientation))
    {
        tabSize = 32.0;
    }
    
    CGRect tabFrame = self.tabBar.frame;
    
    tabFrame.size.height = tabSize;
    
    tabFrame.origin.y = self.view.frame.origin.y;
    
    self.tabBar.frame = tabFrame;

    UITabBarItem *Profile = [self.tabBar.items objectAtIndex:0];

   // Profile.title = @"People";
    
    [Profile initWithTitle:@"people" image:[UIImage imageNamed:@"/Users/hanifhussain/Documents/spanner.png"] tag:0];
    
    // Set the translucent property to NO then back to YES to
    // force the UITabBar to reblur, otherwise part of the
    // new frame will be completely transparent if we rotate
    // from a landscape orientation to a portrait orientation.
    
    self.tabBar.translucent = NO;
    self.tabBar.translucent = YES;
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
