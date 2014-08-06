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

    _timer = [NSTimer scheduledTimerWithTimeInterval:.1f target:self selector:@selector(watch) userInfo:nil repeats:YES];

    if (_motionManager.isDeviceMotionAvailable) {
        _motionManager.deviceMotionUpdateInterval = kCMDeviceMotionUpdateFrequency;
        [_motionManager startDeviceMotionUpdates];
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
- (void)watch {
    
//    CMAcceleration gravity = currentDeviceMotion.gravity;
//    NSLog(@"GRAVITY = %.2f", gravity.z);
//    NSLog(@"GRAVITY Degrees = %.2f", CC_RADIANS_TO_DEGREES(gravity.z));

    CMDeviceMotion *currentDeviceMotion = _motionManager.deviceMotion;
    
    CMAttitude *currentAttitude = currentDeviceMotion.attitude;
    
    float roll = currentAttitude.roll;
        NSLog(@"fire delegate ");
    if (CC_RADIANS_TO_DEGREES(roll) < 95 && CC_RADIANS_TO_DEGREES(roll) > 85) {
        [self.delegate motionManagerDidHold];
    }else if (CC_RADIANS_TO_DEGREES(roll) < 30 ) {
        [self.delegate motionManagerDidFlipUp];
    }else if (CC_RADIANS_TO_DEGREES(roll) > 150 ) {
        [self.delegate motionManagerDidFlipDown];
    }else{
        [self.delegate motionManagerIdle];
    }
}



@end
