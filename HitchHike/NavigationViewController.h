//
//  HomeViewController.h
//  HitchHike
//
//  Created by Blake McMillian on 5/17/14.
//  Copyright (c) 2014 Blake McMillian. All rights reserved.
//

@protocol NavigationViewDelegate <NSObject>

- (void) showBackButton;

@end

#import <UIKit/UIKit.h>
#import "HomeTableViewController.h"
#import "TransportationViewController.h"

@interface NavigationViewController : UIViewController<HomeTableViewDelegate>
{
    //delegate from the homeTableViewCotnroller
    id<HomeTableViewDelegate>_delegate;
}

//Protocol:

//Portocol - Delegate - Method that communitcates with the HomeViewController
@property (nonatomic, weak) id <NavigationViewDelegate> delegate;

//View:

//IBACtions ----------------------------------

//UIButton - Segue - Performing a segue back to the homeViewController
- (IBAction)segueToPreviousViewController:(id)sender;

//IBOutlet ------------------------------------
//UIButton - Back Button - Visual representation of the back button
@property (strong, nonatomic) IBOutlet UIButton *backButton;

//Methods:

//Protocol ---------------------------------------

//Protocol - Delegate method - method that shows the home button when the view loads
-(void)showButton;

@end

