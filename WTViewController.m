//
//  WTViewController.m
//  JoggingApp
//
//  Created by Venkat on 01/02/2014.
//  Copyright (c) 2014 Venkat. All rights reserved.
//

#import "WTViewController.h"
#define kUpdateFRQ 60.0

@interface WTViewController ()

@end

@implementation WTViewController
@synthesize stepCountLbl;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
    
    

       // [[UIAccelerometer sharedAccelerometer]setUpdateInterval:1.0/ kUpdateFRQ ];
    px=py=pz=0;

    stepsCount=0;
    
    self.motionManager=[[CMMotionManager alloc]init ];
    
    if([self.motionManager isAccelerometerAvailable]){
        NSOperationQueue *queue=[[NSOperationQueue alloc]init];
        [self.motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
           
            NSLog(@"X= %.04f Y=%.04f Z=%.04f",accelerometerData.acceleration.x,accelerometerData.acceleration.y,accelerometerData.acceleration.z);
            float xx=accelerometerData.acceleration.x  ;
            float yy=accelerometerData.acceleration.y  ;
            float zz=accelerometerData.acceleration.z  ;
            
            float dot=(px * xx)+(py * yy)+(pz * zz);
            float a=ABS(sqrt(px * px + py * py + pz * pz));
            float b=ABS(sqrt(xx * xx + yy * yy + zz * zz));
            
            
            
            dot/=(a*b);
            if  (dot<=0.82){
                if(!isSleeping){
                    [self performSelector:@selector(wakeUP) withObject:nil afterDelay:0.3];
                    stepsCount+=1;
                    self.stepCountLbl.text=[NSString stringWithFormat:@"%d",stepsCount];
                    self.timeLbl.text=[NSString stringWithFormat:@"%f",accelerometerData.timestamp];
                   
                    distence=ABS(sqrt((px-xx)*(px-xx)+(py-yy)*(py-yy)+(pz-zz)*(pz-zz)));
                    self.distanceLbl.text=[NSString stringWithFormat:@"%f",distence];
                    speed=accelerometerData.timestamp *distence;
                    self.speedLbl.text=[NSString stringWithFormat:@"%f",(accelerometerData.timestamp*distence)];
                    
                    time=accelerometerData.timestamp;
                    self.timeLbl.text=[NSString stringWithFormat:@"%f",time];
                }
            }
            
        }];
    }else{
        NSLog(@"Accelerometer is not Available");
    }
}
-(void)wakeUP{
    isSleeping=NO;
}
/*-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation    {
    _mapView.centerCoordinate=userLocation.location.coordinate;
}*/
-(void)reset:(id)sender{
    stepsCount=0;
    distence=0;
    speed=0;
    self.stepCountLbl.text=[NSString stringWithFormat:@"%d",stepsCount];
    self.distanceLbl.text=@"";
    self.speedLbl.text=@"";
    self.timeLbl.text=@"";
    px=py=pz=0;
    //xx=yy=zz=0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
