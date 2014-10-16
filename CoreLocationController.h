//
//  CoreLocationController.h
//  JoggingApp
//
//  Created by Venkat on 03/02/2014.
//  Copyright (c) 2014 Venkat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol CoreLocationControllerDelegate
@required
-(void)locationUpdate:(CLLocation *)location;
-(void)locationError:(NSError *)error;
@end


@interface CoreLocationController : NSObject<CLLocationManagerDelegate>{
    
    CLLocationManager *locMgr;
   // id delegate;
}

@property(nonatomic,retain)CLLocationManager *locMgr;
@property(nonatomic,assign)id delegate;
@end
