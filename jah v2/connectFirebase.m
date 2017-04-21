//
//  connectFirebase.m
//
//
//  Created by hanif hussain on 06/04/2017.
//
//

#import "connectFirebase.h"

@implementation connectFirebase

-(void)ConnectToFirebases:(FBSDKAccessToken *)currentAccessToken{
    //really important you initialise the reference first to the root node or any node you wish to write data to in the database, otherwise nothing will ever write to the database
    [self getFacebookData];
    _ref = [[FIRDatabase database] reference];
    
    //authenticate and sign up to firebase
    credential = [FIRFacebookAuthProvider
                                     credentialWithAccessToken:currentAccessToken
                                     .tokenString];

    //self.ref = [[FIRDatabase database] reference];
    NSString *userID = [FIRAuth auth].currentUser.uid;
    NSLog(@"user id is %@", userID);
    if(userID == NULL){
        [[FIRAuth auth] signInWithCredential:credential
                                  completion:^(FIRUser *user, NSError *error) {
                                      if(error){
                                          NSLog(@"Firebase login error");
                                      }
                                  }];
        NSLog(@"user id is %@", userID);
        [self performSelector:@selector(firstTimeLogin) withObject:nil afterDelay:6.0];
        
    }else{
    [self registeredUser];
    }

    //return connected;
}

- (void)getFacebookData{
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"first_name, last_name, email, name, gender, id, birthday"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSLog(@"fetched user:%@", result);
             }
             
             name = [result objectForKey:@"name"];
             fbID = [result objectForKey:@"id"];
             gender = [result objectForKey:@"gender"];
             age = [result objectForKey:@"birthday"];
             //NSLog(@"%@", [result objectForKey:@"birthday"]);
             
         }];
    }
    
    NSLog(@"bday is: %@",age);
}

-(void)convertBirthdayToAge:(NSDate *)date{

    
    NSDate* now = [NSDate date];
    NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
                                       components:NSCalendarUnitYear
                                       fromDate:date
                                       toDate:now
                                       options:0];
    age = [NSString stringWithFormat:@"%li",(long)[ageComponents year]];
}

-(void)firstTimeLogin{
    NSString *version = [NSString stringWithFormat:@"%@ %@",@"IOS", [UIDevice currentDevice].systemVersion];
    NSLog(@"%@", version);
    [[[_ref child:@"Users"] child:[FIRAuth auth].currentUser.uid]
     setValue:@{@"ID": [FIRAuth auth].currentUser.uid,
                @"accountStatus": @"clean",
                @"age": @"30",
                @"appInfo": version,
                @"bio": @" "}
     ];

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
                                  NSLog(@"I'm registered");
                                  
    }];
    
    
}

@end
