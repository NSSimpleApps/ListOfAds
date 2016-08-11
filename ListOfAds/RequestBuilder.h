//
//  RequestBuilder.h
//  ListOfAds
//
//  Created by NSSimpleApps on 07.08.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// строит из базового URL запрос с параметрами
@interface RequestBuilder : NSObject

@property (copy, nullable) NSURL *URL;

- (instancetype)initWithString:(NSString *)string;
    
- (nullable NSURL *)URLWithParameters:(NSDictionary<NSString *, NSString *> *)parameters;

@end

NS_ASSUME_NONNULL_END