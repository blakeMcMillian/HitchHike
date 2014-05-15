//
//  Locations.h
//  Hitch
//
//  Created by Blake McMillian on 5/10/14.
//  Copyright (c) 2014 Blake McMillian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject<NSCoding>

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

//NSCoding ----------------------------------
//NSCoding - Caching - getPathToArchive Method
+(NSString *)getPathToArchive;
//NSCoding - Cachine - decodes a location from memeory for loading
-(id)initWithCoder:(NSCoder *)aDecoder;
//NSCoding - Caching - encodes a location into memory for storage
-(void)encodeWithCoder:(NSCoder *)anEncoder;



@end
