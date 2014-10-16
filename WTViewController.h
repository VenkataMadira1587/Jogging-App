//
//  WTViewController.h
//  JoggingApp
//
//  Created by Venkat on 01/02/2014.
//  Copyright (c) 2014 Venkat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface WTViewController : UIViewController<UIAccelerometerDelegate>{

    int stepsCount;
    float distence;
    float speed;
    float time;
    BOOL isChange;
    BOOL isSleeping;
    
    //Initial x y z values
    float px;
    float py;
    float pz;
    

}
@property(nonatomic,strong)IBOutlet UILabel *stepCountLbl;
@property(nonatomic,strong)IBOutlet UILabel *distanceLbl;
@property(nonatomic,strong)IBOutlet UILabel *timeLbl;
@property(nonatomic,strong)IBOutlet UILabel *speedLbl;

////map view
//@property(strong,nonatomic)IBOutlet MKMapView *mapView;
//@property(strong,nonatomic)CLLocationManager *locationManager;
//@property(strong,nonatomic)CLLocation *startLocation;
//

@property(nonatomic,strong)CMMotionManager *motionManager;

-(IBAction)reset:(id)sender;
@end
