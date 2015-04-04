//
//  DetailViewController.m
//  ukrposhta-tracking
//
//  Created by Tolik on 4/4/15.
//  Copyright (c) 2015 Tolik Shevchenko. All rights reserved.
//

#import "ParcelDetailViewController.h"
#import "ParcelOperationCell.h"
#import "UPParcels.h"

@interface ParcelDetailViewController ()

@end

@implementation ParcelDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 56.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 

- (void)setParcel:(UPParcel *)parcel
{
    _parcel = parcel;
    self.title = parcel.name;
    [self.tableView reloadData];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.parcel.trackerInfo.operations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ParcelOperationCell *cell = (ParcelOperationCell *)[tableView dequeueReusableCellWithIdentifier:@"ParcelOperationCell"
                                                                             forIndexPath:indexPath];
    
    UPParcelTrackerOperation *operation = self.parcel.trackerInfo.operations[indexPath.row];
    cell.parcelOperation = operation;
    return cell;
}


@end
