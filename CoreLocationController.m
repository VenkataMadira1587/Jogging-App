//
//  CoreLocationController.m
//  JoggingApp
//
//  Created by Venkat on 03/02/2014.
//  Copyright (c) 2014 Venkat. All rights reserved.
//

#import "CoreLocationController.h"

@implementation CoreLocationController
@synthesize locMgr,delegate;

-(id)init{
    self=[super init];
    if(self!=nil){
        self.locMgr=[[CLLocationManager alloc]init];
        self.locMgr.delegate=self;
    }
    return self;
}
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    if([self.delegate conformsToProtocol:@protocol(CoreLocationControllerDelegate)]) {
		[self.delegate locationUpdate:newLocation];
        CLLocationDistance  distence=[oldLocation getDistanceFrom:newLocation];
        NSString *distenceMoved=[NSString stringWithFormat:@"%f",distence];
        NSLog(@"%@",distenceMoved);
	}

}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	if([self.delegate conformsToProtocol:@protocol(CoreLocationControllerDelegate)]) {
		[self.delegate locationError:error];
	}
}
@end
