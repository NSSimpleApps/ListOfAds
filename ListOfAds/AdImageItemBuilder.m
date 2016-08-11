//
//  AdImageItemBuilder.m
//  ListOfAds
//
//  Created by NSSimpleApps on 08.08.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "AdImageItemBuilder.h"

static NSString *const FileNameKey = @"file_name";
static NSString *const FileExtensionKey = @"file_extension";
static NSString *const WidthKey = @"width";
static NSString *const HeightKey = @"height";
static NSString *const DomainKey = @"domain";

@implementation AdImageItemBuilder

+ (AdImageItemsDictionary *)imageItemsWithDictionary:(NSDictionary<NSString *, id> *)dictionary {
    
    NSMutableDictionary<NSString *, AdImageItem *> *items =
    [NSMutableDictionary dictionaryWithCapacity:dictionary.count];
    
    for (NSString *key in dictionary) {
        
        NSDictionary *info = dictionary[key];
        
        NSString *fileName = info[FileNameKey];
        NSString *fileExtension = info[FileExtensionKey];
        NSNumber *width = info[WidthKey];
        NSNumber *height = info[HeightKey];
        NSString *domain = info[DomainKey];
        
        if ((fileName == nil) || (fileExtension == nil) ||
            (width == nil) || (height == nil) || (domain == nil)) {
            
            continue;
            
        } else {
            
            NSURLComponents *components = [NSURLComponents new];
            components.scheme = @"http";
            components.host = domain;
                        
            if ([fileName hasPrefix:@"/"]) {
                
                components.path = [fileName stringByAppendingPathExtension:fileExtension];
                
            } else {
                
                components.path = [@"/" stringByAppendingString:[fileName stringByAppendingPathExtension:fileExtension]];
            }
                        
            AdImageItem *item = [AdImageItem new];
            item.width = width.integerValue;
            item.height = height.integerValue;
            item.URL = components.URL;
            
            items[key] = item;
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:items];
}

@end

@implementation AdImageItem
@end
