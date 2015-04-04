//
//  DetailViewController.m
//  ukrposhta-tracking
//
//  Created by Tolik on 4/4/15.
//  Copyright (c) 2015 Tolik Shevchenko. All rights reserved.
//

#import "ParcelDetailViewController.h"
#import "UPParcels.h"

@interface ParcelDetailViewController ()

@end

@implementation ParcelDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
}

@end
