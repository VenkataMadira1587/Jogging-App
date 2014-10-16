//
//  CMLocation.h
//  JoggingApp
//
//  Created by Venkat on 03/02/2014.
//  Copyright (c) 2014 Venkat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
@interface CMLocation : UIViewController
@property(nonatomic,strong)CMMotionManager *motionManager;
@property(nonatomic,strong)UIView *ball;
@end
