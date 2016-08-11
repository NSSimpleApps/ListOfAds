//
//  DataProvider.h
//  ListOfAds
//
//  Created by NSSimpleApps on 07.08.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *UploadsKey;
extern NSString *TagsKey;
extern NSString *UpdateDateKey;
extern NSString *LimitKey;
extern NSString *OffsetKey;

/// отправляет запрос в сеть и возвращает словарь, построенный из ответа сервера 
@interface NetDataProvider : NSObject

+ (void)loadAdvertsWithLimit:(NSInteger)limit
                      offset:(NSInteger)offset
                  completion:(void(^)(NSDictionary *json))completionBlock
                       error:(nullable void(^)(NSError *error))errorBlock;

@end

NS_ASSUME_NONNULL_END