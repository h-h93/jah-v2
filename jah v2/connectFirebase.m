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
    credential = [FIRFacebookAuthProvider
                                     credentialWithAccessToken:[FBSDKAccessToken currentAccessToken]
                                     .tokenString];
    //self.ref = [[FIRDatabase database] reference];
    NSString *userID = [FIRAuth auth].currentUser.uid;
    //NSLog(@"user id is %@", userID);
    if(userID == NULL){
        NSLog(@"user id is %@", userID);
        [[FIRAuth auth] signInWithCredential:credential
                                  completion:^(FIRUser *user, NSError *error) {
                                      if(error){
                                          NSLog(@"Firebase login error");
                                      }
                                      [self firstTimeLogin];
                                  }];
    }else{
    [self userExists];
    }

    /*
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
     */
    return connected;
}

-(void)userExists{
    self.ref = [[FIRDatabase database] reference];
    NSString *userID = [FIRAuth auth].currentUser.uid;
    [[[_ref child:@"Users"] child:userID] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        // Get user value
        if(snapshot.value != NULL){
            exists = YES;
            [self registeredUser];
            NSLog(@"exists ?: %i", exists);
        }else{
            exists = NO;
            [self firstTimeLogin];
            NSLog(@"exists ?: %i", exists);
        }
        
        // ...
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
    //return exists;
}

-(void)firstTimeLogin{
  //  NSString *key = [[_ref child:@"Users"] childByAutoId];
    NSDictionary *post = @{@"ID": [FIRAuth auth].currentUser.uid,
                           @"accountStatus": @"clean",
                           @"age": @"21",
                           @"bio": @"rekt"};
    NSDictionary *childUpdates = @{[@"/Users/" stringByAppendingString:[FIRAuth auth].currentUser.uid]: post};
    [_ref updateChildValues:childUpdates];
    connected = YES;
}

-(void) registeredUser{
    [[FIRAuth auth] signInWithCredential:credential
                              completion:^(FIRUser *user, NSError *error) {
                                  connected = YES;
                                  if(error){
                                      NSLog(@"Firebase login error");
                                      connected = NO;
                                  }
                                  
    }];
    
}

@end
