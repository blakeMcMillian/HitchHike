//
//  HomeViewController.m
//  HitchHike
//
//  Created by Blake McMillian on 5/17/14.
//  Copyright (c) 2014 Blake McMillian. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
{
    HomeTableViewController *hVc;
}

@end

@implementation RootViewController


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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"segueToHomeTableView"])
    {
        // Get reference to the destination view controller
        hVc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
       // self.hVc.delegate = self;
    }
    
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"segueToNavigationView"])
    {
        // Get reference to the destination view controller
        NavigationViewController *nVc = [segue destinationViewController];
    
        // Setting the delegate of for the two container view controllers
         hVc.delegate = nVc.self;
    }

   
    
}


#pragma mark Delegate methods
- (void) hideBackButton
{
    [self performSelectorOnMainThread:@selector(hideBackButtonOnMainThread)
                           withObject:nil
                        waitUntilDone:YES];
        // perform on main
    
}

-(void) hideBackButtonOnMainThread
{
    
    
    
}

/*-(void)showButton
{
    //checks the selector
    if([self.delegate respondsToSelector:@selector(showBackButton)])
    {
        //calls the delegate method to hide the backbutton
        [self.delegate showBackButton];
    }
}//end - hideButton - method*/




@end
