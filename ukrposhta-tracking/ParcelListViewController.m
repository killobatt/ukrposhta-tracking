//
//  MasterViewController.m
//  ukrposhta-tracking
//
//  Created by Tolik on 4/4/15.
//  Copyright (c) 2015 Tolik Shevchenko. All rights reserved.
//

#import "ParcelListViewController.h"
#import "ParcelDetailViewController.h"
#import "ParcelListCell.h"
#import "UPParcels.h"

@interface ParcelListViewController ()

@end

@implementation ParcelListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)update
{
    [self.tableView reloadData];
}

- (UPParcelList *)parcelList
{
    return [UPParcelList sharedInstance];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        UPParcel *parcel = self.parcelList.parcels[indexPath.row];
        ParcelDetailViewController *detailController = [segue destinationViewController];
        detailController.parcel = parcel;
    }
}

- (IBAction)unwind:(UIStoryboardSegue *)segue
{
    [self.tableView reloadData];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.parcelList.parcels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ParcelListCell *cell = (ParcelListCell *)[tableView dequeueReusableCellWithIdentifier:@"ParcelListCell"
                                                                             forIndexPath:indexPath];

    UPParcel *parcel = self.parcelList.parcels[indexPath.row];
    cell.parcel = parcel;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Видалити";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UPParcel *parcel = self.parcelList.parcels[indexPath.row];
        [self.parcelList removeParcel:parcel];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
