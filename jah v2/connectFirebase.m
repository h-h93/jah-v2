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

}

- (void)getFacebookData{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"mm/dd/yyyy"];
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"first_name, last_name, email, name, gender, id, birthday"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSLog(@"fetched user:%@", result);
             }
             
             name = [result objectForKey:@"name"];
             fbID = [result objectForKey:@"id"];
             gender = [result objectForKey:@"gender"];
             NSDate *birthdate = [dateformatter dateFromString:[result objectForKey:@"birthday"]];
             [self convertBirthdayToAge:birthdate];
             email = [result objectForKey:@"email"];
             //NSLog(@"%@", [result objectForKey:@"birthday"]);
             
         }];
    }
}

-(void)convertBirthdayToAge:(NSDate *)date{
    NSDate* now = [NSDate date];
    NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
                                       components:NSCalendarUnitYear
                                       fromDate:date
                                       toDate:now
                                       options:0];
    age = [NSString stringWithFormat:@"%li",(long)[ageComponents year]];
    NSLog(@"age is %@", age);
}

-(void)firstTimeLogin{
    NSString *version = [NSString stringWithFormat:@"%@ %@",@"IOS", [UIDevice currentDevice].systemVersion]; //grab ios version
    UIImage *Defaultprofilepic = UIImagePNGRepresentation([UIImage imageNamed:@"profile pics"]); //default image
    
    //connect to firebase storage to store userimage
     
    // Get a reference to the storage service using the default Firebase App
    FIRStorage *storage = [FIRStorage storage];
    
    // Create a storage reference from our storage service
    FIRStorageReference *storageRef = [storage referenceWithPath:@"users/city_of_love.jpg"]; /*this is the directory we specify to store our image along with the filename of the image we wish to store it as e.g. in user directory we store the image witht the name city of love*/
    UIImage *defaultImage = [UIImage imageNamed:@"profile pics"];//the image we wish to store
    FIRStorageMetadata *metaData;
    metaData.contentType = @"image/png";
    NSData *data = UIImageJPEGRepresentation(defaultImage, 0);
    FIRStorageUploadTask *uploadTask =  [storageRef putData:data metadata:metaData];
    
    [[[_ref child:@"Users"] child:[FIRAuth auth].currentUser.uid]
     setValue:@{@"ID": [FIRAuth auth].currentUser.uid,
                @"accountStatus": @"clean",
                @"age": age,
                @"appInfo": version,
                @"bio": @" ",
                @"email": email,
                @"ethnicity": @"",
                @"fbID": fbID,
                @"gender": gender,
                @"images":@{@"image 1":@"rekt", @"image 2":@"rekt2"}}
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
