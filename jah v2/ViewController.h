//
//  ViewController.h
//  jah v2
//
//  Created by Hanif Hussain on 08/10/2016.
//  Copyright © 2016 Hanif Hussain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "AppDelegate.h"
#import "CheckConnections.h"
@import Firebase;

@interface ViewController : UIViewController <CLLocationManagerDelegate>{

    
    IBOutlet UIView *logInView;    
    IBOutlet UILabel *titleLbl;
    IBOutlet UIButton *fbBtn;
    BOOL loggedInVar;
    BOOL connectedToNet;
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    
    
}
@property BOOL loggedInVar;

- (void)LoggedIn;

- (void)networkStatus;

@end

