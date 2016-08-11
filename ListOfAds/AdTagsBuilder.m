//
//  AdTagsBuilder.m
//  ListOfAds
//
//  Created by NSSimpleApps on 08.08.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "AdTagsBuilder.h"

static NSString *const IdKey = @"id";
static NSString *const TitleKey = @"title";

@implementation AdTagsBuilder

+ (NSDictionary<NSString *, NSString *> *)tagsWithDictionary:(NSDictionary<NSString *, id> *)dictionary {
    
    NSMutableDictionary<NSString *, NSString *> *tags =
    [NSMutableDictionary dictionaryWithCapacity:dictionary.count];
    
    for (NSString *key in dictionary) {
        
        NSDictionary *d = dictionary[key];
        
        NSString *idItem = d[IdKey];
        NSString *title = d[TitleKey];
        
        if ((idItem == nil) || (title == nil)) {
            
            continue;
            
        } else {
            
            tags[idItem] = title;
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:tags];
}

@end
