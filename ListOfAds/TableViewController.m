//
//  TableViewController.m
//  ListOfAds
//
//  Created by NSSimpleApps on 07.08.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "TableViewController.h"
#import "UITableView+RegisterCell.h"
#import "AdsCell.h"
#import "AdListLoader.h"
#import "AdItemViewModel.h"
#import "AdItem.h"
#import "UIAlertView+Extension.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface TableViewController () <AdListLoaderDelegate>

@property (strong) AdListLoader *adListBuilder;

@property (strong) NSMutableArray<AdItem *> *items;

@property (weak, nonatomic) IBOutlet UIButton *bottomButton;

@property (assign) NSInteger offset;

@end

@implementation TableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.items = [NSMutableArray array];
    
    [self.tableView registerCellForCellClass:[AdsCell class]];
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.adListBuilder = [AdListLoader new];
    self.adListBuilder.delegate = self;
}

-  (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
    [self.items removeAllObjects];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AdItem *item = self.items[indexPath.row];
    
    AdItemViewModel *adItemViewModel = [[AdItemViewModel alloc] initWithAdItem:item];
    
    AdsCell *cell =
    [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AdsCell class]) forIndexPath:indexPath];
    cell.tagsLabel.text = adItemViewModel.adTyteTitle;
    cell.dateLabel.text = adItemViewModel.dateTitle;
    cell.descriptionLabel.text = adItemViewModel.title;
    cell.priceLabel.text = adItemViewModel.priceTitle;
    
    __weak typeof(cell) wCell = cell;
    [cell.mainImageView sd_setImageWithURL:item.imageURL
                          placeholderImage:[UIImage imageNamed:@"placeholder"]
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                     
                                     __strong typeof(wCell) sCell = wCell;
                                     
                                     if (sCell) {
                                         
                                         [sCell layoutIfNeeded];
                                     }
                                 }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIActivityViewController *activityViewController =
    [[UIActivityViewController alloc]
     initWithActivityItems:@[self.items[indexPath.row].title] applicationActivities:nil];
    
    [self presentViewController:activityViewController animated:YES completion:nil];
}

- (IBAction)loadAds:(UIButton *)sender {
    
    [self.adListBuilder loadAdListWithLimit:10 offset:self.offset];
}


- (void)adListLoader:(AdListLoader *)adListLoader willBeginLoadAdListWithLimit:(NSInteger)limit offset:(NSInteger)offset {
    
    self.bottomButton.enabled = NO;
    [self.tableView beginUpdates];
}

- (void)adListLoader:(AdListLoader *)adListLoader
       didLoadAdItem:(AdItem *)adItem
               index:(NSInteger)index
              length:(NSInteger)length {
    
    [self.items addObject:adItem];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.items.count - 1 inSection:0];
    
    [self.tableView insertRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)adListLoader:(AdListLoader *)adListLoader didFinishLoadAdListWithLength:(NSInteger)length {
    
    self.bottomButton.enabled = YES;
    [self.tableView endUpdates];
    
    self.offset += length;
}

- (void)adListLoader:(AdListLoader *)adListLoader didFailLoadingAdListWithError:(NSError *)error {
    
    UIAlertView *alertView =
    [[UIAlertView alloc] initWithTitle:error.localizedDescription
                     cancelButtonTitle:@"Close"];
    
    [alertView show];
    
    self.bottomButton.enabled = YES;
    [self.tableView endUpdates];
}


@end
