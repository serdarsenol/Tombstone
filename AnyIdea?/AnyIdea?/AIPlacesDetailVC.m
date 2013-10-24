//
//  AIPlacesDetailVC.m
//  AnyIdea?
//
//  Created by Serdar Senol on 10/23/13.
//  Copyright (c) 2013 Serdar Senol. All rights reserved.
//

#import "AIPlacesDetailVC.h"

@interface AIPlacesDetailVC ()

@end


@implementation AIPlacesDetailVC


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self configureView];
}

#pragma mark - Managing the detail item

- (void)setPlace:(id)place
{
    if (_place != place) {
        _place = place;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.place) {
        self.placeNameLabel.text = self.place.name;
        self.placeAddressTextView.text = self.place.formatted_address;
    
    }
}

@end
