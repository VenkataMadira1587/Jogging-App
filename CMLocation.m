//
//  CMLocation.m
//  JoggingApp
//
//  Created by Venkat on 03/02/2014.
//  Copyright (c) 2014 Venkat. All rights reserved.
//

#import "CMLocation.h"

@interface CMLocation ()

@end

@implementation CMLocation
#pragma mark nothing to change here

float X=0;
float Y=0;
float R=40;


-(void)initBall{
    self.ball=[[UIView alloc]initWithFrame:CGRectMake(160, 250, R, R)];
    self.ball.layer.cornerRadius=20;
    self.ball.backgroundColor=[UIColor redColor];
    [self.view addSubview:self.ball];
}

-(void)updateBallWithRoll:(float)roll Pitch:(float)pitch Yaw:(float)yaw accX:(float)accX accY:(float)accY accZ:(float)accZ
{
    X += 2 * roll;
    Y += 2 * pitch;
    
    X *= 0.8;
    Y *= 0.8;
    
    CGFloat newX = self.ball.frame.origin.x + X;
    CGFloat newY = self.ball.frame.origin.y + Y;
    
    newX = fmin(280, fmax(0, newX));
    newY = fmin(527, fmax(64, newY));
    
    CGFloat newR = R + 10 * accZ;
    
    self.ball.frame = CGRectMake(newX, newY, newR, newR);

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark Assignments

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initBall];
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateDeviceMotion) userInfo:nil repeats:YES];

    
    // Create a CMMotionManager instance and store it in the property "motionManager"
    self.motionManager=[[CMMotionManager alloc]init];
    
    
    // Set the motion update interval to 1/60
    self.motionManager.deviceMotionUpdateInterval=1.0/60.0;
    
    
    // Start updating the motion using the reference frame CMAttitudeReferenceFrameXArbitraryCorrectedZVertical
    [self.motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryCorrectedZVertical];
    
    
}

-(void)updateDeviceMotion
{

    
    // Get the deviceMotion from motionManager
    CMDeviceMotion *deviceMotion=self   .motionManager.deviceMotion;
    
    // Return if the returned CMDeviceMotion object is nil
    if(deviceMotion==nil){
        return;
        
    }
    
    
    // Get the attitude from CMDeviceMotion
    CMAttitude *attitude=deviceMotion.attitude;
    
    
    // Get the userAcceleration from CMDeviceMotion
    CMAcceleration userAcceleration=deviceMotion.userAcceleration;
    
    
    // Call "updateBallWithRoll:Pitch:Yaw:accX:accY:accZ:" on self with the appropriate arguments
    float roll=attitude.roll;
    float pitch=attitude.pitch;
    float yaw=attitude.yaw;
    float accX=userAcceleration.x;
    float accY=userAcceleration.y;
    float accZ=userAcceleration.z;
    [self updateBallWithRoll:roll Pitch:pitch Yaw:yaw accX:accX accY:accY accZ:accZ];
    
    
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if(self.motionManager != nil){
        
        
        // Stop updating the motionManager
        [self.motionManager stopAccelerometerUpdates];
        
        //Set the ivar "motionManager" to nil
        self.motionManager=nil;
        
        
    }
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

@end
