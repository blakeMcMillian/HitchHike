//
//  RootViewController.m
//  HitchHike
//
//  Created by Blake McMillian on 5/24/14.
//  Copyright (c) 2014 Blake McMillian. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

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
    
    //Bringing the Activity View to the front
    [self.view bringSubviewToFront:self.activityIndicatorView];
    
    //Animating the activity indicator
    [self.activityIndicatorInstance startAnimating];
    
    //Performing a query to retrieve the objects from the backgorund
    PFQuery *query = [PFQuery queryWithClassName:@"Locations"];
    [query setLimit:12];
    
    [query findObjectsInBackgroundWithTarget:self selector:@selector(loadingAndStoringInitialLocationsFromParse:withError:)];

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Creating the properties for the tableview
    self.tableViewInstance.delegate = self;
    self.tableViewInstance.maximumZoomScale = 2.0f;
    self.tableViewInstance.contentSize = self.view.bounds.size;
    self.tableViewInstance.alwaysBounceHorizontal = NO;
    self.tableViewInstance.alwaysBounceVertical = YES;
    self.tableViewInstance.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    
    
    // Block for the pull to Refresh - top view
    self.tV = [self.tableViewInstance addPullToRefreshPosition:AAPullToRefreshPositionTop ActionHandler:^(AAPullToRefresh *v){
        
        [self.tableViewInstance setContentOffset:self.tableViewInstance.contentOffset animated:NO];
        
        NSLog(@"fire from top");
        [v performSelector:@selector(stopIndicatorAnimation) withObject:nil afterDelay:.8f];
        
        
        
    }];
    self.tV.imageIcon = [UIImage imageNamed:@"launchpad"];
    self.tV.borderColor = [UIColor whiteColor];
    self.tV.threshold = 60;
    self.tV.borderWidth = 1.0f;
    self.tV.showPullToRefresh = YES; // also remove KVO observer if set to NO.
    
    
    // Block for pull to refresh - bottom view
    self.bV = [self.tableViewInstance addPullToRefreshPosition:AAPullToRefreshPositionBottom ActionHandler:^(AAPullToRefresh *v){
        
        [self.tableViewInstance setContentOffset:self.tableViewInstance.contentOffset animated:NO];
        
        NSLog(@"fire from bottom");
        [v performSelector:@selector(stopIndicatorAnimation) withObject:nil afterDelay:1.0f];
        
    }];
    self.bV.imageIcon = [UIImage imageNamed:@"centerIcon"];
    self.bV.borderColor = [UIColor whiteColor];
    self.bV.threshold = 60;
    self.bV.borderWidth = 1.0f;
    self.bV.showPullToRefresh = YES; // also remove KVO observer if set to NO.
    
    
    //Initilziing the Notification for Storing Models
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(enteringBackground)
     name:UIApplicationDidEnterBackgroundNotification
     object:nil];
    
    //Initilziing the Notification for Loading Models
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(enteringForeground)
     name:UIApplicationWillEnterForegroundNotification
     object:nil];
    
    //Initilizing the Location Cache
    
    //if the cache is empty create a new array
    if (self.aLocationCache == nil)
    {
        self.tempLocationCache = [[NSArray alloc] init];
        self.aLocationCache = [[LocationCache alloc]init];
    }
    else // if the cache is not empty, then use the elements that are in the cache currently
        self.tempLocationCache = [[NSArray alloc]
                                  initWithArray:self.aLocationCache.cachedLocations];
    
}//end - viewDidLoad -  method

