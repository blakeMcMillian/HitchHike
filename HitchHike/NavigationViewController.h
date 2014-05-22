//
//  NavigationViewController.h
//  HitchHike
//
//  Created by Blake McMillian on 5/22/14.
//  Copyright (c) 2014 Blake McMillian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeTableViewController.h"

@interface NavigationViewController : UIViewController<HomeTableViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *testlabel;

@end
