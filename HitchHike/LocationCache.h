//
//  Locations.h
//  Hitch
//
//  Created by Blake McMillian on 5/14/14.
//  Copyright (c) 2014 Blake McMillian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationCache : NSObject<NSCoding>

//Attributes:

//Array ----------------------------------

//Locations - Array of Location Object's - Contains Locations from Parse
@property (strong,nonatomic) NSArray *cachedLocations;


//Methods:

//Initilizers ----------------------------------

//Initilizers - Init's Location's cache with an array - contains arrays that it was initlized with
-(id)initWithArray:(NSArray *) locationsArray;

//Initilizers - Default initilizer - creates a new object
-(id)init;


//NSCoding ----------------------------------
//NSCoding - Caching - getPathToArchive Method
+(NSString *)getPathToArchive;
//NSCoding - Cachine - decodes a location from memeory for loading
-(id)initWithCoder:(NSCoder *)aDecoder;
//NSCoding - Caching - encodes a location into memory for storage
-(void)encodeWithCoder:(NSCoder *)anEncoder;
//NSCoding - Caching - Saves a location into memory
+(void)saveLocations:(LocationCache *)aLocation;
//NSCoding -Caching - Loads a location from memory
+(LocationCache *)loadLocations;



@end
