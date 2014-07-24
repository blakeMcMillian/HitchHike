//
//  RootViewQueryManager.h
//  HitchHike
//
//  Created by other  on 7/18/14.
//  Copyright (c) 2014 Blake McMillian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface RootViewQueryManager : NSObject

//Attributes

//Parse Objects
@property (strong, nonatomic) PFQuery *query; //parse Query
@property (strong, nonatomic) PFObject *parseInstance; // parse Instance



@end
