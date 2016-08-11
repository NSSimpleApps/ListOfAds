//
//  AdItemViewModel.m
//  ListOfAds
//
//  Created by NSSimpleApps on 08.08.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "AdItemViewModel.h"
#import "AdItem.h"

@implementation AdItemViewModel

- (instancetype)initWithAdItem:(AdItem *)adItem {
    
    self = [super init];
    
    if (self) {
        
        self.adItem = adItem;
    }
    
    return self;
}

- (void)setAdItem:(AdItem *)adItem {
    
    _adItem = adItem;
    
    if (adItem.adType == nil) {
        
        _adTyteTitle = @"Не указано";
        
    } else {
        
        _adTyteTitle = adItem.adType.capitalizedString;
    }
    
    _dateTitle = [self customDateFormatWithDate:adItem.updateDate];
    _title = adItem.title;
    
    if ((adItem.price == nil) || adItem.price.integerValue == 0) {
        
        _priceTitle = nil;
        
    } else {
        
        _priceTitle = [self customPriceFormatWithNumber:adItem.price];
    }
}

- (NSString *)customDateFormatWithDate:(NSDate *)date {
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"dd.MM.yyyy";
        
    return [dateFormatter stringFromDate:date];
}

- (NSString *)customPriceFormatWithNumber:(NSNumber *)number {
    
    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    numberFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"ru-RU"];
    numberFormatter.positiveFormat = @"#,##0 ¤";
    numberFormatter.currencySymbol = @"руб.";
    
    return [numberFormatter stringFromNumber:number];
}

@end
