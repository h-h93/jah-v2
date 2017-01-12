//
//  profileTabViewViewController.m
//  
//
//  Created by Hanif Hussain on 05/12/2016.
//
//

#import "profileTabViewViewController.h"

@interface profileTabViewViewController ()

@end

@implementation profileTabViewViewController

#define SCROLLWIDTH 414
#define MAS_SHORTHAND

- (void)viewDidLoad {
    
    // Do any additional setup after loading the view.]
    Defaultprofilepic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"profile pics"]];
    profilePicHeader.layer.cornerRadius = profilePicHeader.frame.size.width/2;
    profilePicHeader.clipsToBounds = YES;
    
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

    //[scrollView addSubview:settingScrollPage1];
   // [settingScrollPage1 addSubview:settingScrollPage2];
    //[settingScrollPage1 addSubview:settingScrollPage3];
   
    for (int i =0; i<3; i++)
    {
        UIScrollView *imageView = [[UIScrollView alloc]initWithFrame:CGRectMake(SCROLLWIDTH*i, 0, scrollView.frame.size.width, scrollView.frame.size.height)];

        if (i==0)
        {
            imageView = settingScrollPage1;
            
        }
        else if (i==1)
        {
            
            imageView = settingScrollPage2;
            
        }
        else
        {
            imageView.backgroundColor = [UIColor yellowColor];
        }
        [scrollView addSubview:imageView];
        
    }
    
    
    
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //userImg1.image = [UIImage imageWithContentsOfFile:self.assets[0]];
   // NSLog(@"assets 0 is: %@",self.assets[0]);
    [imageSelectorScroll setContentSize:CGSizeMake(770, imageSelectorScroll.frame.size.height)];
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


   // UIImageView *temp = self.checkAndSetPics;
    /*
    if(tag == 1){
    userImg1.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }else if(tag == 2){
        userImg2.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }else if(tag == 3){
        userImg3.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }else if(tag == 4){
        userImg4.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }else if(tag == 5){
        userImg5.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    */
    //[self checkAndSetPics:tag].image = [info objectForKey:UIImagePickerControllerOriginalImage];
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
            userImg1.image = userImg2.image;
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
/*
//scrolling ends
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // Test the offset and calculate the current page after scrolling ends

    //find the page number you are on
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
     NSLog(@"Scrolling - You are now on page %i",page);
}

//dragging ends, please switch off paging to listen for this event
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *) targetContentOffset NS_AVAILABLE_IOS(5_0){
    //find the page number you are on
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    NSLog(@"Dragging - You are now on page %i",page);

}
*/

#pragma mark changePage

-(IBAction)changePage:(id)sender
{
     [scrollView scrollRectToVisible:CGRectMake(SCROLLWIDTH*pageControl.currentPage, scrollView.frame.origin.y, SCROLLWIDTH, scrollView.frame.size.height) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)sender {
    
    [self setIndiactorForCurrentPage];
    
}

-(void)setIndiactorForCurrentPage
{
    uint page = scrollView.contentOffset.x / SCROLLWIDTH;
    [pageControl setCurrentPage:page];
    NSLog(@"current page is: %u", page);
    
}


/////////////// image picker methods end //////////////////////////////////
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
