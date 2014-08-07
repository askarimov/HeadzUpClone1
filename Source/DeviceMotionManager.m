//
//  DeviceMotionManager.m
//  Sovokv1
//
//  Created by Askar Karimov on 8/4/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "DeviceMotionManager.h"

#define kCMDeviceMotionUpdateFrequency (1.f/60.f)

@implementation DeviceMotionManager
{
    NSTimer *_timer;
}
+ (DeviceMotionManager *)sharedInstance {
    static dispatch_once_t once;
    static DeviceMotionManager *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

/* ============================================================ Initializers ============================================================ */
- (id)init
{
    self = [super init];
    if (self)
    {
    
    }
    return self;
}

#pragma mark - Public methods
- (void)startMotionManager {

    _motionManager = [[CMMotionManager alloc] init];

    if (_motionManager.isDeviceMotionAvailable) {
        
        _motionManager.accelerometerUpdateInterval = kCMDeviceMotionUpdateFrequency;
        
        [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                                 withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
                                                     [self accelerometer:accelerometerData.acceleration];
                                                     if(error){
                                                         NSLog(@"%@", error);
                                                     }
                                                 }];
    }
}



- (void)stopMotionManager {

    if (_motionManager.isDeviceMotionAvailable) {
        
        NSLog(@"should stop motion updpates");
        [_motionManager stopDeviceMotionUpdates];
    }
    
    [_timer invalidate];
    _timer = nil;
    
}


#pragma mark - Private methods

- (void)accelerometer:(CMAcceleration)acceleration {
	   
//    NSLog(@"acceleration.z = %f", acceleration.z);
    
    float acc_z = acceleration.z;
    
    if (acc_z < 0.1 && acc_z > -0.1) {
        [self.delegate motionManagerDidHold];
    }else if (acc_z < -0.8 ) {
        [self.delegate motionManagerDidFlipUp];
    }else if (acc_z > 0.8 ) {
        [self.delegate motionManagerDidFlipDown];
    }else{
        [self.delegate motionManagerIdle];
    }
    
}


@end
