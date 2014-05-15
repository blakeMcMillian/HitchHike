//
//  Locations.m
//  Hitch
//
//  Created by Blake McMillian on 5/10/14.
//  Copyright (c) 2014 Blake McMillian. All rights reserved.
//

#import "Location.h"

@implementation Location

#pragma initilization
-(id)init
{
    self = [super init];
    return self;
    
}//end - init - method

#pragma mark NSCoding
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        //Retrieving the objects
        self.locationName = [aDecoder decodeObjectForKey:@"locationName"];
        self.locationImage = [aDecoder decodeObjectForKey:@"locationName"];
        
        
    }//end - if statement
    
    
    //returning the object
    return self;
    
}//end - initWithCoder -  method

-(void)encodeWithCoder:(NSCoder *)anEncoder;
{
    //Storing the objects
    [anEncoder encodeObject:self.locationName forKey:@"locationName"];
    [anEncoder encodeObject:self.locationImage forKey:@"locationImage"];
    
    
}//end - encodeWithCoder -  method

+(NSString *)getPathToArchive
{
    //finding and retrieving the path of the object that is being stored via NSCoding
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [path objectAtIndex:0];
    
    NSString *archivePath = [documentDirectory stringByAppendingPathComponent:@"alocation.model"];
    
    //returning the object
    return archivePath;
    
}//end - getPathToArchive - method

@end
