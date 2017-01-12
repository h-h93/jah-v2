//
//  profileTabViewViewController.h
//  
//
//  Created by Hanif Hussain on 05/12/2016.
//
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
#import <MARKRangeSlider.h>

@interface profileTabViewViewController : UIViewController<UIImagePickerControllerDelegate>{
    
    IBOutlet UIScrollView *settingScrollPage1;
    IBOutlet UIScrollView *settingScrollPage3;
    IBOutlet UIScrollView *settingScrollPage2;
    IBOutlet UIPageControl *pageControl;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIScrollView *imageSelectorScroll;
    // 5 user profile images
    IBOutlet UIImageView *userImg1;
    IBOutlet UIImageView *userImg2;
    IBOutlet UIImageView *userImg3;
    IBOutlet UIImageView *userImg4;
    IBOutlet UIImageView *userImg5;
    UIImageView *Defaultprofilepic;
    NSData *imgData6;
    NSData *imgData1;
    NSData *imgData2;
    NSData *imgData3;
    NSData *imgData4;
    NSData *imgData5;
    IBOutlet UIImageView *profilePicHeader;
    IBOutlet UISlider *heightSlider;

    //keep track of which image activated touch gesture
    long tag;
    UIImagePickerController *ipc;
}

-(IBAction)changePage:(id)sender;

@end