/*- (UIView *)viewForZoomingInScrollView:(UITableView *)scrollView
{
    return self.thresholdView;
}*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}//end - didReceiveMemoryWarning -  method

#pragma mark - App Delegate Methods
-(void) enteringBackground
{
    [LocationCache saveLocations:self.aLocationCache];
    
}//end - enteringBackground -  method

-(void) enteringForeground
{
    self.aLocationCache = [LocationCache loadLocations];
    
}//end - enteringForeground -  method


#pragma mark - TableView Protocol Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 {
     if(self.locations.count < 6)
     {
         return 3;
     }
     else
         return self.locations.count;
     
     
 
 }//end - numberOfRowsInSection -  method
 
 
 - (RootTableViewCells *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    //Specifing Cell Identifer
    static NSString *cellIdentifier = @"customCell";
    
    RootTableViewCells *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //Initalizing Cells
    if(cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"RootTableViewCells" owner:self options:nil];
        // Grab a reference to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }//end - if statement
    
    // Configure the cell...
    
    //Creating a temporary dictionary to retreive the image for each location
    self.aLocation = [self.aLocationCache.cachedLocations objectAtIndex:indexPath.row];
    //Setting the cell attributes
    
    //If the cell image is not ready, then upload a temporary image
    if(cell.locationImage.image == nil)
    {
        cell.locationImage.image = [UIImage imageNamed:@"placeHolder.jpg"];
        cell.locationInfo.text = @"Loading...";
        cell.aLocation = self.aLocation;
        
        //updating the cell's UI
        [cell setNeedsLayout];
        [cell setNeedsDisplay];
        
    }
    else //If cell image is sucesfully loaded from the database, then the correct image is set
    {
        cell.locationImage.image = self.aLocation.locationImage;
        cell.locationInfo.text = self.aLocation.locationName;
        cell.aLocation = self.aLocation;
        
        //updating the cell's UI
        [cell setNeedsLayout];
        [cell setNeedsDisplay];
    }
    

    
    
 //Returning the cells
 return cell;
 }//end - cellForRowAtIndexPath -  method
 

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Creating a cell object at the index that was selected
    RootTableViewCells *cell = (RootTableViewCells *)[tableView cellForRowAtIndexPath:indexPath];
    
    //Performing some type of opertion...
    
    //Grabbing the cells infromation
    self.aLocation = [self.aLocationCache.cachedLocations objectAtIndex:indexPath.row];
    
    //Storing the location that was selected by ther user
    self.aTransportationLocation = cell.aLocation;
    
    [self performSegueWithIdentifier:@"segueToTransportationView" sender:self];
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(RootTableViewCells *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
        //2. Define the initial state (Before the animation)
        cell.shadowLayer.alpha = 1;
        cell.layer.shadowOffset = CGSizeMake(10, 10);
    
    
        //3. Define the final state (After the animation) and commit the animation
        [UIView beginAnimations:@"animateIn" context:NULL];
        [UIView setAnimationDuration:1.2];
        cell.shadowLayer.alpha = 0;
        cell.layer.shadowOffset = CGSizeMake(0, 0);

    
    
}//end - method - willDisplayCell

#pragma mark - TableView Manipulation Methods
-(void)loadingAndStoringInitialLocationsFromParse
{
        PFQuery *locationsFromParse = [PFQuery queryWithClassName:@"Locations"];
    
        //initializing the locations from the data retrieved parse
        self.locations = [locationsFromParse findObjects];

        //Iterating over the array of PFObjects retrieved from parse
        for (PFObject *parseObject in self.locations)
        {
            //initializing a new location object
            self.aLocation = [Location new];
            
            //Stroing the Attributes from parse into temporary variables...
            
            //Storing the name:
            
            self.aLocation.locationName = [parseObject objectForKey:@"locationName"];
            
            
            //Storing the image:
            
            //Parsing the PFFIle into an image for the "location image attribute
            PFFile *tempImageFromFile = [parseObject objectForKey:@"locationImage"];//storing as a file
            NSData *tempImageFromData = [[NSData alloc]initWithData:[tempImageFromFile getData]];//parsing into data
            self.aLocation.locationImage = [UIImage imageWithData:tempImageFromData]; // storing as a UIImage
            
            //Stroing the objectID:
            
            self.aLocation.objectID = [parseObject objectForKey:@"objectId"];
            
            //caching the locations from parse
            [self appendToLocationCache:self.aLocation];
            
        }//end - for loop
    

        //hiding the activity indicator
        [self.activityIndicatorView setHidden:YES];
        
        //Sending the activity indicator view to the back of the view hierarchy
        [self.view sendSubviewToBack:self.activityIndicatorView];
        
        //stopping the activity indicatior animation
        [self.activityIndicatorInstance stopAnimating];
    
    
    
}


-(void)loadingAndStoringInitialLocationsFromParse:(NSArray *)locationsFromParse
                                        withError:(NSError *)error
{
    //initializing the locations from the data retrieved parse
    self.locations = [[NSArray alloc]initWithArray:locationsFromParse];
    
    if(!error)
    {
        //Iterating over the array of PFObjects retrieved from parse
        for (PFObject *parseObject in self.locations)
        {
            //initializing a new location object
            self.aLocation = [Location new];
            
            //Stroing the Attributes from parse into temporary variables...
            
            //Storing the name:
            
            self.aLocation.locationName = [parseObject objectForKey:@"locationName"];
            
            
            //Storing the image:
            
            //Parsing the PFFIle into an image for the "location image attribute
            PFFile *tempImageFromFile = [parseObject objectForKey:@"locationImage"];//storing as a file
            NSData *tempImageFromData = [[NSData alloc]initWithData:[tempImageFromFile getData]];//parsing into data
            self.aLocation.locationImage = [UIImage imageWithData:tempImageFromData]; // storing as a UIImage
            
            //Stroing the objectID:
            
            self.aLocation.objectID = [parseObject objectForKey:@"objectId"];
            
            //caching the locations from parse
            [self appendToLocationCache:self.aLocation];
        
    }//end - for loop
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            //Pasuing activity while the refresh operation is taking place
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                
                //manually triggering pull to refresh
                [self.tV manuallyTriggered];
                
                // Now, this code is running in the main thread.
                // Update your UI...
                //hiding the activity indicator
                [self.activityIndicatorView setHidden:YES];
                
                //Sending the activity indicator view to the back of the view hierarchy
                // [self.view sendSubviewToBack:self.activityIndicatorView];
                
                //stopping the activity indicatior animation
                [self.activityIndicatorInstance stopAnimating];
                
                [self.tableViewInstance reloadData];
                
                self.activityIndicatorView.backgroundColor = [UIColor blackColor];
                
            });
            
            
        });
   
        
    }//end - if statement
    
  
    
   
}//end - populateMainTableView -  method

#pragma mark Caching

-(void)appendToLocationCache:(Location*)aLocationObject
{
    //Creating temporary variables to append to the locations cache
    NSArray* tempArray = [[NSArray alloc] initWithObjects:self.aLocation, nil];
    
    //adding the newly loaded locations into the locations cache
    NSArray *tempArray2 = [self.tempLocationCache arrayByAddingObjectsFromArray:tempArray];
    
    //storing the newly added elements into the temporary Location cache
    self.tempLocationCache = tempArray2;
    self.aLocationCache.cachedLocations = self.tempLocationCache;
    
    //Caching the array of attributes from Parse
    [LocationCache saveLocations:self.aLocationCache];
    
}
-(void)appendToLocationWithoutCache:(Location*)aLocationObject;
{
    
    //Creating temporary variables to append to the locations cache
    NSArray* tempArray = [[NSArray alloc] initWithObjects:self.aLocation, nil];
    
    //adding the newly loaded locations into the locations cache
    NSArray *tempArray2 = [self.tempLocationCache arrayByAddingObjectsFromArray:tempArray];
    
    //storing the newly added elements into the temporary Location cache
    self.tempLocationCache = tempArray2;
    
}

-(void)cacheLocationAttributesFromParse
{
    //storing the location cache into the cahing object
    if (self.aLocationCache == nil)
    {
        self.aLocationCache = [[LocationCache alloc] initWithArray:self.tempLocationCache];
    }
    else
    {
        self.aLocationCache.cachedLocations =  [self.aLocationCache.cachedLocations
                                                arrayByAddingObjectsFromArray:self.tempLocationCache];
        //saving the location object to file
        [LocationCache saveLocations:self.aLocationCache];
        
    }
    
    
}//end - cacheLocationAttributesFromParse -  method



#pragma mark - Segue Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    
}



@end
