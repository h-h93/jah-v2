//
//  ViewController.m
//  jah v2
//
//  Created by Hanif Hussain on 08/10/2016.
//  Copyright © 2016 Hanif Hussain. All rights reserved.
//

#import "ViewController.h"
#import "Reachability.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize loggedInVar;

// viewDidLoad called only once and that is during initial start up never called again
- (void)viewDidLoad {
    [super viewDidLoad];
    
    fbBtn = [[UIButton alloc] init];
    
    // put the code below in to own method and if not connected to network show pop up and remove user facebook token have to put it in view did appear as view did load will not show alert because the main view is still being set up
    
   // [self networkStatus];
    
    geocoder = [[CLGeocoder alloc] init];
    if (locationManager == nil)
    {
        locationManager = [[CLLocationManager alloc] init];
        [locationManager requestWhenInUseAuthorization];
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        locationManager.delegate = self;
    }
    [locationManager startUpdatingLocation];
    
 
    
    
    
    /*
     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString( @"Enter your title here", @"" ) message:NSLocalizedString( @"Enter your message here.", @"" ) preferredStyle:UIAlertControllerStyleAlert];
     
     UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString( @"Cancel", @"" ) style:UIAlertActionStyleCancel handler:nil];
     UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:NSLocalizedString( @"Settings", @"" ) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:
     UIApplicationOpenSettingsURLString]];
     }];
     
     [alertController addAction:cancelAction];
     [alertController addAction:settingsAction];
     
     [self presentViewController:alertController animated:YES completion:nil];
     
     */
    
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //if the user logs out and then tries to log in again they will be taken back to the login screen and we need to make sure NSNotification is running again to check if they've logged in. viewDidAppear is the method to put it in.
    
    //this is where you put the code because once they click on facebook button a new view appears and they sign in then the view is switched back to this view and viewDidAppear is called.
    //if([FBSDKAccessToken currentAccessToken] != nil){
    // titleLbl.textColor = [UIColor blueColor];
    // fbBtn.hidden = YES;
    [super viewDidLoad];
    [self networkStatus]; // maybe move this call after animation colour call
    [UIView animateWithDuration:1.0 animations:^{
        logInView.backgroundColor = [UIColor redColor];
    }];
    NSLog(@"in view did appear");
    [self loadDestinationVC];
    
}

- (void)networkStatus{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        connectedToNet = NO;
        UIAlertController *networkAlert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Unable to connect to network", @"enable network") message:NSLocalizedString(@"Jah requires a valid internet connection to function", @"do it") preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"") style:UIAlertActionStyleCancel handler:nil];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){}];
        
        [networkAlert addAction:cancelAction];
        [networkAlert addAction:okAction];
        
        [self presentViewController:networkAlert animated:YES completion:nil];
        
    } else {
        NSLog(@"There IS internet connection");
        connectedToNet = YES;
    }
    
}



-(void)loadDestinationVC{
    if([FBSDKAccessToken currentAccessToken] != nil && connectedToNet == YES){
        [self performSegueWithIdentifier:@"proceedToTab" sender:nil];
        NSLog(@"connected to net? %i",connectedToNet);
    }else{
        
    }
}

- (void)unwindForSegue:(UIStoryboardSegue *)unwindSegue towardsViewController:(UIViewController *)subsequentVC{
    
}

- (void)listenForlogin{
    //register to listen for events
    /*  [[NSNotificationCenter defaultCenter] addObserver:self
     selector:@selector(checkLogin:)
     name:nil object:nil];
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginAction {
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile", @"email"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
         }
     }];
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *newLocation = [locations lastObject];
    
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error == nil) {
            placemark = [placemarks lastObject];
            
            NSString *latitude, *longitude, *state, *country;
            
            latitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
            longitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
            state = placemark.administrativeArea;
            country = placemark.country;
            
            NSLog(@"location is: %@, ", latitude);
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    }];
    
    // Turn off the location manager to save power.
    [manager stopUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString( @"Unable to obtain location", @"enable location" ) message:NSLocalizedString( @"This app requires location services to be enabled, please enable location services.", @"do it" ) preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString( @"Cancel", @"" ) style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *settingsAction =[UIAlertAction actionWithTitle:NSLocalizedString( @"Settings", @"location" ) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        });
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:settingsAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    NSLog(@"Cannot find the location.");
    
    /*
     UIAlertController* alert = [UIAlertController
     alertControllerWithTitle:@"Alert"
     message:@"No connection"
     preferredStyle:UIAlertControllerStyleAlert];
     
     UIAlertAction* defaultAction = [UIAlertAction
     actionWithTitle:@"OK" style:UIAlertActionStyleDefault
     handler:^(UIAlertAction * action) {}];
     
     [alert addAction:defaultAction];
     [self presentViewController:alert animated:YES completion:nil];
     */
}



//could use notification to check if logged in or delegates but remember to kill or remove notification if logged in

@end
