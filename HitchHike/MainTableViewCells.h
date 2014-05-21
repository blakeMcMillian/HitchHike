//
//  CustomMainTableViewCells.h
//  Hitch
//
//  Created by Blake McMillian on 5/7/14.
//  Copyright (c) 2014 Blake McMillian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Location.h"

@interface MainTableViewCells : PFTableViewCell

//Attributes:

//Locations ---------------------------------------

//Locations - Array of PFOject's - Contains Locations from Parse
@property(strong, nonatomic) Location *aLocation;


//View:

//IBOutlets ----------------------------------

//UIImageView - Image for Cell - Image of Each Location
@property (strong, nonatomic) IBOutlet UIImageView *locationImage;

//UILabel - Label for Cell - Name of Each Cell
@property (strong, nonatomic) IBOutlet UILabel *locationInfo;






@end
