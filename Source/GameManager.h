//
//  GameManager.h
//  Sovokv1
//
//  Created by Askar Karimov on 8/5/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameManager : NSObject

@property (nonatomic, strong) NSMutableArray * players;

+ (GameManager *)sharedInstance;

@end
