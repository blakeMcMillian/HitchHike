//
//  RootNavigationBar.m
//  HitchHike
//
//  Created by other  on 6/8/14.
//  Copyright (c) 2014 Blake McMillian. All rights reserved.
//

#import "RootNavigationBar.h"

@implementation RootNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [PCRootViewController drawRootNavigationBar];
}


@end
