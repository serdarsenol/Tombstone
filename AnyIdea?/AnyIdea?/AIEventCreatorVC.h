//
//  AIEventCreatorVC.h
//  AnyIdea?
//
//  Created by Serdar Senol on 10/20/13.
//  Copyright (c) 2013 Serdar Senol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "config.h"
#import <CoreLocation/CoreLocation.h>
#import "AIPlaceFinderDelegate.h"
#import "AIPlaceFinder.h"
#import "AIPlace.h"
#import "AIPlacesCell.h"
#import "AIPlacesDetailVC.h"


@interface AIEventCreatorVC : UIViewController <UITableViewDelegate,PlaceFinderDelegate, UISearchBarDelegate, CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *searchPlaceButton;
@property (strong, nonatomic) IBOutlet UITableView *placesTableView;
@property (strong, nonatomic) IBOutlet UISearchBar *placesSearchBar;

@end
