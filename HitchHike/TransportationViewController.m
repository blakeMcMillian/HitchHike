//
//  TransportationViewController.m
//  HitchHike
//
//  Created by Blake McMillian on 5/21/14.
//  Copyright (c) 2014 Blake McMillian. All rights reserved.
//

#import "TransportationViewController.h"
#import "HomeTableViewController.h"

@interface TransportationViewController ()

@end

@implementation TransportationViewController

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
    
    self.locationName.text = self.aLocation.locationName;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segue
/* In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"segueToTransportationViewController"])
    {
        // Get reference to the destination view controller
        HomeTableViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        self.locationName.text = vc.self.aTransportationLocation.locationName;
    }
}
*/

- (IBAction)segueToHomeViewController:(id)sender
{
    UINavigationController *vc = self.navigationController;
    
    [vc popViewControllerAnimated:YES];
    
}
@end
