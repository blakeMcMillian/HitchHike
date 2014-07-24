//
//  CustomMainTableViewCells.m
//  Hitch
//
//  Created by Blake McMillian on 5/7/14.
//  Copyright (c) 2014 Blake McMillian. All rights reserved.
//

#import "RootTableViewCells.h"

@implementation RootTableViewCells

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        // Initialization code
        [self.locationImage setImage:[UIImage imageNamed:@"placeHolder.png"]];
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = UIBezierPath.bezierPath;
    [bezierPath moveToPoint: CGPointMake(320, 0)];
    [bezierPath addCurveToPoint: CGPointMake(320, 163.44) controlPoint1: CGPointMake(320, 0) controlPoint2: CGPointMake(320, 163.44)];
    [bezierPath addLineToPoint: CGPointMake(60.99, 163.44)];
    [bezierPath addCurveToPoint: CGPointMake(40.21, 184.21) controlPoint1: CGPointMake(57.95, 166.48) controlPoint2: CGPointMake(40.21, 184.21)];
    [bezierPath addCurveToPoint: CGPointMake(19.44, 163.44) controlPoint1: CGPointMake(40.21, 184.21) controlPoint2: CGPointMake(22.48, 166.48)];
    [bezierPath addLineToPoint: CGPointMake(0, 163.44)];
    [bezierPath addLineToPoint: CGPointMake(0, 0)];
    [bezierPath addLineToPoint: CGPointMake(320, 0)];
    [bezierPath addLineToPoint: CGPointMake(320, 0)];
    [bezierPath closePath];
    
    //setting the layer mask for the navigation bar
    CAShapeLayer *mask = [CAShapeLayer layer];
    mask.path = bezierPath.CGPath;
    
    //setting the mask onto the navigation view
    self.shapeLayer.layer.mask = mask;
    
    
    //setting up the translucent view
    self.translucentView.translucentAlpha = .7;
    self.translucentView.translucentStyle = UIBarStyleDefault;
    self.translucentView.translucentTintColor = [UIColor clearColor];
    self.translucentView.backgroundColor = [UIColor clearColor];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
