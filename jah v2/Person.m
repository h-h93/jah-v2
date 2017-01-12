//
//  Person.m
//  jah v2
//
//  Created by Hanif Hussain on 23/11/2016.
//  Copyright © 2016 Hanif Hussain. All rights reserved.
//

#import "Person.h"

@implementation Person

- (instancetype)initWithName:(NSString *)name age:(NSUInteger)age image:(UIImage *)image numberOfImages:(NSUInteger)numberOfImages Bio:(NSString *)Bio interests:(NSMutableArray *)interests{
    self = [super init];
    if(self){
        _name = name;
        _image = image;
        _age = age;
        _interests = interests;
        _Bio = Bio;
        _numberOfImages = numberOfImages;
        
    }
    
    return self;

}



@end
