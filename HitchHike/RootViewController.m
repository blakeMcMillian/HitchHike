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
    
    
    [self performSelector:@selector(findObjectInBackground)
               withObject:nil
               afterDelay:2.0];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //hiding the greyline in the tableviewcells
    self.tableViewInstance.separatorColor = [UIColor clearColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
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
        [v performSelector:@selector(stopIndicatorAnimation) withObject:nil afterDelay:.1f];
        
    }];
    self.tV.imageIcon = [UIImage imageNamed:@"launchpad"];
    self.tV.borderColor = [UIColor whiteColor];
    self.tV.threshold = 60;
    self.tV.borderWidth = 1.0f;
    self.tV.showPullToRefresh = YES; // also remove KVO observer if set to NO.
    
    //implementing a footer in the tableview
    self.footerActivityIndicatorView = [[TYMActivityIndicatorView alloc] initWithActivityIndicatorStyle:TYMActivityIndicatorViewStyleNormal];
    UIImage *tempImage = [UIImage imageNamed:@"launchpad"];
    [self.footerActivityIndicatorView setIndicatorImage:tempImage];
    
    self.footerActivityIndicatorView.frame=CGRectMake((self.footerActivityIndicatorView.bounds.size.width - self.footerActivityIndicatorView.bounds.size.width)/2, -self.footerActivityIndicatorView.bounds.size.height, self.footerActivityIndicatorView.bounds.size.width, self.footerActivityIndicatorView.bounds.size.height);
    self.tableViewInstance.tableFooterView = self.footerActivityIndicatorView;
    
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
    if(!self.aLocation)
    {
        //Animating the cell's Image ------------------------------
        //1. Define the initial state (Before the animation)
        cell.shadowLayer.alpha = 1;
        cell.locationImage.image = [UIImage imageNamed:@"placeHolder.jpg"];
        cell.locationInfo.text = @"";
        cell.aLocation = self.aLocation;
        cell.layer.shadowOffset = CGSizeMake(10, 10);
        
        //2. Define the final state (After the animation) and commit the animation
        [UIView beginAnimations:@"animateIn" context:NULL];
        [UIView setAnimationDuration:2.5];
        cell.shadowLayer.alpha = 0;
        cell.layer.shadowOffset = CGSizeMake(0, 0);
        
        //Animating the cell's text ------------------------------
        //1. Initial state before the animation
        cell.locationInfo.alpha = 0;
        
        //final state after the animation
        [UIView beginAnimations:@"animateCellText" context:NULL];
        [UIView setAnimationDuration:6];
        cell.locationInfo.alpha = 1;
        
        //updating the cell's UI
        [cell setNeedsLayout];
        [cell setNeedsDisplay];
        
    }
    else //If cell image is sucesfully loaded from the database, then the correct image is set
    {
        //Animating the cell's Image ------------------------------
        //1. Define the initial state (Before the animation)
        cell.shadowLayer.alpha = 1;
        cell.layer.shadowOffset = CGSizeMake(10, 10);
        
        
        
        //2. Define the final state (After the animation) and commit the animation
        [UIView beginAnimations:@"animateCellImage" context:NULL];
        [UIView setAnimationDuration:2.5];
        cell.shadowLayer.alpha = 0;
        cell.locationImage.image = self.aLocation.locationImage;
        cell.locationInfo.text = self.aLocation.locationName;
        
        cell.aLocation = self.aLocation;
        cell.layer.shadowOffset = CGSizeMake(0, 0);
        
        
        //Animating the cell's Text ------------------------------
        
        //1. Inital state before the animation
        cell.locationInfo.alpha = 0;
        
        //2.Final state after the animation
        [UIView beginAnimations:@"animateCellText" context:NULL];
        [UIView setAnimationDuration:6];
        cell.locationInfo.alpha = 1;
        
        //updating the cell's UI
        [cell setNeedsLayout];
        [cell setNeedsDisplay];
        
        
        
        
    }
    
    //setting the cell properties so that it extends outside of the bounds
    [cell.contentView.superview setClipsToBounds:NO];
    [cell.contentView setClipsToBounds:NO];
    [cell setClipsToBounds:NO];
    
    //removing the selection style so that the content remains consistent
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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
    
        //clip to bounds hacks
        //ios 7 cell background fix
        [cell.contentView.superview setClipsToBounds:NO];
        [cell.contentView setClipsToBounds:NO];
        [cell setClipsToBounds:NO];
        [cell setBackgroundColor:[UIColor clearColor]];
        //ios 7 content clipping fix
        [cell.contentView.superview setClipsToBounds:NO];
        [cell.contentView setClipsToBounds:NO];
        [cell setClipsToBounds:NO];

    
    
}//end - method - willDisplayCell

#pragma mark - TableView Manipulation Methods
//displaying the activity indicator
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
    CGPoint offset = aScrollView.contentOffset;
    CGRect bounds = aScrollView.bounds;
    CGSize size = aScrollView.contentSize;
    UIEdgeInsets inset = aScrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    // NSLog(@"offset: %f", offset.y);
    // NSLog(@"content.height: %f", size.height);
    // NSLog(@"bounds.height: %f", bounds.size.height);
    // NSLog(@"inset.top: %f", inset.top);
    // NSLog(@"inset.bottom: %f", inset.bottom);
    // NSLog(@"pos: %f of %f", y, h);
    
    float reload_distance = 10;
    if(y > h + reload_distance)
    {
        [self.footerActivityIndicatorView startAnimating];
        
        //launch a method to fetch more data from the table
        
        //disable the activity indicator in that method
    }
}
-(void) findObjectInBackground
{
    //removing the loading screen from the view
    dispatch_async(dispatch_get_main_queue(), ^{
        
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
    
    //Performing a query to retrieve the objects from the backgorund
    PFQuery *query = [PFQuery queryWithClassName:@"Locations"];
    [query setLimit:12];
    
    [query findObjectsInBackgroundWithTarget:self selector:@selector(loadingAndStoringInitialLocationsFromParse:withError:)];
    
    
    
}//end - method - findObjectsInBackground

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
            
            //reloading the table data
            [self.tableViewInstance reloadData];
        
    }//end - for loop
        
       
        
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
