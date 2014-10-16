//
//  CMDeviceLocationTrack.m
//  JoggingApp
//
//  Created by Venkat on 03/02/2014.
//  Copyright (c) 2014 Venkat. All rights reserved.
//

#import "CMDeviceLocationTrack.h"

@interface CMDeviceLocationTrack ()

@end

@implementation CMDeviceLocationTrack

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark Nothing to change here
- (void)updateMapLocationToLatitude:(CLLocationDegrees)lat longitude:(CLLocationDegrees)lon
{
    coordinatesLabel.text = [NSString stringWithFormat:@"lat = %.02f, lon = %.02f", lat, lon];
    
    // Add an annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(lat, lon);
    point.coordinate = coord;
    [mapView addAnnotation:point];
    
    // Scroll to the desired location
    MKCoordinateSpan span = MKCoordinateSpanMake(0.001f, 0.001f);
    [mapView setRegion:MKCoordinateRegionMake(coord, span) animated:YES];
}

-(MKAnnotationView *)mapView:(MKMapView *)aMapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *reuseIdentifier = @"myPin";
    MKPinAnnotationView *pin = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
    if(pin == nil)
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    pin.annotation = annotation;
    pin.pinColor = MKPinAnnotationColorGreen;
    pin.animatesDrop = YES;
    
    return pin;
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Error in updating the location: %@", error);
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [self locationManager:manager didUpdateLocations:[NSArray arrayWithObject:newLocation]];
}


#pragma mark Assignments

-(IBAction)startUserLocalization:(id)sender
{
 
    
    // Create an instance of CLLocationManager and store it in the locationManager ivar (if nil)
    
    locationManager=[[CLLocationManager alloc]init];
    // Set the delegate of "locationManagter" to self
    
    locationManager.delegate=self;
    
    // Set the distance filter to 1 meters
    
    locationManager.distanceFilter=1.0f;
    
    //Set the desired accuracy to kCLLocationAccuracyNearestTenMeters
    locationManager.desiredAccuracy=kCLLocationAccuracyNearestTenMeters;
    
    
    //Start updating the location
    [locationManager startUpdatingLocation];
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{

    
    // Grab the latest location (last element in the array)
    
    CLLocation *location=[locations lastObject];
    // save latitude and longitude from the location in local variables
    CLLocationDegrees lat=location.coordinate.latitude;
    
    CLLocationDegrees lon=location.coordinate.longitude;
    
    // Call "updateMapLocationToLatitude:longitude:" and
    [self updateMapLocationToLatitude:lat longitude:lon];
    
    
    // 3.2 call "reverseGeocodeLocation:" on self with the obtained location
    [self reverseGeocodeLocation:location];
    
}

- (void)reverseGeocodeLocation:(CLLocation*)location
{
    
    
    

    
    // Cancel the running geocoding request
    
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         // Return in case of errors or empty results
         if(error != nil){
             NSLog(@"Geocoder error: %@",error);
             return ;
         }
         else if(placemarks==nil){
             //Extract any placemark from the result
             return;
         }
         
         // 3.3 Set the "text" property of locationNameLabel to the name of placemark
         CLPlacemark *placemark=(CLPlacemark *)[placemarks objectAtIndex:0];
         locationNameLabel.text=[placemark name];
         
     }
     ];
}




@end
