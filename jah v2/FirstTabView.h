//
//  FirstTabView.h
//  jah v2
//
//  Created by Hanif Hussain on 13/10/2016.
//  Copyright © 2016 Hanif Hussain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "MDCSwipeToChoose.h"
#import "AppDelegate.h"
#import "Person.h"
#import "CheckConnections.h"


@interface FirstTabView : UIViewController<MDCSwipeToChooseDelegate> {
    //MXCardsSwipingView *imgView;
    MDCSwipeToChooseViewOptions *options;
    Person *frontCard;
    Person *backCard;
    Person *undoCard;
    IBOutlet UIImageView *scrollImage;
    IBOutlet UIScrollView *innerScrollView;
    IBOutlet UIView *profilePicHolder;
    IBOutlet MDCSwipeToChooseView *imgView;
    MDCSwipeToChooseView *imgViewBack;
    UIPanGestureRecognizer * pan;
    IBOutlet UIScrollView *scrollView;
    UISwipeGestureRecognizer *swipeUp;
    UISwipeGestureRecognizer *swipeDown;
    //IBOutlet UIView *imgView;
   // MXMemberCardView *card;
    CGRect oldScrollFrame;
    CGRect oldImageFrame; //outer image frame the one that holds our image view
    CGRect oldImgFrame; //inner image view the one that we can swipe on
    NSMutableArray *personList;//use this vector to hold list of people start off with 100 users then clear vector and reload another 100
    Boolean isLiked;
    IBOutlet UILabel *userNameLocation;
    IBOutlet UITextView *userBio;
    IBOutlet UILabel *interest1;
    IBOutlet UILabel *interest2;
    IBOutlet UILabel *interest3;
    IBOutlet UILabel *interest4;
    IBOutlet UILabel *interest5;
    IBOutlet UILabel *interest6;
    IBOutlet UILabel *interest7;
    IBOutlet UILabel *interest8;
    IBOutlet UILabel *interest9;
    IBOutlet UILabel *interest10;
    NSString *location;

}
/*
- (BOOL)cardsSwipingView:(MXCardsSwipingView *)cardsSwipingView willDismissCard:(UIView *)card toLeft:(BOOL)toLeft;
 */
@property (nonatomic, strong) Person *currentPerson;
@property (nonatomic) NSString *location;

//- (void)pan:(UIPanGestureRecognizer *)aPan;
- (void) addCard;
- (void) loadProfileOne;
- (void) undoPreviousSwipe;
- (void) loadProfileTwo;


@end
