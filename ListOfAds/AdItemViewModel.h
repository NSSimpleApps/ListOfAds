//
//  AdItemViewModel.h
//  ListOfAds
//
//  Created by NSSimpleApps on 08.08.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class AdItem;

/// ViewModel-класс, отвечающий за отображение AdItem в ячейке
@interface AdItemViewModel : NSObject

- (instancetype)initWithAdItem:(AdItem *)adItem;

@property (strong, nonatomic) AdItem *adItem;

@property (copy, readonly) NSString *adTyteTitle;
@property (copy, readonly) NSString *dateTitle;
@property (copy, readonly) NSString *title;
@property (nullable, copy, readonly) NSString *priceTitle;

@end

NS_ASSUME_NONNULL_END
