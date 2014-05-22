//
//  TransportationViewController.h
//  HitchHike
//
//  Created by Blake McMillian on 5/21/14.
//  Copyright (c) 2014 Blake McMillian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import "NavigationViewController.h"

@interface TransportationViewController : UIViewController<NavigationViewDelegate>
{
    id<NavigationViewDelegate>_delegate;
}


@property (nonatomic, weak) id <NavigationViewDelegate> delegate;



//Attributes:

//Locations ---------------------------------------

//Locations - Temp Location Object - Used for manupulating location instances within the view
@property(strong, nonatomic) Location *aLocation;




//View:

//IBACtions ----------------------------------




//IBOutlets ----------------------------------

//UILabel - Label for Location - Name of Each Location
@property (strong, nonatomic) IBOutlet UILabel *locationName;



//Methods:

//Methods:

//Protocol ---------------------------------------

//Protocol - Delegate method - method that hides the home button when the view loads
-(void) showBackButton;

//Segue's ---------------------------------------

//Segue - View Controller Transitioning - accepting the attributes passed from the HometableViewController
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;





@end
