//
//  RequestBuilder.m
//  ListOfAds
//
//  Created by NSSimpleApps on 07.08.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "RequestBuilder.h"

@implementation RequestBuilder

- (instancetype)initWithString:(NSString *)string {

    self = [super init];
    
    if (self) {
        
        self.URL = [NSURL URLWithString:string];
    }
    return self;
}

- (nullable NSURL *)URLWithParameters:(NSDictionary<NSString *, NSString *> *)parameters {
    
    if (self.URL == nil) {
        
        return nil;
    }
    
    NSMutableArray<NSURLQueryItem *> *queryItems =
    [NSMutableArray arrayWithCapacity:parameters.count];
    
    for (NSString *name in parameters) {
        
        [queryItems addObject:[NSURLQueryItem queryItemWithName:name value:parameters[name]]];
    }
    
    NSURLComponents *components =
    [NSURLComponents componentsWithURL:self.URL resolvingAgainstBaseURL:YES];
    components.queryItems = queryItems;
    
    return components.URL;
}

@end
