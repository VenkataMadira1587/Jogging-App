//
//  CoreLocationMetrics.m
//  JoggingApp
//
//  Created by Venkat on 03/02/2014.
//  Copyright (c) 2014 Venkat. All rights reserved.
//

#import "CoreLocationMetrics.h"

@interface CoreLocationMetrics ()

@end

@implementation CoreLocationMetrics
@synthesize CLController;
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
    self.CLController=[[CoreLocationController alloc]init];
    self.CLController.delegate=self;
    [self.CLController.locMgr startUpdatingLocation];
}
-(void)locationUpdate:(CLLocation *)location{
    speedLabel.text = [NSString stringWithFormat:@"SPEED: %f", [location speed]];
	latitudeLabel.text = [NSString stringWithFormat:@"LATITUDE: %f", location.coordinate.latitude];
	longitudeLabel.text = [NSString stringWithFormat:@"LONGITUDE: %f", location.coordinate.longitude];
	altitudeLabel.text = [NSString stringWithFormat:@"ALTITUDE: %f", [location altitude]];

}
- (void)locationError:(NSError *)error {
	speedLabel.text = [error description];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
