//
//  HomeViewController.m
//  HitchHike
//
//  Created by Blake McMillian on 5/17/14.
//  Copyright (c) 2014 Blake McMillian. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

//Synthesizing Attributes:
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Creating an instance of the homeTableViewController in order to pass the delegate reference
    HomeTableViewController *vc = [[HomeTableViewController alloc]init];
    vc.delegate = self;
    [vc hideButton]; //calling the method within the homeTableViewController
    
    //Calling delegate method to show the button when the transportation view is launched
    [self showButton];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation


- (IBAction)segueToPreviousViewController:(id)sender
{
    //Creating an instance of the current view controller and seguing back to
    //the previous instance
    UINavigationController *vc = self.navigationController;
    
    [vc popViewControllerAnimated:YES];
}

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   
    
}
*/

#pragma mark Delegate methods
- (void) hideBackButton
{
    [self.backButton setHidden:YES];
    [self.backButton setEnabled:NO];
}

-(void)showButton
{
    //checks the selector
    if([self.delegate respondsToSelector:@selector(showBackButton)])
    {
        //calls the delegate method to hide the backbutton
        [self.delegate showBackButton];
    }
}//end - hideButton - method




@end
