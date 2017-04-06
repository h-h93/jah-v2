//
//  connectFirebase.m
//  
//
//  Created by hanif hussain on 06/04/2017.
//
//

#import "connectFirebase.h"

@implementation connectFirebase

-(BOOL)ConnectToFirebase{
    //authenticate and sign up to firebase
    FIRAuthCredential *credential = [FIRFacebookAuthProvider
                                     credentialWithAccessToken:[FBSDKAccessToken currentAccessToken]
                                     .tokenString];
    [[FIRAuth auth] signInWithCredential:credential
                              completion:^(FIRUser *user, NSError *error) {
                                  NSLog(@"user ID is %@ ", user.uid);
                                  //if user doesn't exist then create a user with basic info filled in from facebook
                                  if(self.userExists == NO){
                                      [self firstTimeLogin:user.uid];
                                      connected = YES;
                                  }
                                  if (error) {
                                      NSLog(@"Firebase login error");
                                      connected = NO;
                                  }
                              }];
    return connected;
}

-(BOOL)userExists{
    exists = NO;
    self.ref = [[FIRDatabase database] reference];
    
    NSString *userID = [FIRAuth auth].currentUser.uid;
    [[[_ref child:@"users"] child:userID] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        // Get user value
        if(snapshot.value != nil){
            exists = YES;
        }else{
            exists = NO;
        }
        
        // ...
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
    return exists;
}

-(void)firstTimeLogin:(id)userID{
    NSString *key = [[_ref child:@"Users"] childByAutoId];
    NSDictionary *post = @{@"ID": userID,
                           @"accountStatus": @"bad",
                           @"age": @"21",
                           @"bio": @"enter bio"};
    NSDictionary *childUpdates = @{[@"/Users/" stringByAppendingString:userID]: post};
    [_ref updateChildValues:childUpdates];
}

@end
