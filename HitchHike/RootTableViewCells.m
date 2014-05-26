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
    if (self) {
        // Initialization code
        [self.locationImage setImage:[UIImage imageNamed:@"placeHolder.png"]];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
