//
//  DataProvider.m
//  ListOfAds
//
//  Created by NSSimpleApps on 07.08.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "NetDataProvider.h"
#import "RequestBuilder.h"

NSString *UploadsKey = @"uploads";
NSString *TagsKey = @"tags";
NSString *UpdateDateKey = @"update_date";
NSString *LimitKey = @"limit";
NSString *OffsetKey = @"offset";

static NSString *const ShortImagesKey = @"short_images";
static NSString *const CostKey = @"cost";

//static NSString *const BaseURLString = @"http://do.ngs.ru/api/v1/adverts/?include=uploads,tags&fields=short_images,cost,update_date";

@implementation NetDataProvider

+ (void)loadAdvertsWithLimit:(NSInteger)limit
                      offset:(NSInteger)offset
                  completion:(void(^)(NSDictionary *json))completionBlock
                       error:(nullable void(^)(NSError *error))errorBlock {
    
    RequestBuilder *requestBuilder = [[RequestBuilder alloc] initWithString:@"http://do.ngs.ru/api/v1/adverts/"];
    
    NSString *uploadsValue = [NSString stringWithFormat:@"%@,%@", UploadsKey, TagsKey];
    
    NSString *fieldsValue = [NSString stringWithFormat:@"%@,%@,%@", ShortImagesKey, CostKey, UpdateDateKey];
    
    NSURL *URL =
    [requestBuilder URLWithParameters:@{@"include": uploadsValue,
                                        @"fields": fieldsValue,
                                        LimitKey: @(limit).stringValue,
                                        OffsetKey: @(offset).stringValue}];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.HTTPAdditionalHeaders = @{@"Content-Type": @"application/json"};
    
    NSURLSession *URLSession = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask =
    [URLSession dataTaskWithURL:URL
              completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                  
                  if ((data != nil) && (error == nil)) {
                      
                      NSError *jsonError = nil;
                      
                      NSDictionary *json =
                      [NSJSONSerialization JSONObjectWithData:data
                                                      options:NSJSONReadingAllowFragments error:&jsonError];
                      
                      if ((jsonError != nil) && (errorBlock != nil)) {
                          
                          errorBlock(jsonError);
                          
                      } else if (completionBlock != nil) {
                          
                          completionBlock(json);
                      }
                      
                  } else if (errorBlock != nil) {
                      
                      errorBlock(error);
                  }
    }];
    [dataTask resume];
}

@end
