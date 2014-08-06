//
//  CustomGameScene.m
//  Sovokv1
//
//  Created by Askar Karimov on 8/4/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CustomGameScene.h"
#import "AKTextField.h"
#import "cocos2d-ui.h"

#define TRANSITION_DURATION 0.5f
#define WORD_COUNT 20

@interface CustomGameScene () <AKTextFieldDelegate>

@end

@implementation CustomGameScene
{
    CCTransition *_transitionLeft;
    CCTextField *_tfWord;
}
- (void)didLoadFromCCB {
    // tell this scene to accept touches
    self.userInteractionEnabled = YES;
    
    _transitionLeft = [CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:TRANSITION_DURATION];
    
    [self setupViewElements];
}

// -----------------------------------------------------------------------
#pragma mark - Enter & Exit
// -----------------------------------------------------------------------

- (void)onEnter
{
    // always call super onEnter first
    [super onEnter];
}

// -----------------------------------------------------------------------

- (void)onExit
{
    // always call super onExit last
    [super onExit];
}


#pragma mark - View Setup
- (void)setupViewElements {
    
//    float start_y = title.positionInPoints.y-title.contentSize.height;
    
    float start_y = 500.0f;
    
    for(int i = 0; i < 5; i++) {
		
        AKTextField *enterName = [AKTextField textFieldWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"ccbResources/ccbTextField.png"]];
        enterName.delegate = self;
        enterName.fontSize = 16.0f;
        enterName.contentSize = CGSizeMake(280.0f, 40.0f);
        enterName.preferredSize = CGSizeMake(280.0f, 40.0f);
        enterName.positionType = CCPositionTypePoints;
        enterName.position = ccp(20,start_y-50-i*50-2.0f);
        enterName.name = [NSString stringWithFormat:@"word_tag_%i", i];

        [self addChild:enterName z:5];
	}
}

#pragma mark - Private methods

- (void)play {

    
    
}

#pragma mark - UITextField Delegate

//- (void)textFieldDidEndEditing:(UITextField *)textField {
//    CCLOG(@"word is : %@", textField.text);
//    NSLog(@"textFieldDidEndEditing");
//}

- (void)aktextFieldDidEndEditing:(UITextField *)textField {
    CCLOG(@"word is : %@", textField.text);
}

@end
