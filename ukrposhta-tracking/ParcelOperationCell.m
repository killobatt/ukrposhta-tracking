//
//  ParcelOperationCell.m
//  ukrposhta-tracking
//
//  Created by Vjacheslav Volodjko on 04.04.15.
//  Copyright (c) 2015 Tolik Shevchenko. All rights reserved.
//

#import "ParcelOperationCell.h"
#import "UPParcels.h"

@interface ParcelOperationCell ()

@property (weak, nonatomic) IBOutlet UILabel *postOfficeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *postOfficeIndexLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventDescriptionLabel;

@end

@implementation ParcelOperationCell

- (void)setParcelOperation:(UPParcelTrackerOperation *)parcelOperation
{
    _parcelOperation = parcelOperation;
    [self updateUI];
}

- (void)updateUI
{
    self.postOfficeNameLabel.text = self.parcelOperation.postOfficeName;
    self.postOfficeIndexLabel.text = [self.parcelOperation.postOfficeIndex stringValue];
    self.eventDescriptionLabel.text = self.parcelOperation.operationDescription;
    
    NSDateFormatter *numberFormatter = [NSDateFormatter new];
    numberFormatter.dateFormat = @"hh:mm";
    self.timeLabel.text = [numberFormatter stringFromDate:self.parcelOperation.date];
}

@end
