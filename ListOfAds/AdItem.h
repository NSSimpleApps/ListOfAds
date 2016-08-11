//
//  AdItem.h
//  ListOfAds
//
//  Created by NSSimpleApps on 08.08.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AdItem : NSObject

/// класс, содержащий необходимые параметры объявления
@property (nullable, copy) NSURL *imageURL;

@property (nullable, copy) NSString *adType;

@property (copy) NSDate *updateDate;

@property (copy) NSString *title;

@property (nullable, copy) NSNumber *price;

@end

NS_ASSUME_NONNULL_END