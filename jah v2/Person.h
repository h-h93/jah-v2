//
//  Person.h
//  jah v2
//
//  Created by Hanif Hussain on 23/11/2016.
//  Copyright © 2016 Hanif Hussain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSUInteger age;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) NSUInteger numberOfImages;
@property (nonatomic, copy) NSString *Bio;
@property (nonatomic, strong) NSMutableArray *interests;

- (instancetype)initWithName:(NSString *) name
                         age:(NSUInteger)age
                       image:(UIImage *)image
                    numberOfImages:(NSUInteger)numberOfImages
                         Bio:(NSString *)Bio
                   interests:(NSMutableArray *)interests;





@end
