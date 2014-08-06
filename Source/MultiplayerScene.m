//
//  MultiplayerScene.m
//  Sovokv1
//
//  Created by Askar Karimov on 8/4/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "MultiplayerScene.h"
#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "AKTextField.h"
#import "GameManager.h"

#define TRANSITION_DURATION 0.5f
#define MAX_COUNT 5
#define kRowHeight 40

@interface MultiplayerScene () <CCTableViewDataSource, AKTextFieldDelegate>

@end

@implementation MultiplayerScene
{
    CCTransition *_transitionRight;
    CCTextField *_tfWord;
    CCTableView *_tableView;
    
    CCNode *_contentNode;
    CCNodeColor *_maskRect;
    
    // Buttons
    CCButton *_btnBack;
    CCButton *_btnPlay;
    
    GameManager *_gameManager;
}

- (void)didLoadFromCCB {
    
    // tell this scene to accept touches
    self.userInteractionEnabled = YES;
    
    _gameManager = [GameManager sharedInstance];
    
    _transitionRight = [CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:TRANSITION_DURATION];
    
    [_btnBack setTitle:[[LocalizationManager sharedInstance] localizedStringForKey:@"button_title_back"]];
    
    [self setupViewElements];

}

#pragma mark - Private methods

- (void)setupViewElements {
    
    CCNodeColor *scissorRect = [CCNodeColor nodeWithColor:[CCColor redColor] width:_contentNode.contentSize.width height:_contentNode.contentSize.height];
    [scissorRect setAnchorPoint:CGPointMake(0, 0)];
    [scissorRect setPosition:ccp(0, 0)];
    
    CCLOG(@"content node c size = %f", _contentNode.contentSize.height);
    
    CCClippingNode *mask = [CCClippingNode clippingNodeWithStencil:scissorRect];
    mask.contentSize = _contentNode.contentSize;
    [mask setAlphaThreshold:0.0];
    mask.anchorPoint = CGPointMake(0, 0);
    mask.position = ccp(0, 0);
//    mask.color = [CCColor greenColor];
    
    [_contentNode addChild:mask];
    
//    _tableView = [CCTableView node];
    _tableView = [[CCTableView alloc] init];
    _tableView.positionType = CCPositionTypePoints;
    _tableView.position = ccp(0, 0);

    _tableView.contentSizeType = CCSizeTypeNormalized;
    _tableView.contentSize = CGSizeMake(1.0, 1.0);
    _tableView.rowHeight = kRowHeight;
    _tableView.rowHeightUnit = CCSizeUnitUIPoints;
    _tableView.block = ^(CCTableView * table) {
        CCLOG(@"Cell %d was pressed", (int)table.selectedRow);
    };
    
    [mask addChild:_tableView];
    _tableView.dataSource = self;

}

- (void)btnBackPressed {
    // back to intro scene with transition
    CCScene * mainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:mainScene withTransition:_transitionRight];
}

- (void)addPlayer {
    CCLOG(@"PLAYER NAME: %@", _tfWord.string);
    [_gameManager.players addObject:_tfWord.string];
    [_tableView reloadData];
    _tfWord.string = @"";
}
- (void)removePlayer:(id)sender {
    CCButton *btn = (CCButton*)sender;
    NSLog(@"remove button name : %@", btn.name);
    [_gameManager.players removeObjectAtIndex:(int)[btn.name intValue]];
    [_tableView reloadData];
}
- (void)startPlaying {
    CCLOG(@"START PLAYING");
    
    for (int i = 0; i<MAX_COUNT; i++) {
        
        CCLOG(@"START PLAYING");
        
    }
    
}



#pragma mark - Table view
- (CCTableViewCell *)tableView:(CCTableView *)tableView nodeForRowAtIndex:(NSUInteger)index {
    CCTableViewCell *cell = [CCTableViewCell node];
    cell.contentSizeType = CCSizeTypeMake(CCSizeUnitNormalized, CCSizeUnitUIPoints);
    cell.contentSize = CGSizeMake(1.0f, 40.0f);

    // add color background
//    CCNodeColor* colorNode = [CCNodeColor nodeWithColor:[CCColor colorWithRed:255.0f green:255.0f blue:0.0f ] width:280.0f height:40.0f];
//    [cell addChild:colorNode];
    
    // Create a label with the row number
    CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d. %@", (int)index+1, _gameManager.players[index]] fontName:@"HelveticaNeue" fontSize:20 * [CCDirector sharedDirector].UIScaleFactor];
//    lbl.positionType = CCPositionTypeNormalized;
//    lbl.position = ccp(0.5, 0.5);
    lbl.positionType = CCPositionTypeMake(CCPositionUnitPoints, CCPositionUnitPoints, CCPositionReferenceCornerTopLeft);
    lbl.position = ccp(15, 5);
    lbl.anchorPoint = ccp(0, 1);
    lbl.contentSize = CGSizeMake(230, 40);
    NSLog(@"Label size x = %f", lbl.position.x);
    [cell addChild:lbl];
    
    // Remove player button
    CCButton *removeButton = [CCButton buttonWithTitle:@"Remove"];
//    removeButton.positionType = CCPositionTypePoints;
    removeButton.positionType = CCPositionTypeMake(CCPositionUnitPoints, CCPositionUnitPoints, CCPositionReferenceCornerTopLeft);
    removeButton.position = ccp(lbl.position.x+lbl.contentSize.width - 30, 5);
    removeButton.anchorPoint = ccp(0, 1);
    removeButton.contentSize = CGSizeMake(30, 30);
    [removeButton setTarget:self selector:@selector(removePlayer:)];
    removeButton.name = [NSString stringWithFormat:@"%i", index];
    [cell addChild:removeButton];
   
//    AKTextField *enterName = [AKTextField textFieldWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"ccbResources/ccbTextField.png"]];
//    enterName.delegate = self;
//    enterName.fontSize = 16.0f;
//    enterName.contentSize = CGSizeMake(250.0f, 40.0f);
//    enterName.preferredSize = CGSizeMake(250.0f, 40.0f);
//    enterName.positionType = CCPositionTypePoints;
//    enterName.position = ccp(0.5f, 0.5f);
//    enterName.name = [NSString stringWithFormat:@"word_tag_%i", index];
//
//    [cell addChild:enterName];
    
    return cell;
}


- (NSUInteger)tableViewNumberOfRows:(CCTableView *)tableView {
//    return MAX_COUNT;
    return [_gameManager.players count];
}


#pragma mark - UITextField Delegate

//- (void)textFieldDidEndEditing:(UITextField *)textField {
//    CCLOG(@"word is : %@", textField.text);
//    NSLog(@"textFieldDidEndEditing");
//}

- (void)aktextFieldDidEndEditing:(UITextField *)textField {
    CCLOG(@"word is : %@", textField.text);
}
- (void)aktextFieldDidBeginEditing:(UITextField *)textField {
    
}
@end
