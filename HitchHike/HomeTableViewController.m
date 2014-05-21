//
//  HomeViewController.m
//  Hitch
//
//  Created by Blake McMillian on 5/10/14.
//  Copyright (c) 2014 Blake McMillian. All rights reserved.
//

#import "HomeTableViewController.h"
#import "Location.h"
#import "TransportationViewController.h"

@interface HomeTableViewController ()

@end

@implementation HomeTableViewController

- (id)initWithCoder:(NSCoder *)aCoder {
    self = [super initWithCoder:aCoder];
    if (self) {
        // Customize the table
        
        // The className to query on
        self.parseClassName = @"Locations";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"pending";
        
        // Uncomment the following line to specify the key of a PFFile on the PFObject to display in the imageView of the default cell style
        // self.imageKey = @"image";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 6;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}//end - initWithNibName -  method

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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

    //Populating the TableView with the elements from parse
    [self loadObjects];
    
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
    
    //Caching the elements sent from Parse
    [self performSelector:@selector(loadingAndStoringLocationsFromParse) ];
  
    
    
}//end - viewDidLoad -  method

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

/*-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
 
}//end - numberOfRowsInSection -  method


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   //Specifing Cell Identifer
   static NSString *cellIdentifier = @"mainTableViewCells";
   MainTableViewCells *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //Initalizing Cells
    if(cell == nil)
    {
        cell = [[MainTableViewCells alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }//end - if statement
    
    
  // Configure the cell...
  
  //Creating a temporary dictionary to retreive the image for each location
   PFObject *locationFromParse = [self.locations objectAtIndex:indexPath.row];
    
  //Getting the location image from PFFIle
    PFFile *imageFromFile = [locationFromParse objectForKey:@"locationImage"];
    NSData *imageFromData = [[NSData alloc]initWithData:[imageFromFile getData]];
    
  //Getting the Location Coordinates from Parse
    NSString *locationName = [locationFromParse objectForKey:@"locationName"];
    
   //Setting the cell attributes
    cell.locationImage.image = [UIImage imageWithData:imageFromData];
    cell.locationInfo.text = locationName;
    
    //Returning the cells
    return cell;
}//end - cellForRowAtIndexPath -  method
 
 */

// Override to customize the look of a cell representing an object. The default is to display
// a UITableViewCellStyleDefault style cell with the label being the first key in the object.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    //Specifing Cell Identifer
    static NSString *cellIdentifier = @"mainTableViewCells";
    
    MainTableViewCells *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //Initalizing Cells
    if(cell == nil)
    {
        cell = [[MainTableViewCells alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }//end - if statement
    
    
    
    // Configure the cell...
    
    //Creating a temporary dictionary to retreive the image for each location
        self.aLocation = [self.aLocationCache.cachedLocations objectAtIndex:indexPath.row];
    //Setting the cell attributes
    cell.locationImage.image = self.aLocation.locationImage;
    cell.locationInfo.text = self.aLocation.locationName;
    cell.aLocation = self.aLocation;
    
    return cell;
    
}//end - cellForRowAtIndexPath -  method

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Creating a cell object at the index that was selected
    MainTableViewCells *cell = (MainTableViewCells *)[tableView cellForRowAtIndexPath:indexPath];
    
    //Performing some type of opertion...
    
     //Grabbing the cells infromation
    self.aLocation = [self.aLocationCache.cachedLocations objectAtIndex:indexPath.row];
    
    //Storing the location that was selected by ther user
    self.aTransportationLocation = cell.aLocation;
    
    //Seguing into the transportation view controller
    [self performSegueWithIdentifier:@"segueToTransportationViewController" sender:self];
    
}
#pragma mark - TableView Manipulation Methods

-(void)loadingAndStoringLocationsFromParse
{
    //Creating Parse Object from the Locations Class
    PFQuery *locationsFromParse = [PFQuery queryWithClassName:@"Locations"];
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
        
        [self appendToLocationCache:self.aLocation];
        
    }//end - for loop
    
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
    if ([[segue identifier] isEqualToString:@"segueToTransportationViewController"])
    {
        // Get reference to the destination view controller
        TransportationViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        
        vc.aLocation = self.aTransportationLocation;
    }
    
}


@end
