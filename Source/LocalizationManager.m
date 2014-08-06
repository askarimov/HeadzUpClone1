    //
//  LocalizationManager.m
//  LocalizationTestApp
//
//  Created by Askar Karimov on 7/29/14.
//  Copyright (c) 2014 appfactory. All rights reserved.
//

#import "LocalizationManager.h"

static NSString* const mctDefaultLanguageKey = @"ru";
static NSString* const mctCurrentLanguageKey = @"mctLocalization.currentLanguageKey";

static NSString* const mctNotificationCenterLanguageChanged = @"mctNotificationCenter.languageChanged";

@implementation LocalizationManager

+ (LocalizationManager *)sharedInstance {
    static dispatch_once_t once;
    static LocalizationManager *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

/* ============================================================ Initializers ============================================================ */
- (id)init
{
    self = [super init];
    if (self)
    {
        _defaults = [NSUserDefaults standardUserDefaults];
        _bundle = [NSBundle mainBundle];
        
    }
    return self;
}

/**
 *  Returns default language ==> should be @"ru"
 */
- (NSString*)getDefaultLocale
{
    return mctDefaultLanguageKey;
}

/**
 *  Resets this system. ??? may not need this
 */
- (void) resetLocalization
{
    _bundle = [NSBundle mainBundle];
}

/**
 *  Returns currently selected language
 */
- (NSString *) getCurrentlySelectedLocale
{
    NSString *currentLanguage = [_defaults objectForKey:mctCurrentLanguageKey];
    
    if (currentLanguage == nil)
    {
        currentLanguage = mctDefaultLanguageKey;
        NSString *path = [[NSBundle mainBundle] pathForResource:mctDefaultLanguageKey ofType:@"lproj"];
        if (path == nil)
        {
            [self resetLocalization];
        }
    }
    
    return currentLanguage;
}

- (NSString*)localizedStringForKey:(NSString *)key
{
    NSString *path = [[NSBundle mainBundle] pathForResource:[self getCurrentlySelectedLocale] ofType:@"lproj"];
    _bundle = [NSBundle bundleWithPath:path];
    return [_bundle localizedStringForKey:key value:@"" table:nil];
}

/*
 *  Sets currently selected locale
 */
- (void) setCurrentlySelectedLocale:(NSString *) locale
{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:locale ofType:@"lproj"];
    
    if (path == nil)
    {
        // файлы локализации не были найдены - сбрасываем _currentLanguage в nil и bundle в [NSBundle mainBundle]
        [self resetLocalization];
    }
    else
    {
        _bundle = [NSBundle bundleWithPath:path];
    }
    
    // тут по желанию можно посылать нотификейшн об успешной смене локали.
//    [[NSNotificationCenter defaultCenter] postNotificationName:mctNotificationCenterLanguageChanged object:self];
    
    [_defaults setObject:locale forKey:mctCurrentLanguageKey];
    
}

@end
