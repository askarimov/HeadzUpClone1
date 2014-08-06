//
//  GameScene.m
//  Sovokv1
//
//  Created by Askar Karimov on 8/1/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameScene.h"

#define TRANSITION_DURATION 0.5f

@implementation GameScene
{
    CCTransition *_transitionRight;
}
- (void)didLoadFromCCB {
    
    // tell this scene to accept touches
    self.userInteractionEnabled = YES;
    
    // Set back navigation transition
    _transitionRight = [CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:TRANSITION_DURATION];

    
}

- (void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
        CCLOG(@"TWO TAPS: GO BACK");
    if (touch.tapCount == 2) {
        CCLOG(@"TWO TAPS: GO BACK");
        [self btnBackPressed];
    }
}

#pragma mark - Private methods


- (void)btnBackPressed {
    // back to intro scene with transition
    CCScene * mainScene = [CCBReader loadAsScene:@"MainScene"];
    
    [[CCDirector sharedDirector] replaceScene:mainScene
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:.5f]];
}

@end
