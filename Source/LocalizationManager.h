//
//  LocalizationManager.h
//  LocalizationTestApp
//
//  Created by Askar Karimov on 7/29/14.
//  Copyright (c) 2014 appfactory. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalizationManager : NSObject
{
    NSUserDefaults* _defaults;
    NSBundle *_bundle ;
}

@property (nonatomic, strong) NSString *selectedLocale;
@property (nonatomic, strong) NSString *selectedLanguage;


+ (LocalizationManager *)sharedInstance;

/*
 *  Returns localized string for currently selected language
 */
- (NSString *) localizedStringForKey:(NSString *)key;

/*
 *  Sets currently selected language
 */
- (void) setCurrentlySelectedLocale:(NSString *) locale;

/*
 *  Returns currently selected language
 */
- (NSString *) getCurrentlySelectedLocale;

@end
