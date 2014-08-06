//
//  DeviceMotionManager.h
//  Sovokv1
//
//  Created by Askar Karimov on 8/4/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

@protocol DeviceMotionManagerDelegate <NSObject>

@optional
- (void)motionManagerDidFlipUp;
- (void)motionManagerDidFlipDown;
- (void)motionManagerDidHold;
- (void)motionManagerIdle;

@end


@interface DeviceMotionManager : NSObject
{
    CMMotionManager *_motionManager;
}

@property (nonatomic, assign) id <DeviceMotionManagerDelegate> delegate;

+ (DeviceMotionManager *)sharedInstance;

- (void)startMotionManager;
- (void)stopMotionManager;

@end
