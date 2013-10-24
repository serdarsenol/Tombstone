//
//  AIPlaceFinder.m
//  AnyIdea?
//
//  Created by Serdar Senol on 10/21/13.
//  Copyright (c) 2013 Serdar Senol. All rights reserved.
//

#import "AIPlaceFinder.h"

#define API_KEY @"AIzaSyCuFDVIWtYsRk8g339Nan-DTxW21KarrC0"

@implementation AIPlaceFinder

- (void)searchForPlacesWithQuery:(NSString *)query coordinate:(CLLocationCoordinate2D)coordinate {
    int radius = 5000;
    
    NSString *googleApiUrlString  = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/textsearch/json?query=%@&key=%@&sensor=true&location=%f,%f&radius=%i", query, API_KEY, coordinate.latitude, coordinate.longitude, radius];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [[delegateFreeSession dataTaskWithURL: [NSURL URLWithString: googleApiUrlString]
                        completionHandler:^(NSData *data, NSURLResponse *response,
                                            NSError *error) {
                            
                            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                            NSLog(@"Got response %@ with error %@.\n", response, error);
                            NSLog(@"DATA:\n%@\nEND DATA\n",
                                  [[NSString alloc] initWithData: data
                                                        encoding: NSUTF8StringEncoding]);
                            //parse data
                            [self.delegate createPlacesFromJSONData:data];
                            
                        }] resume];
    [delegateFreeSession finishTasksAndInvalidate];
}


@end

