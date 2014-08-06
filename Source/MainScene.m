//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "LocalizationManager.h"

#define TRANSITION_DURATION 0.5f

static NSString * const kSceneNameSettings = @"SettingsScene";
static NSString * const kSceneNameInfo = @"InfoScene";
static NSString * const kSceneNameSinglePlayer = @"SingleplayerScene";
static NSString * const kSceneNameMultiPlayer = @"MultiplayerScene";
static NSString * const kSceneNameGameplay = @"GameplayScene";

static NSString * const kSceneNameCustomGame = @"CustomGameScene";

@implementation MainScene
{
    CCTransition *_transitionLeft;
    
    // Buttons
    CCButton *_btnSettings;
    CCButton *_btnInfo;
    CCButton *_btnSingleplayer;
    CCButton *_btnMultiplayer;
    CCButton *_btnCustom;
    CCButton *_btnHowToPlay;
    
}

// is called when ccb file has completed loading
- (void)didLoadFromCCB {
    // tell this scene to accept touches
    self.userInteractionEnabled = YES;
    
    _transitionLeft = [CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:TRANSITION_DURATION];
    
    [_btnSettings setTitle:[[LocalizationManager sharedInstance] localizedStringForKey:@"button_title_settings"]];
    [_btnInfo setTitle:[[LocalizationManager sharedInstance] localizedStringForKey:@"button_title_info"]];
    [_btnHowToPlay setTitle:[[LocalizationManager sharedInstance] localizedStringForKey:@"button_title_how2play"]];
    [_btnSingleplayer setTitle:[[LocalizationManager sharedInstance] localizedStringForKey:@"button_title_singleplayer"]];
    [_btnMultiplayer setTitle:[[LocalizationManager sharedInstance] localizedStringForKey:@"button_title_multiplayer"]];
    [_btnCustom setTitle:[[LocalizationManager sharedInstance] localizedStringForKey:@"button_title_custom"]];
}

#pragma mark - Button Actions
- (void)playSingleplayer {
    CCLOG(@"play singleplayer button pressed");
    CCScene *gameplayScene = [CCBReader loadAsScene:kSceneNameGameplay];
    [[CCDirector sharedDirector] replaceScene:gameplayScene withTransition:_transitionLeft];
}


- (void)playMultiplayer {
    CCLOG(@"play multiplayer button pressed");
    CCScene *scene = [CCBReader loadAsScene:kSceneNameMultiPlayer];
    [[CCDirector sharedDirector] replaceScene:scene];
}

- (void)playCustom {
    CCLOG(@"play custom button pressed");
    CCScene *scene = [CCBReader loadAsScene:kSceneNameCustomGame];
    [[CCDirector sharedDirector] replaceScene:scene];
}

- (void)openSettingsScene {
    CCLOG(@"open settings button pressed");
    CCScene *settingsScene = [CCBReader loadAsScene:kSceneNameSettings];
    [[CCDirector sharedDirector] replaceScene:settingsScene withTransition:_transitionLeft];
}

- (void)openInfoScene {
    CCLOG(@"open info button pressed");
    CCScene *scene = [CCBReader loadAsScene:kSceneNameInfo];
    [[CCDirector sharedDirector] replaceScene:scene withTransition:_transitionLeft];
}

- (void)btnHow2PlayPressed {
    CCLOG(@"open how to play button pressed");
}


@end
