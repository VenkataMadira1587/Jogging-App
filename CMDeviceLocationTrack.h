//
//  CMDeviceLocationTrack.h
//  JoggingApp
//
//  Created by Venkat on 03/02/2014.
//  Copyright (c) 2014 Venkat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface CMDeviceLocationTrack : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate>
{
    IBOutlet UIButton *locateButton;
    IBOutlet MKMapView *mapView;
    IBOutlet UILabel *coordinatesLabel;
    IBOutlet UILabel *locationNameLabel;
    
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;

}
-(IBAction)startUserLocalization:(id)sender;
@end
