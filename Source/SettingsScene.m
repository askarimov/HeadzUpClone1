//
//  SettingsScene.m
//  Sovokv1
//
//  Created by Askar Karimov on 8/1/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "SettingsScene.h"

#define TRANSITION_DURATION 0.5f

@implementation SettingsScene
{
    CCTransition *_transitionRight;
    
    CCButton *_btnEnglish;
    CCButton *_btnRussian;
    CCButton *_btnKazakh;
    CCButton *_btnBack;
}

// is called when ccb file has completed loading
- (void)didLoadFromCCB {
    // tell this scene to accept touches
    self.userInteractionEnabled = YES;
    
    _transitionRight = [CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:TRANSITION_DURATION];
    
    [_btnBack setTitle:[[LocalizationManager sharedInstance] localizedStringForKey:@"button_title_back"]];
    
    [_btnEnglish setName:@"EN_LOCALE"];
    [_btnRussian setName:@"RU_LOCALE"];
}

#pragma mark - Private methods
- (void)changeLocale:(id)sender{
    CCButton *btn = (CCButton*)sender;
    if ([btn.name isEqualToString:@"EN_LOCALE"]) {
        NSLog(@"change locale to en");
        [self changeLocaleTo:@"en"];
    }else{
        NSLog(@"change locale to ru");
        [self changeLocaleTo:@"ru"];
    }
}

- (void)changeLocaleTo:(NSString*)locale {
    if (![locale isEqualToString:[[LocalizationManager sharedInstance] getCurrentlySelectedLocale]]) {
        [[LocalizationManager sharedInstance] setCurrentlySelectedLocale:locale];
        
        [self retry]; // reload scene after locale update
    }
}
- (void)retry {
    // reload current level
    [[CCDirector sharedDirector] replaceScene:[CCBReader loadAsScene:@"SettingsScene"]];
}

- (void)btnEnglishPressed {
    
}

- (void)btnBackPressed {
    // back to intro scene with transition
    CCScene * mainScene = [CCBReader loadAsScene:@"MainScene"];
    
    [[CCDirector sharedDirector] replaceScene:mainScene
                               withTransition:_transitionRight];
}


@end
