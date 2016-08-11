//
//  AdListLoader.h
//  ListOfAds
//
//  Created by NSSimpleApps on 08.08.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class AdListLoader, AdItem;

/// протокол, опеределяющий стадии загрузки и обработки ответа с сервера
@protocol AdListLoaderDelegate <NSObject>

- (void)adListLoader:(AdListLoader *)adListLoader
willBeginLoadAdListWithLimit:(NSInteger)limit offset:(NSInteger)offset;

- (void)adListLoader:(AdListLoader *)adListLoader
        didLoadAdItem:(AdItem *)adItem
                index:(NSInteger)index
               length:(NSInteger)length;

- (void)adListLoader:(AdListLoader *)adListLoader didFinishLoadAdListWithLength:(NSInteger)length;

- (void)adListLoader:(AdListLoader *)adListLoader didFailLoadingAdListWithError:(NSError *)error;

@end

/// загружает список объявлений, сообщает об этом делегату
@interface AdListLoader : NSObject

@property (weak, nullable) id<AdListLoaderDelegate> delegate;

- (void)loadAdListWithLimit:(NSInteger)limit offset:(NSInteger)offset;

@end

NS_ASSUME_NONNULL_END