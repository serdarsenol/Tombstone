//
//  AIPlaceFinder.h
//  AnyIdea?
//
//  Created by Serdar Senol on 10/21/13.
//  Copyright (c) 2013 Serdar Senol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "AIPlaceFinderDelegate.h"

@interface AIPlaceFinder : NSObject

@property (nonatomic) id<PlaceFinderDelegate> delegate;

- (void)searchForPlacesWithQuery:(NSString *)query coordinate:(CLLocationCoordinate2D)coordinate;

@end
