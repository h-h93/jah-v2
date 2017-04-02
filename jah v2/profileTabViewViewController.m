//
//  profileTabViewViewController.m
//
//
//  Created by Hanif Hussain on 05/12/2016.
//
//

#import "profileTabViewViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface profileTabViewViewController ()

@property (nonatomic) YIPopupTextView* popupTextView;

@end

@implementation profileTabViewViewController


#define SCROLLWIDTH 414
#define MAS_SHORTHAND

- (void)viewDidLoad {
    [super viewDidLoad];
    //show status bar
    shouldHideStatusBar = NO;
    // Do any additional setup after loading the view.]
    Defaultprofilepic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"profile pics"]];
    profilePicHeader.layer.cornerRadius = profilePicHeader.frame.size.height /2;
    profilePicHeader.layer.masksToBounds = YES;
    profilePicHeader.layer.borderWidth = 0;
    
    profilePicHeader.image = [UIImage imageNamed:@"profile pics"];
    
    imgData6 = UIImagePNGRepresentation(Defaultprofilepic.image);
    
    UITapGestureRecognizer *image1Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedImage:)];
    [userImg1 addGestureRecognizer:image1Tap];
    userImg1.tag=1;
    
    UITapGestureRecognizer *image2Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedImage:)];
    [userImg2 addGestureRecognizer:image2Tap];
    userImg2.tag = 2;
    
    UITapGestureRecognizer *image3Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedImage:)];
    [userImg3 addGestureRecognizer:image3Tap];
    userImg3.tag = 3;
    
    UITapGestureRecognizer *image4Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedImage:)];
    [userImg4 addGestureRecognizer:image4Tap];
    userImg4.tag = 4;
    
    UITapGestureRecognizer *image5Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedImage:)];
    [userImg5 addGestureRecognizer:image5Tap];
    userImg5.tag = 5;
    
    userImg5.image = [UIImage imageNamed:@"profile pics"];
    
    heightLbl.text = [NSString stringWithFormat:@"%.2f cm", heightSlider.value];

    weightLbl.text = [NSString stringWithFormat:@"%.2f kg", weightSlider.value];

    
    
    //[scrollView addSubview:settingScrollPage1];
    // [settingScrollPage1 addSubview:settingScrollPage2];
    //[settingScrollPage1 addSubview:settingScrollPage3];
    
    
    scrollView.contentSize=CGSizeMake(SCROLLWIDTH*3, scrollView.frame.size.height);
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    [scrollView setScrollEnabled:YES];
    [settingScrollPage1 setScrollEnabled:YES];
    [currentScrollView setScrollEnabled:YES];
    [scrollView setShowsVerticalScrollIndicator:YES];
    //[settingScrollPage1 addSubview:imageSelectorScroll];
    //[settingScrollPage1 removeFromSuperview];
    
    for (int i =0; i<3; i++)
    {
        currentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(SCROLLWIDTH*i, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
        [currentScrollView setBounces:NO];
        
        if (i==0)
        {
            currentScrollView = settingScrollPage1;
            
        }
        else if (i==1)
        {
            
            currentScrollView = settingScrollPage2;
        }
        else
        {
            currentScrollView.backgroundColor = [UIColor yellowColor];
        }
        [scrollView addSubview:currentScrollView];
        [self.view addSubview:scrollView];
        
    }
    

    
    
    //setup and initialise our picker view for ethnicity popup display
    ethnicity = @[@"White", @"Black", @"Asian", @"Latin", @"Other"];
    
    //setup and initialise our picker view for education popup display
    education = @[@"Primary school", @"Secondary school", @"College", @"Undergraduate", @"Masters/Phd"];
   

    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.view setNeedsLayout];
    //userImg1.image = [UIImage imageWithContentsOfFile:self.assets[0]];
    // NSLog(@"assets 0 is: %@",self.assets[0]);
    
}

