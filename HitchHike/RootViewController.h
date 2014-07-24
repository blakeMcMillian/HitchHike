//
//  RootViewController.h
//  HitchHike
//
//  Created by Blake McMillian on 5/24/14.
//  Copyright (c) 2014 Blake McMillian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Location.h"
#import "RootTableViewCells.h"
#import "LocationCache.h"
#import "AAPullToRefresh.h"
#import "TYMActivityIndicatorView.h"
#import "RootNavigationBar.h"
#import "ILTranslucentView.h"

@interface RootViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>




//Attributes:
@property (strong, nonatomic) IBOutlet TYMActivityIndicatorView *footerActivityIndicatorView;
//View:

//UIViews ----------------------------------
@property (weak, nonatomic) IBOutlet ILTranslucentView *navigationBarInstance;

//UIView - Activity View - View for Activity Indicator
@property (strong, nonatomic) IBOutlet UIView *activityIndicatorView;

//UITableView - LocationTableView - View that will display the locations from parse
@property (weak, nonatomic) IBOutlet UITableView *tableViewInstance;

//AAPullToRefresh ----------------------------------

//AAPullToRefresh - Refresher Instance for the top view - Pull To Refresh Object
@property (strong, nonatomic) AAPullToRefresh *tV;

//UIActivityIndicator - Refresher Instance for the bottom view - Activity Indicator Object
@property (strong, nonatomic) AAPullToRefresh *bV;

//UIActivityIndicator ----------------------------------

//UIActivityIndicator - Activity Indicator - Activity Indicator Object
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorInstance;

//UILabel - Label for Cell - Name of Each Cell
@property (strong, nonatomic) IBOutlet UILabel *activityIndicatorLabel;



//NSStrings ---------------------------------------

//NSString - NSString Object - Location's Name

//Locations ---------------------------------------

//Locations - Temp Location Object - Used for manupulating location instances within the view
@property(strong, nonatomic) Location *aLocation;

//Locations - Location Object - sent to transportation View when a cell index is selected
@property(strong, nonatomic) Location *aTransportationLocation;

//LocationCache ---------------------------------------

//LocationsCache - Array of Locations- Caches locations
@property(strong, nonatomic) LocationCache *aLocationCache;
//LocationsCache - Array of Locations- Caches locations
@property(strong, nonatomic) NSArray *tempLocationCache;


//Array ----------------------------------


//Locations - Array of PFOject's - Contains Locations from Parse - to be Manipulated
@property(strong, nonatomic) NSArray *locations;



//Methods:

//AAPullToRefresh ----------------------------------

//AAPullToRefresh - Refresher Instance for the top view - Pull To Refresh Object
//-(void) topViewDidBeginRefershing: (AAPullToRefresh *) topView;

//AAPullToRefresh - Refresher Instance for the top view - Pull To Refresh Object
//-(void) bottomViewDidBeginRefershing: (AAPullToRefresh *) bottomView;


//UIView ---------------------------------------



//TableView ---------------------------------------

//TableView - Delegate & Datasource - methods used for initalizing cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
//TableView - Delegate & Datasource - method that details the number of cells to be displayed
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
//TableView - TableViewController - method for selecting tablecells
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
//TableView - Parse - Loads the location elements from parse
-(void)loadingAndStoringInitialLocationsFromParse:(NSArray *)locationsFromParse
                                        withError:(NSError *)error;
//TableView - Parse - Removes the activity indidcator and calls the parse background fetching method
-(void) findObjectInBackground;

//Initilizations -------------------------------------
-(void)initTableViewWithSettings;
-(void)initViewWithNSCoding;



//NSCoding ---------------------------------------

//NSCoding - App Delegate - method that is called when the app is being closed/crashes
-(void) enteringBackground;
//NSCoding - App Delegate - method that is called when the application is launched/reopened
-(void) enteringForeground;

//Locations ---------------------------------------

//Locations - Caching - method that caches the attrbutes retrieved from parse
-(void)cacheLocationAttributesFromParse;
//Locations - Caching - appending elements to the location cache
-(void)appendToLocationCache:(Location*)aLocationObject;
//Locations - Without Caching - appending elements to the location array
-(void)appendToLocationWithoutCache:(Location*)aLocationObject;

//Segue's ---------------------------------------

//Segue - View Controller Transitioning - sending attributes to TransportationViewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;


@end
