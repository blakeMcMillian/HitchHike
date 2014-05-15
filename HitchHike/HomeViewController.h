//
//  HomeViewController.h
//  Hitch
//
//  Created by Blake McMillian on 5/10/14.
//  Copyright (c) 2014 Blake McMillian. All rights reserved.
//

#import <Parse/Parse.h>
#import "Location.h"
#import "MainTableViewCells.h"
#import "LocationCache.h"

@interface HomeViewController : PFQueryTableViewController<UITableViewDataSource, UITableViewDelegate>

//Attributes:

//NSStrings ---------------------------------------

//NSString - NSString Object - Location's Name

//Locations ---------------------------------------

//Locations - Array of PFOject's - Contains Locations from Parse
@property(strong, nonatomic) Location *aLocation;

//LocationCache ---------------------------------------

//LocationsCache - Array of Locations- Caches locations
@property(strong, nonatomic) LocationCache *aLocationCache;
//LocationsCache - Array of Locations- Caches locations
@property(strong, nonatomic) NSArray *tempLocationCache;

//Array ----------------------------------


//Locations - Array of PFOject's - Contains Locations from Parse - to be Manipulated
@property(strong, nonatomic) NSArray *locations;



//Methods:

//TableView ---------------------------------------

//TableView - Delegate & Datasource - methods used for initalizing cells
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath; ATTENTION: NOT CURRENTLY BEING USED
//TableView - Delegate & Datasource - method that details the number of cells to be displayed
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section; ATTENTION: NOT CURRENTLY BEING USED
//TableView - Parse - Loads the location elements from parse
-(void)loadingLocationsFromParse;
//TableView - PFQueryTableViewController - method used for initalizing cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object;


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













@end
