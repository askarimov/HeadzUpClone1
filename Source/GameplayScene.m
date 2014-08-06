//
//  GameplayScene.m
//  Sovokv1
//
//  Created by Askar Karimov on 8/1/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameplayScene.h"
#import <CoreMotion/CoreMotion.h>
#import "DeviceMotionManager.h"


#define TRANSITION_DURATION 0.5f
#define kCMDeviceMotionUpdateFrequency (1.f/60.f)

static NSString * const kSceneNameMain = @"MainScene";

@interface GameplayScene () <DeviceMotionManagerDelegate>

@end

@implementation GameplayScene
{
    DeviceMotionManager *_deviceMM ;
    
    CCTransition *_transitionRight;
 
    CCNode * _stateNode;
}

- (void)didLoadFromCCB {
    
    // tell this scene to accept touches
    self.userInteractionEnabled = YES;
    
    // Set back navigation transition
    _transitionRight = [CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:TRANSITION_DURATION];
    
}

// -----------------------------------------------------------------------
#pragma mark - Enter & Exit
// -----------------------------------------------------------------------
- (void)onEnter
{
    // always call super onEnter first
    [super onEnter];
    
    _deviceMM = [DeviceMotionManager sharedInstance];
    _deviceMM.delegate = self;
    [_deviceMM startMotionManager];
    
    // In pre-v3, touch enable and scheduleUpdate was called here
    // In v3, touch is enabled by setting userInteractionEnabled for the individual nodes
    // Per frame update is automatically enabled, if update is overridden
    
}

// -----------------------------------------------------------------------

- (void)onExit
{
    // always call super onExit last
    [super onExit];

    [_deviceMM stopMotionManager];

}

- (void)update:(CCTime)delta {
    
    
}

#pragma mark - Handle touch events
// called on every touch in this scene
- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {

}
- (void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    NSArray * touchArray = [event.allTouches allObjects];
    
    if (touchArray.count == 2 && touch.tapCount == 2) {
        CCLOG(@"TWO FINGER TAP: GO BACK");
        [self navigateBack];
    }
}

#pragma mark - Private methods
- (void)displayEmpty {
    [_stateNode removeAllChildren];
}
- (void)displayStartScene {
    [_stateNode removeAllChildren];
    CCScene *level = [CCBReader loadAsScene:@"GameLayers/StartGameScene"];
    [_stateNode addChild:level];
}
- (void)displaySuccessScene {
    [_stateNode removeAllChildren];
    CCScene *level = [CCBReader loadAsScene:@"GameLayers/SuccessScene"];
    [_stateNode addChild:level];
}
- (void)displayFailScene {
    [_stateNode removeAllChildren];
    CCScene *level = [CCBReader loadAsScene:@"GameLayers/FailScene"];
    [_stateNode addChild:level];
}

- (void)navigateBack {
    // back to intro scene with transition
    CCScene * mainScene = [CCBReader loadAsScene:kSceneNameMain];
    
    [[CCDirector sharedDirector] replaceScene:mainScene
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:.5f]];
}

#pragma mark - DeviceMotionManager
- (void)motionManagerDidFlipUp {
    [self displayFailScene];
}
- (void)motionManagerDidFlipDown {
    [self displaySuccessScene];
}
- (void)motionManagerDidHold {
    [self displayEmpty];
}
- (void)motionManagerIdle {
    [self displayStartScene];
}


@end
