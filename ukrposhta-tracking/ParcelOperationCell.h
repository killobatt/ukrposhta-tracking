//
//  ParcelOperationCell.h
//  ukrposhta-tracking
//
//  Created by Vjacheslav Volodjko on 04.04.15.
//  Copyright (c) 2015 Tolik Shevchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UPParcelTrackerOperation;

@interface ParcelOperationCell : UITableViewCell

@property (strong, nonatomic) UPParcelTrackerOperation *parcelOperation;

@end
