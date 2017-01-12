//
//  FirstTabView.m
//  jah v2
//
//  Created by Hanif Hussain on 13/10/2016.
//  Copyright © 2016 Hanif Hussain. All rights reserved.
//

#import "FirstTabView.h"


@implementation FirstTabView

- (void)viewDidLoad {
    [super viewDidLoad];
    frontCard = [[Person alloc] init];
    backCard = [[Person alloc] init];
    [self loadProfileOne];
    [self loadProfileTwo];
    // Do any additional setup after loading the view.
 
    //mc swipe choose  code
    // You can customize MDCSwipeToChooseView using MDCSwipeToChooseViewOptions.
    
    options = [MDCSwipeToChooseViewOptions new];
    options.delegate = self;
    options.likedText = @"Like";
    options.likedColor = [UIColor blueColor];
    options.nopeText = @"Dislike";
    options.onPan = ^(MDCPanState *state){
        if (state.thresholdRatio == 1.f && state.direction == MDCSwipeDirectionLeft) {
            NSLog(@"Let go now to choose!");
        }
    };

    imgView = [[MDCSwipeToChooseView alloc] initWithFrame:imgView.frame options:options];
    imgViewBack = [[MDCSwipeToChooseView alloc] initWithFrame:imgView.frame options:options];
    
  //  imgViewBack.backgroundColor = [UIColor blueColor];
    imgView.imageView.image = [frontCard image];
    imgViewBack.imageView.image = [backCard image];
    
    //[self loadImage];
    
   // pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRecognized:)];
    //pan.maximumNumberOfTouches = pan.minimumNumberOfTouches = 1;
    //[scrollView addGestureRecognizer:pan];
    //[scrollView setContentSize:CGSizeMake(320, 800)]   ;
    //[scrollView setScrollEnabled:YES];
    [innerScrollView setScrollEnabled:YES];
    [scrollView setShowsVerticalScrollIndicator:YES];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    
    swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedUP:)];
    [swipeUp setDirection:UISwipeGestureRecognizerDirectionUp];
    
    swipeUp.delaysTouchesBegan = TRUE;
    
    swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown:)];
    [swipeDown setDirection:UISwipeGestureRecognizerDirectionDown];
    
    swipeDown.delaysTouchesBegan = TRUE;
    
    //scrollView.delegate = self;self.backCardView = [self popPersonViewWithFrame:[self backCardViewFrame]];
    
    [scrollView addGestureRecognizer:swipeUp];
    [scrollView addGestureRecognizer:swipeDown];
    [profilePicHolder addSubview:imgView];
    [profilePicHolder insertSubview:imgViewBack belowSubview:imgView];
    [self.view addSubview:profilePicHolder];
    [self.view addSubview:scrollView];
    [scrollView addSubview:scrollImage];
    oldScrollFrame = scrollView.frame;
    oldImageFrame = profilePicHolder.frame;
    oldImgFrame = imgView.frame;
    
   // [scrollView addGestureRecognizer:swipeUp];
}


- (void)viewDidLayoutSubviews
{
    [scrollView setContentSize:CGSizeMake(320, self.view.frame.size.height* 1.5)];
    
    [innerScrollView setContentSize:CGSizeMake(320, self.view.frame.size.height)];
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.view setNeedsLayout];
   // [imgView setNeedsLayout];
    /*MXCardsSwipingView *cardsSwipingView = [[MXCardsSwipingView alloc] initWithFrame:CGRectMake(imgView.bounds.origin.x, imgView.bounds.origin.y, imgView.frame.size.width, imgView.frame.size.height)];
    
    cardsSwipingView.delegate = self;
    self.cardsSwipingView = cardsSwipingView;
    
    // [self addCard];
    // [self addCard];
    // we either have to add in constraints manually via code or remove the imgView from storyboard and create a new view via code above and supply initWithFrane:CGRectMake
    [self addCard];
    [self addCard];
    
    [imgView addSubview:cardsSwipingView];
    */
    
   // [scrollView setContentSize:CGSizeMake(320, 500)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)swipedUP:(id)sender
{
   // NSUInteger selectedIndex = [self.tabBarController selectedIndex];

    NSLog(@"in swipe up ,%f, %f, %f, %f", scrollView.frame.origin.x,scrollView.frame.origin.y, scrollView.frame.size.width, scrollView.frame.size.height);

    
        //change to only make it move upwards 293
        //   pan.enabled = YES;
    [UIView animateWithDuration:0.4f
                    animations:^{
                        scrollView.frame = CGRectMake(oldScrollFrame.origin.x, self.view.frame.size.height/2, oldScrollFrame.size.width, ([UIScreen mainScreen].bounds.size.height - self.view.frame.size.height/2));;
                        
                        /*
                        profilePicHolder.frame = CGRectMake(oldImageFrame.origin.x, oldImageFrame.origin.y, oldImageFrame.size.width, oldImageFrame.size.height/2);;
                        
                        imgView.frame = CGRectMake(oldImgFrame.origin.x,oldImgFrame.origin.y, oldImgFrame.size.width, oldImgFrame.size.height/2);;
                        */
                        }];

}

