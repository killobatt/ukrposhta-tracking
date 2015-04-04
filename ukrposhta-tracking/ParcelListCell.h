//
//  ParcelListCell.h
//  ukrposhta-tracking
//
//  Created by Vjacheslav Volodjko on 04.04.15.
//  Copyright (c) 2015 Tolik Shevchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UPParcel;

@interface ParcelListCell : UITableViewCell

@property (strong, nonatomic) UPParcel *parcel;

@end
