//
//  TransportationViewController.h
//  HitchHike
//
//  Created by Blake McMillian on 5/21/14.
//  Copyright (c) 2014 Blake McMillian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"

@interface TransportationViewController : UIViewController


//Attributes:

//Locations ---------------------------------------

//Locations - Temp Location Object - Used for manupulating location instances within the view
@property(strong, nonatomic) Location *aLocation;





//View:

//IBACtions ----------------------------------

//UIButton - Segue - Performing a segue back to the homeViewController
- (IBAction)segueToHomeViewController:(id)sender;



//IBOutlets ----------------------------------

//UILabel - Label for Location - Name of Each Location
@property (strong, nonatomic) IBOutlet UILabel *locationName;


//Methods:

//Segue's ---------------------------------------

//Segue - View Controller Transitioning - accepting the attributes passed from the HometableViewController
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;





@end
