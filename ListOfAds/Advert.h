//
//  Advert.h
//  ListOfAds
//
//  Created by NSSimpleApps on 08.08.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// класс, содержащий параметры объявления (элемент массива adverts в json)
@interface Advert : NSObject

@property (copy) NSString *title;

@property (copy) NSArray<NSString *> *tags;

@property (nullable, copy) NSNumber *cost;

@property (nullable, copy) NSString *thumb;

@property (copy) NSString *updateDate;

@end

NS_ASSUME_NONNULL_END