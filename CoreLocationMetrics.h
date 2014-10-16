//
//  CoreLocationMetrics.h
//  JoggingApp
//
//  Created by Venkat on 03/02/2014.
//  Copyright (c) 2014 Venkat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CoreLocationController.h"

@interface CoreLocationMetrics : UIViewController<CoreLocationControllerDelegate>

{   CoreLocationController *CLController;
    IBOutlet UILabel *speedLabel;
    IBOutlet UILabel *latitudeLabel;
    IBOutlet UILabel *longitudeLabel;
    IBOutlet UILabel *altitudeLabel;
}
@property (nonatomic, strong) CoreLocationController *CLController;

@end
