//
//  AIPlacesDetailVC.h
//  AnyIdea?
//
//  Created by Serdar Senol on 10/23/13.
//  Copyright (c) 2013 Serdar Senol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "AIPlace.h"

@interface AIPlacesDetailVC : UIViewController

@property (nonatomic) AIPlace *place;
@property (strong, nonatomic) IBOutlet UILabel *placeNameLabel;
@property (strong, nonatomic) IBOutlet UITextView *placeAddressTextView;
@property (nonatomic, strong) NSArray *mapItemList;
@property (nonatomic, assign) MKCoordinateRegion boundingRegion;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end
