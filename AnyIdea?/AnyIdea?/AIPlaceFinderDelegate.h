//
//  AIPlaceFinderDelegate.h
//  AnyIdea?
//
//  Created by Serdar Senol on 10/21/13.
//  Copyright (c) 2013 Serdar Senol. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PlaceFinderDelegate <NSObject>

- (void)createPlacesFromJSONData:(NSData *)jsonData;

@end
