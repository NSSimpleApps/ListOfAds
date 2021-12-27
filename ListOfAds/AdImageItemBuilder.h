//
//  AdImageItemBuilder.h
//  ListOfAds
//
//  Created by NSSimpleApps on 08.08.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class AdImageItem;

typedef NSDictionary<NSString *, AdImageItem *> AdImageItemsDictionary;

/// строит из словаря словарь с изображениями и их id
@interface AdImageItemBuilder : NSObject

+ (AdImageItemsDictionary *)imageItemsWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end

@interface AdImageItem : NSObject

@property (nullable, copy) NSURL *URL;

@property (assign) NSInteger width;
@property (assign) NSInteger height;

@end

NS_ASSUME_NONNULL_END

