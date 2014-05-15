//
//  CustomMainTableViewCells.h
//  Hitch
//
//  Created by Blake McMillian on 5/7/14.
//  Copyright (c) 2014 Blake McMillian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface MainTableViewCells : PFTableViewCell

//Attributes:

//IBOutlets ----------------------------------

//UIImageView - Image for Cell - Image of Each Location
@property (strong, nonatomic) IBOutlet UIImageView *locationImage;

//UILabel - Label for Cell - Name of Each Cell
@property (strong, nonatomic) IBOutlet UILabel *locationInfo;



@end
