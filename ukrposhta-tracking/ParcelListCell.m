//
//  ParcelListCell.m
//  ukrposhta-tracking
//
//  Created by Vjacheslav Volodjko on 04.04.15.
//  Copyright (c) 2015 Tolik Shevchenko. All rights reserved.
//

#import "ParcelListCell.h"
#import "UPParcels.h"

@interface ParcelListCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *parcelIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *parcelStateDescriptionLabel;

@end

@implementation ParcelListCell

- (void)setParcel:(UPParcel *)parcel
{
    _parcel = parcel;
    [self updateUI];
}

- (void)updateUI
{
    self.nameLabel.text = self.parcel.name;
    self.parcelIDLabel.text = self.parcel.parcelID;
//    self.parcelStateDescriptionLabel.text = self.parcel.name;
}

@end
