//
//  CheckConnections.h
//  jah v2
//
//  Created by Hanif Hussain on 16/10/2016.
//  Copyright © 2016 Hanif Hussain. All rights reserved.
//

#ifndef CheckConnections_h
#define CheckConnections_h
#import<CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface CheckConnections : UIViewController <CLLocationManagerDelegate>{
    
    CLLocationManager *locationManager;
    

    BOOL locationServices;
}

- (BOOL) locationServices;
- (void) grabLocationData;


@end




#endif /* CheckConnections_h */
