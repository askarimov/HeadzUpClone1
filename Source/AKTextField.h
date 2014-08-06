//
//  AKTextField.h
//  Sovokv1
//
//  Created by Askar Karimov on 8/4/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCTextField.h"

@protocol AKTextFieldDelegate <NSObject>
@optional
- (void)aktextFieldDidEndEditing:(UITextField *)textField ;
- (void)aktextFieldDidBeginEditing:(UITextField *)textField ;

@end

@interface AKTextField : CCTextField

@property (nonatomic, assign) id <AKTextFieldDelegate> delegate;

@end
