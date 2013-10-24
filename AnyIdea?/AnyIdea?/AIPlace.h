//
//  AIPlace.h
//  AnyIdea?
//
//  Created by Serdar Senol on 10/21/13.
//  Copyright (c) 2013 Serdar Senol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface AIPlace : NSObject<MKAnnotation>

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString * icon;
@property (nonatomic, retain) NSString *formatted_address;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSURL *url;


@end
