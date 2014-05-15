//
//  Locations.m
//  Hitch
//
//  Created by Blake McMillian on 5/14/14.
//  Copyright (c) 2014 Blake McMillian. All rights reserved.
//

#import "LocationCache.h"

@implementation LocationCache

#pragma initilization
-(id)init
{
    self = [super init];
    return self;
    
}//end - init - method

-(id)initWithArray:(NSArray *) locationsArray
{
    self = [super init];
    
    if(self)
    {
        self.cachedLocations = locationsArray;
        
        //saving the location object following instantination
        //[LocationCache saveLocations:self];
        
    }//end - if statement
    
    return self;
}//end initWithArray - method

#pragma mark NSCoding
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
    //Retrieving the objects
    self.cachedLocations = [aDecoder decodeObjectForKey:@"locations"];
        
    }//end - if statement
    
    //returning the object
    return self;
    
}//end - initWithCoder -  method

-(void)encodeWithCoder:(NSCoder *)anEncoder;
{
    //Storing the objects
    
    [anEncoder encodeObject:self.cachedLocations forKey:@"locations"];
    
}//end - encodeWithCoder -  method

+(NSString *)getPathToArchive
{
    //finding and retrieving the path of the object that is being stored via NSCoding
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    NSString *archivePath = [documentDirectory stringByAppendingPathComponent:@"locationCache.model"];
    
    //returning the object
    return archivePath;
    
}//end - getPathToArchive - method

+(void)saveLocations:(LocationCache *)locations
{
    [NSKeyedArchiver archiveRootObject:locations toFile:[LocationCache getPathToArchive]];
    
}//end - saveaLocation - method

+(LocationCache *)loadLocations
{
    //loading a loading model
    
    LocationCache *temp = [NSKeyedUnarchiver unarchiveObjectWithFile:[LocationCache getPathToArchive]];
    
    return temp;
    
}//end - getaLocation - method
@end
