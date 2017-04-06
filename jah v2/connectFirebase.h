//
//  connectFirebase.h
//  jah v2
//
//  Created by hanif hussain on 06/04/2017.
//  Copyright © 2017 Hanif Hussain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
@import Firebase;

@interface connectFirebase : NSObject {
    BOOL exists;
    BOOL connected;
}

@property (strong, nonatomic) FIRDatabaseReference *ref;

-(BOOL)ConnectToFirebase;

-(BOOL)userExists;

@end
