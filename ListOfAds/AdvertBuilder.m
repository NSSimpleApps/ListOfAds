//
//  AdvertBuilder.m
//  ListOfAds
//
//  Created by NSSimpleApps on 08.08.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "AdvertBuilder.h"
#import "Advert.h"

static NSString *const TitleKey = @"title";

static NSString *const LinksKey = @"links";
static NSString *const TagsKey = @"tags";

static NSString *const ShortImagesKey = @"short_images";
static NSString *const MainKey = @"main";
static NSString *const ThumbKey = @"thumb";

static NSString *const CostKey = @"cost";
static NSString *const UpdateDateKey = @"update_date";

@implementation AdvertBuilder

+ (NSArray<Advert *> *)advertsWithArray:(NSArray<NSDictionary *> *)array {
    
    NSMutableArray<Advert *> *adverts = [NSMutableArray arrayWithCapacity:array.count];
    
    for (NSDictionary *dictionary in array) {
        
        NSString *title = dictionary[TitleKey];
        
        NSArray<NSString *> *tags = dictionary[LinksKey][TagsKey];
        
        id main = dictionary[ShortImagesKey][MainKey];
        
        NSString *thumb = nil;
        
        if (![main isEqual:[NSNull null]]) {
            
            thumb = main[LinksKey][ThumbKey];
        }
        
        NSNumber *cost = dictionary[CostKey];
        
        NSString *updateDate = dictionary[UpdateDateKey];
        
        if ((title == nil) ||
            (tags == nil) ||
            (updateDate == nil)) {
            
            continue;
            
        } else {
            
            Advert *advert = [Advert new];
            advert.title = title;
            advert.tags = tags;
            advert.cost = cost;
            advert.updateDate = updateDate;
            advert.thumb = thumb;
            
            [adverts addObject:advert];
        }
    }
    
    return adverts;
}

@end
