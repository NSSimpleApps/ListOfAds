//
//  AdvertBuilder.h
//  ListOfAds
//
//  Created by NSSimpleApps on 08.08.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Advert;

/// строит из массива adverts из json массив модельных объектов Adverts 
@interface AdvertBuilder : NSObject

+ (NSArray<Advert *> *)advertsWithArray:(NSArray<NSDictionary *> *)array;

@end

NS_ASSUME_NONNULL_END