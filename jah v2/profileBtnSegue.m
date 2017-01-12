//
//  FirstTabCustomSegue.m
//  jah v2
//
//  Created by Hanif Hussain on 14/10/2016.
//  Copyright © 2016 Hanif Hussain. All rights reserved.
//

#import "profileBtnSegue.h"

@implementation profileBtnSegue

- (void)perform{
    // Add your own animation code here.
    //   UIViewController *firstVCView = self.sourceViewController;
    // UIViewController *secondVCView = self.destinationViewController;
    
    //ViewController *temp = [[ViewController alloc] init];
    
    
    [[self sourceViewController] presentViewController:[self destinationViewController] animated:YES completion:nil];
    
    
}


@end
