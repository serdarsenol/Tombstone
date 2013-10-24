//
//  AIEventCreatorVC.m
//  AnyIdea?
//
//  Created by Serdar Senol on 10/20/13.
//  Copyright (c) 2013 Serdar Senol. All rights reserved.
//

#import "AIEventCreatorVC.h"

@interface AIEventCreatorVC ()

@property (nonatomic) AIPlaceFinder *placeFinder;
@property (nonatomic) NSArray *places;
@property (nonatomic) NSString *searchString;
@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) CLLocationCoordinate2D userCoordinate;

@end

@implementation AIEventCreatorVC
@synthesize searchPlaceButton;
@synthesize placesTableView;
@synthesize placesSearchBar;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startStandardUpdates];
	self.view.backgroundColor=coalColor;
    placesSearchBar.delegate=self;
    searchPlaceButton.backgroundColor=coralColor;
    searchPlaceButton.titleLabel.textColor=seaWeedColor;    
    placesSearchBar.barTintColor=slateGrayColor;
    [placesSearchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"clear_Background"] forState:UIControlStateNormal];
    UITextField *searchField = [placesSearchBar valueForKey:@"_searchField"];
    searchField.textColor = [UIColor whiteColor];
    placesTableView.delegate=self;
    placesTableView.backgroundColor=coalColor;
    placesTableView.separatorColor=seperatorColor;
    
    placesTableView.hidden=YES;
}

- (void)startStandardUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (!self.locationManager)
        self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    
    // Set a movement threshold for new events.
    self.locationManager.distanceFilter = 50; // meters
    
    [self.locationManager startUpdatingLocation];
}

- (void)createPlacesFromJSONData:(NSData *)jsonData {
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&localError];
    
    if (localError == nil) {
        
        
        NSString *status = [parsedObject valueForKey:@"status"];
        NSLog(@"STATUS CODE: %@", status);
        
        NSMutableArray *placesArray = [[NSMutableArray alloc] init];
        
        NSArray *results = [parsedObject valueForKey:@"results"];
        NSLog(@"COUNT: %lu", (unsigned long)results.count);
        
        for (NSDictionary *placeDic in results) {
            AIPlace *place = [[AIPlace alloc] init];
            
            for (NSString *key in placeDic) {
                if ([place respondsToSelector:NSSelectorFromString(key)]) {
                    [place setValue:[placeDic valueForKey:key] forKey:key];
                    NSLog(@"%@: %@", key, [place valueForKey:key]);
                }
            }
            
            [placesArray addObject:place];
        }
        self.places = [NSArray arrayWithArray:placesArray];
        [placesTableView reloadData];
    }
    else {
        NSLog(@"Error: %@", localError);
    }
    
}

- (void)findPlacesWithQuery:(NSString *)query {
    //CLLocationCoordinate2D LautrupvangCoordinates = CLLocationCoordinate2DMake(55.731291, 12.397009);
    
    [self.placeFinder searchForPlacesWithQuery:query coordinate:self.userCoordinate];
}

- (AIPlaceFinder *)placeFinder{
    if (!_placeFinder) {
        _placeFinder = [[AIPlaceFinder alloc] init];
        _placeFinder.delegate = self;
    }
    return _placeFinder;
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.places.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AIPlacesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AIPlacesCell" forIndexPath:indexPath];
    
    AIPlace *place = [self.places objectAtIndex:indexPath.row];
    cell.placeNameLabel.text=place.name;
    NSString *ImageURL = place.icon;
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
    cell.placeImageView.image = [UIImage imageWithData:imageData];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"seguePlaceDetail"]) {
        NSIndexPath *indexPath = [placesTableView indexPathForSelectedRow];
        AIPlace *place = self.places[indexPath.row];
        ((AIPlacesDetailVC *)segue.destinationViewController).place = place;
        ((AIPlacesDetailVC *)segue.destinationViewController).title = self.searchString;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
}
-(void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self startSearch:searchText];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
}

- (void)startSearch:(NSString *)searchString
{
    //CANCEL CURRENT SEARCH?
    
    //Clear table
    self.places = nil;
    [self.placesTableView reloadData];
    
    self.searchString = searchString;
    [self findPlacesWithQuery:searchString];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
    // check to see if Location Services is enabled, there are two state possibilities:
    // 1) disabled for entire device, 2) disabled just for this app
    //
    NSString *causeStr = nil;
    
    // check whether location services are enabled on the device
    if ([CLLocationManager locationServicesEnabled] == NO)
    {
        causeStr = @"device";
    }
    // check the application’s explicit authorization status:
    else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        causeStr = @"app";
    }
    else
    {
        // we are good to go, start the search
        [self startSearch:searchBar.text];
    }
    
    if (causeStr != nil)
    {
        NSString *alertMessage = [NSString stringWithFormat:@"You currently have location services disabled for this %@. Please refer to \"Settings\" app to turn on Location Services.", causeStr];
        
        UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:@"Location Services Disabled"
                                                                        message:alertMessage
                                                                       delegate:nil
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
        [servicesDisabledAlert show];
    }
    
}

#pragma mark - CLLocationManagerDelegate methods

// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    
    CLLocation* userLocation = [locations lastObject];
    self.userCoordinate = userLocation.coordinate;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    // report any errors returned back from Location Services
}


- (IBAction)openPlacesTableView:(id)sender {
    placesTableView.hidden=NO;
}


@end
