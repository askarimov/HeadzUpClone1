//
//  AKTextField.m
//  Sovokv1
//
//  Created by Askar Karimov on 8/4/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "AKTextField.h"

@implementation AKTextField

- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    CCLOG(@"aktf did begin editing");
//    [self.delegate aktextFieldDidBeginEditing:textField];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
//    CCLOG(@"aktf did end editing");
    [self.delegate aktextFieldDidEndEditing:textField];
}

@end
