//
//  CellBackgroundView.m
//  HitchHike
//
//  Created by other  on 6/8/14.
//  Copyright (c) 2014 Blake McMillian. All rights reserved.
//

#import "CellBackgroundView.h"
#import "PCRootViewController.h"

@implementation CellBackgroundView

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
    [PCRootViewController drawRootTableCell];
    
}


@end
