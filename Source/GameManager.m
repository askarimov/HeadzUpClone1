    //
//  GameManager.m
//  Sovokv1
//
//  Created by Askar Karimov on 8/5/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameManager.h"

@implementation GameManager

+ (GameManager *)sharedInstance {
    static dispatch_once_t once;
    static GameManager *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (!self) return nil;
    
    _players = [[NSMutableArray alloc] init];
    
    return self;
}


@end
