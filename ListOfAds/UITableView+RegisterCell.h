//
//  UITableView+RegisterCell.h
//  ListOfAds
//
//  Created by NSSimpleApps on 07.08.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import <UIKit/UIKit.h>

/// разширение для регистрации ячеек
@interface UITableView (RegisterCell)

- (void)registerCellForCellClass:(Class)cellClass;

@end