- (void)viewDidLayoutSubviews{
    [imageSelectorScroll setContentSize:CGSizeMake(590, imageSelectorScroll.frame.size.height)];
    [settingScrollPage1 setContentSize:CGSizeMake(settingScrollPage1.frame.size.width, settingScrollPage1.frame.size.height+200)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/////////////// image picker methods begin ////////////////////////////////////

- (IBAction)tappedImage:(UITapGestureRecognizer*)sender{
    imgData1 = UIImagePNGRepresentation(userImg1.image);
    imgData2 = UIImagePNGRepresentation(userImg2.image);
    imgData3 = UIImagePNGRepresentation(userImg3.image);
    imgData4 = UIImagePNGRepresentation(userImg4.image);
    imgData5 = UIImagePNGRepresentation(userImg5.image);
    
    ipc = [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    if(sender.view.tag == 1){
        tag = 1; //record which imageview activated the tap
    }else if(sender.view.tag == 2){
        tag = 2;
    }else if(sender.view.tag == 3){
        tag = 3;
    }else if(sender.view.tag == 4){
        tag = 4;
    }else if(sender.view.tag == 5){
        tag = 5;
    }
    
    
    [self presentViewController:ipc animated:YES completion:nil];
    
}

#pragma mark - ImagePickerController Delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //[self compressImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
    /*
     NSData *imageData = [[NSData alloc] initWithData:UIImageJPEGRepresentation(([info objectForKey:UIImagePickerControllerOriginalImage]), 1.0)];
     int imageSize = imageData.length;
     NSLog(@"SIZE OF IMAGE: %i ", imageSize);
     */
    if(tag == 1){
        userImg1.image = [self compressImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
        [self checkAndSetPics];
    }else if(tag == 2){
        userImg2.image = [self compressImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
        [self checkAndSetPics];
    }else if(tag == 3){
        userImg3.image = [self compressImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
        [self checkAndSetPics];
    }else if(tag == 4){
        userImg4.image = [self compressImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
        [self checkAndSetPics];
    }else if(tag == 5){
        userImg5.image = [self compressImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
        [self checkAndSetPics];
    }

}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)checkAndSetPics{
    // check all the images and see which ones equal default image in order then we populate each image in order from 1 to 5 depending on how many images there are
    if(tag == 2){ //  check image 2
        if([imgData1 isEqual:imgData6]){
            userImg1.image = userImg2.image;
            userImg2.image = [UIImage imageNamed:@"profile pics"];
        }
    }else if(tag == 3){ // check image 3
        if([imgData1 isEqual:imgData6]){
            userImg1.image = userImg3.image;
            userImg3.image = [UIImage imageNamed:@"profile pics"];
        }else if([imgData2 isEqual:imgData6]){
            userImg2.image = userImg3.image;
            userImg3.image = [UIImage imageNamed:@"profile pics"];
        }
    }else if(tag == 4){ // check image 4
        if([imgData1 isEqual:imgData6]){
            userImg1.image = userImg4.image;
            userImg4.image = [UIImage imageNamed:@"profile pics"];
        }else if([imgData2 isEqual:imgData6]){
            userImg2.image = userImg4.image;
            userImg4.image = [UIImage imageNamed:@"profile pics"];
        }else if([imgData3 isEqual:imgData6]){
            userImg3.image = userImg4.image;
            userImg4.image = [UIImage imageNamed:@"profile pics"];
        }
    }else if(tag == 5){ // check image 5
        if([imgData1 isEqual:imgData6]){
            userImg1.image = userImg5.image;
            userImg5.image = [UIImage imageNamed:@"profile pics"];
        }else if([imgData2 isEqual:imgData6]){
            userImg2.image = userImg5.image;
            userImg5.image = [UIImage imageNamed:@"profile pics"];
        }else if([imgData3 isEqual:imgData6]){
            userImg3.image = userImg5.image;
            userImg5.image = [UIImage imageNamed:@"profile pics"];
        }else if([imgData4 isEqual:imgData6]){
            userImg4.image = userImg5.image;
            userImg5.image = [UIImage imageNamed:@"profile pics"];
        }
    }
    
    [self.view setNeedsLayout];
    //clear up resources
    imgData1 = nil;
    imgData2 = nil;
    imgData3 = nil;
    imgData4 = nil;
    imgData5 = nil;
    
}

- (UIImage *)compressImage:(UIImage *)image{
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    float maxHeight = 1200;
    float maxWidth = 1200;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = maxWidth/maxHeight;
    float compressionQuality = 0.25;//25 percent compression
    
    if (actualHeight > maxHeight || actualWidth > maxWidth) {
        if(imgRatio < maxRatio){
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        }
        else if(imgRatio > maxRatio){
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        }else{
            actualHeight = maxHeight;
            actualWidth = maxWidth;
        }
    }
    
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    NSData *imageData = UIImageJPEGRepresentation(img, compressionQuality);
    UIGraphicsEndImageContext();
    
    //int imageSize = imageData.length;
    //NSLog(@"SIZE OF IMAGE: %i ", imageSize);
    return [UIImage imageWithData:imageData];
}

-(IBAction)deleteImage:(id)sender{
   //this is the remove image button press method, need to check which image was removed and shuffle them around

    if(deleteImg1Btn.isTouchInside){
        //userImg1.image = [UIImage imageNamed:@"profile pics"];
        deleteBtnTag = 1;
        NSLog(@"in button press 1, tag is: %li", tag);
       // [self checkAndSetPics];
    }else if(deleteImg2Btn.isTouchInside){
        //userImg2.image = [UIImage imageNamed:@"profile pics"];
        deleteBtnTag = 2;
        NSLog(@"in button press 2, tag is: %li", tag);
       // [self checkAndSetPics];
    }else if(deleteImg3Btn.isTouchInside){
        //userImg3.image = [UIImage imageNamed:@"profile pics"];
        deleteBtnTag = 3;
        NSLog(@"in button press 3, tag is: %li", tag);
        //[self checkAndSetPics];
    }else if(deleteImg4Btn.isTouchInside){
        //userImg4.image = [UIImage imageNamed:@"profile pics"];
        deleteBtnTag = 4;
        //[self checkAndSetPics];
    }else if(deleteImg5Btn.isTouchInside){
       // userImg5.image = [UIImage imageNamed:@"profile pics"];
        deleteBtnTag = 5;
        //[self checkAndSetPics];
    }
    
    [self resetUserImgPosition];
}

-(void)resetUserImgPosition{
    //hold our user images in an arraylist so we can iterate over them and shuffle them around
    NSMutableArray *images = [[NSMutableArray alloc] init];
    
    [images addObject:userImg1.image];
    [images addObject:userImg2.image];
    [images addObject:userImg3.image];
    [images addObject:userImg4.image];
    [images addObject:userImg5.image];

    if(deleteBtnTag == 1){
        userImg1.image = images[1];
        userImg2.image = images[2];
        userImg3.image = images[3];
        userImg4.image = images[4];
        userImg5.image = [UIImage imageNamed:@"profile pics"];
    }else if(deleteBtnTag == 2){
        userImg2.image = images[2];
        userImg3.image = images[3];
        userImg4.image = images[4];
        userImg5.image = [UIImage imageNamed:@"profile pics"];
    }else if(deleteBtnTag == 3){
        userImg3.image = images[3];
        userImg4.image = images[4];
        userImg5.image = [UIImage imageNamed:@"profile pics"];
    }else if(deleteBtnTag == 4){
        userImg4.image = images[4];
        userImg5.image = [UIImage imageNamed:@"profile pics"];
    }else if(deleteBtnTag == 5){
        userImg5.image = [UIImage imageNamed:@"profile pics"];
    }
    
    //remove all objects from mutable array to mark for cleanup save memory also removing objects sets it's reference count to 0 aka marked for cleanup
    [images removeAllObjects];
}


#pragma mark changePage
#pragma mark - UIScrollViewDelegate

- (IBAction)changePage:(id)sender{
    [scrollView scrollRectToVisible:CGRectMake(SCROLLWIDTH*pageControl.currentPage, scrollView.frame.origin.y, SCROLLWIDTH, scrollView.frame.size.height) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)sender {
    /*if(self.lastContentOffset > scrollView.contentOffset.y || self.lastContentOffset < scrollView.contentOffset.y){
         [imageSelectorScroll setScrollEnabled:NO];
    }
    self.lastContentOffset = scrollView.contentOffset.y;*/
    [self setIndiactorForCurrentPage];
    
}

- (void)setIndiactorForCurrentPage{
    uint page = scrollView.contentOffset.x / SCROLLWIDTH;
    [pageControl setCurrentPage:page];
    NSLog(@"current page is: %u", page);
    
}


//IBAction for edit button presses to alter bio

- (BOOL)prefersStatusBarHidden{
    //    return !!_popupTextView;
    return shouldHideStatusBar;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    if (_popupTextView) {
        return UIStatusBarStyleLightContent;    // white text
    }
    else {
        return UIStatusBarStyleDefault;         // black text
    }
}

/////////////////////////////// Biography button action method starts ///////////////////////////////

- (IBAction)bioBtnPress:(id)sender{
    shouldHideStatusBar = YES;
    [self setNeedsStatusBarAppearanceUpdate];
    YIPopupTextView* popupTextView =
    [[YIPopupTextView alloc] initWithPlaceHolder:@"input here" maxCount:300 buttonStyle:YIPopupTextViewButtonStyleRightDone];
    popupTextView.delegate = self;
    popupTextView.caretShiftGestureEnabled = YES;   // default = NO
    //popupTextView.text = self.textView.text;
    if([[BioTextLbl text] length] > 0){
        popupTextView.text = BioTextLbl.text;
    }
    popupTextView.editable = YES;                  // set editable=NO to show without keyboard
    [popupTextView showInViewController:self]; // recommended, especially for iOS7
    
    //to add custom button just create ui button and place it in popupTextview i.e uibutton doneButton [popupTextView.superview addSubView:doneButton]
    //
    // NOTE:
    // You can add your custom-button after calling -showInView:
    // (it's better to add on either superview or superview.superview)
    // https://github.com/inamiy/YIPopupTextView/issues/3
    //
    // [popupTextView.superview addSubview:customButton];
    
    _popupTextView = popupTextView;
    
}

- (void)popupTextView:(YIPopupTextView *)textView willDismissWithText:(NSString *)text cancelled:(BOOL)cancelled{
    NSLog(@"will dismiss: cancelled=%d",cancelled);
    //self.textView.text = text;
    shouldHideStatusBar = NO;
    [self setNeedsStatusBarAppearanceUpdate];
    NSLog(@"fnished");
    _popupTextView = nil;
    
    BioTextLbl.text = text;
}

/////////////////////////////// Biography button action ends//////////////////////


/////////////////////// Ethnicity and Education button controll picker begins ///////////////////////////////////

- (IBAction)ethnicityBtnPress:(id)sender{
    [ActionSheetStringPicker showPickerWithTitle:@"Select ethnicity"
                                            rows:ethnicity
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           NSLog(@"Picker: %@, Index: %ld, value: %@",
                                                 picker, selectedIndex, selectedValue);
                                           ethnicityLbl.text = selectedValue; // set ethnicity label text to represent chosen ethnicity from picker
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];
    // You can also use self.view if you don't have a sender
}

- (IBAction)educationBtnPress:(id)sender {
    [ActionSheetStringPicker showPickerWithTitle:@"Select highest education"
                                            rows:education
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           NSLog(@"Picker: %@, Index: %ld, value: %@",
                                                 picker, selectedIndex, selectedValue);
                                           educationLbl.text = selectedValue; // set education label text to represent chosen education from picker
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];
}


//set height and weight
- (IBAction)setHeight:(id)sender {
    heightLbl.text = [NSString stringWithFormat:@"%.2f cm", heightSlider.value];
    NSLog(@"height label val is %@",heightLbl.text);
}

- (IBAction)setWeight:(id)sender {
    weightLbl.text = [NSString stringWithFormat:@"%.2f kg", weightSlider.value];
    NSLog(@"weight label val is %@",weightLbl.text);
}

//send the settings to the database to update user settings send it after user performs setting changes i.e at the end of set height IBAction event
- (void)updateSettingsFirebase:(float)height :(float)weight :(NSString*)bio :(NSString *)education{
    
}



//////////////////////// Ethnicity and biography controll picker methods end //////////////////////////////////////////
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



@end
