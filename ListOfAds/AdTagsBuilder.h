//
//  AdTagsBuilder.h
//  ListOfAds
//
//  Created by NSSimpleApps on 08.08.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSDictionary<NSString *, NSString *> StringDictionary;

/// строит из словаря словарь с индентификаторами рекламы
@interface AdTagsBuilder : NSObject

+ (StringDictionary *)tagsWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END