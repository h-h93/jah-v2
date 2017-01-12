//
//  peopleBtnSegue.m
//  jah v2
//
//  Created by Hanif Hussain on 15/11/2016.
//  Copyright © 2016 Hanif Hussain. All rights reserved.
//

#import "peopleBtnSegue.h"

@implementation peopleBtnSegue

- (void)perform{
    // Add your own animation code here.
    //   UIViewController *firstVCView = self.sourceViewController;
    // UIViewController *secondVCView = self.destinationViewController;
    
    //ViewController *temp = [[ViewController alloc] init];
    
    
    [[self sourceViewController] presentViewController:[self destinationViewController] animated:YES completion:nil];
    
    
}

@end
