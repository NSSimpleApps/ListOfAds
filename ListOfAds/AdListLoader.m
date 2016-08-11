//
//  AdListLoader.m
//  ListOfAds
//
//  Created by NSSimpleApps on 08.08.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "AdListLoader.h"
#import "NetDataProvider.h"
#import "AdImageItemBuilder.h"
#import "AdTagsBuilder.h"
#import "AdvertBuilder.h"
#import "AdItem.h"
#import "Advert.h"

static NSString *const CodeKey = @"code";
static NSString *const ErrorKey = @"error";

static NSString *const LinkedKey = @"linked";
static NSString *const AdvertsKey = @"adverts";

@interface AdListLoader ()

@end

@implementation AdListLoader


- (void)loadAdListWithLimit:(NSInteger)limit offset:(NSInteger)offset {
    
    id<AdListLoaderDelegate> delegate = self.delegate;
    
    if (delegate) {
        
        [delegate adListLoader:self willBeginLoadAdListWithLimit:limit offset:offset];
    }
    
    __weak typeof(self) wSelf = self;
    
    [NetDataProvider loadAdvertsWithLimit:limit
                                   offset:offset
                               completion:^(NSDictionary * _Nonnull json) {
                                   
                                   __strong typeof(wSelf) sSelf = wSelf;
                                   
                                   if (sSelf) {
                                       
                                       [sSelf handleJSON:json];
                                   }
                                   
                               } error:^(NSError * _Nonnull error) {
                                   
                                   __strong typeof(wSelf) sSelf = wSelf;
                                   
                                   if (sSelf && delegate) {
                                       
                                       [delegate adListLoader:sSelf didFailLoadingAdListWithError:error];
                                   }
                               }];
}

- (void)handleJSON:(NSDictionary<NSString *, id> *)json {
    
    id<AdListLoaderDelegate> delegate = self.delegate;
    
    NSInteger code = [json[CodeKey] integerValue];
    id errorValue = json[ErrorKey];
    
    if (![errorValue isEqual:[NSNull null]]) {
        
        NSError *error = [NSError errorWithDomain:@"DOMAIN"
                                             code:code
                                         userInfo:@{NSLocalizedDescriptionKey: errorValue}];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (delegate) {
                
                [delegate adListLoader:self didFailLoadingAdListWithError:error];
            }
        });
        
    } else {
        
        NSDictionary<NSString *, id> *uploads = json[LinkedKey][UploadsKey];
        StringDictionary *tags = json[LinkedKey][TagsKey];
        StringDictionary *adTags = [AdTagsBuilder tagsWithDictionary:tags];
        
        AdImageItemsDictionary *imageItems =
        [AdImageItemBuilder imageItemsWithDictionary:uploads];
        
        NSArray<Advert *> *adverts = [AdvertBuilder advertsWithArray:json[AdvertsKey]];
        
        [adverts enumerateObjectsUsingBlock:^(Advert * _Nonnull advert, NSUInteger idx, BOOL * _Nonnull stop) {
            
            AdImageItem *imageItem = imageItems[advert.thumb];
            
            AdItem *adItem = [AdItem new];
            adItem.imageURL = imageItem.URL;
            adItem.updateDate = [self adDateFromString:advert.updateDate];
            adItem.title = advert.title;
            adItem.price = advert.cost;
            
            NSString *tag = advert.tags.firstObject;
            
            if (tag) {
                
                adItem.adType = adTags[tag];
            }
            
            if (delegate) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [delegate adListLoader:self didLoadAdItem:adItem
                                     index:idx length:adverts.count];
                });
            }
        }];
        
        if (delegate) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [delegate adListLoader:self didFinishLoadAdListWithLength:adverts.count];
            });
        }
    }
}

- (NSDate *)adDateFromString:(NSString *)string {
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssz";
    
    return [dateFormatter dateFromString:string];
}

@end
