//
//  UIAlertController+Extension.m
//  BookShop
//
//  Created by NSSimpleApps on 07.08.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "UIAlertView+Extension.h"

@implementation UIAlertView (Extension)

- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle {
    
    return
    [self initWithTitle:title
                message:nil
               delegate:nil
      cancelButtonTitle:cancelButtonTitle
      otherButtonTitles:nil, nil];
}

@end
