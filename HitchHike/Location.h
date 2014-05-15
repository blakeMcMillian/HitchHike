//
//  Locations.h
//  Hitch
//
//  Created by Blake McMillian on 5/10/14.
//  Copyright (c) 2014 Blake McMillian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject

//Attributes:

//NSString ---------------------------------------

//NSString - NSString Object - Location's Name
@property(strong, nonatomic) NSString *locationName;

//PFObject ---------------------------------------

//PFObject - Array of PFObject's Object - cache of locations from parse
@property(strong,nonatomic) NSArray *cachedParseLocation;

//UIIamge ---------------------------------------

//UIImage - UIImage Object - Location's image
@property(strong, nonatomic) UIImage *locationImage;




//Methods:



@end
