//
//  InfoScene.m
//  Sovokv1
//
//  Created by Askar Karimov on 8/1/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "InfoScene.h"

@implementation InfoScene

- (void)btnBackPressed {
    // back to intro scene with transition
    CCScene * mainScene = [CCBReader loadAsScene:@"MainScene"];
    
    [[CCDirector sharedDirector] replaceScene:mainScene
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:.5f]];
}


@end