- (IBAction)swipeDown:(id)sender
{
        [UIView animateWithDuration:0.4f
                     animations:^{
                         scrollView.frame =  scrollView.frame = CGRectMake(oldScrollFrame.origin.x, oldScrollFrame.origin.y, oldScrollFrame.size.width, oldScrollFrame.size.height);
        
                     }];

    
    /*
    CATransition *anim= [CATransition animation];
    [anim setType:kCATransitionPush];
    [anim setSubtype:kCATransitionFromBottom];
    
    [anim setDuration:1];
    [anim setTimingFunction:[CAMediaTimingFunction functionWithName:
                             kCAMediaTimingFunctionEaseIn]];
    [self.tabBarController.view.layer addAnimation:anim forKey:@"fadeTransition"];
     */
}



- (void)loadImage{
   
    
}

///////////////// swipe to chose methods begin///////////////////////////////////////

- (void)loadProfileOne{
    [frontCard setName:@"firebase1"]; // get user location and name from database
    [frontCard setAge:23];
    [frontCard setBio:@"bio from firebase database"];
    [frontCard setImage:[UIImage imageNamed:@"arrows.png"]]; //get user images from firebase
   // [frontCard setInterests:<#(NSMutableArray *)#>]
}

- (void)loadProfileTwo{
    [backCard setName:@"firebase2"];
    [backCard setAge:23];
    [backCard setBio:@"bio from firebase database"];
    [backCard setImage:[UIImage imageNamed:@"google.png"]]; //get user images from firebase
    // [frontCard setInterests:<#(NSMutableArray *)#>]

    
}

- (void)undoPreviousSwipe{
    
}
// This is called when a user didn't fully swipe left or right.
- (void)viewDidCancelSwipe:(UIView *)view {
    NSLog(@"Couldn't decide, huh?");
}

// Sent before a choice is made. Cancel the choice by returning `NO`. Otherwise return `YES`.
- (BOOL)view:(UIView *)view shouldBeChosenWithDirection:(MDCSwipeDirection)direction {
    if (direction == MDCSwipeDirectionLeft) {
        return YES;
    } else if (direction == MDCSwipeDirectionRight){
        return YES;
    }else{
        // Snap the view back and cancel the choice.
        [UIView animateWithDuration:0.16 animations:^{
            view.transform = CGAffineTransformIdentity;
            view.center = [view superview].center;
        }];
        return NO;
    }
}

// This is called then a user swipes the view fully left or right.
- (void)view:(UIView *)view wasChosenWithDirection:(MDCSwipeDirection)direction {
    if (direction == MDCSwipeDirectionLeft) {
        NSLog(@"Disliked!");
    } else {
        NSLog(@"Liked!");
    }
    
    // MDCSwipeToChooseView removes the view from the view hierarchy
    // after it is swiped (this behavior can be customized via the
    // MDCSwipeOptions class). Since the front card view is gone, we
    // move the back card to the front, and create a new back card.
    //insert new. imgView subview
    imgView = [[MDCSwipeToChooseView alloc] initWithFrame:oldImgFrame options:options];
    imgView.imageView.image = [backCard image];
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [profilePicHolder addSubview:imgView];
                         [self.view addSubview:profilePicHolder];
                     } completion:nil];
    
    [self.view bringSubviewToFront:scrollView];
}

/////////// swipe to choose methods end//////////////////////////////////

/////// mxcard swiping view methods new lib //////////////////////////

//slide up panel methods end

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
