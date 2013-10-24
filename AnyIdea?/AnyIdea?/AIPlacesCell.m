//
//  AIPlacesCell.m
//  AnyIdea?
//
//  Created by Serdar Senol on 10/21/13.
//  Copyright (c) 2013 Serdar Senol. All rights reserved.
//

#import "AIPlacesCell.h"

@implementation AIPlacesCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    self.placeImageView.layer.cornerRadius = 20.0f;
    self.placeImageView.layer.borderWidth = 3.0f;
    self.placeImageView.layer.borderColor = [UIColor colorWithRed:110.0/255.0 green:104.0/255.0 blue:99.0/255.0 alpha:1].CGColor;
}

@end
