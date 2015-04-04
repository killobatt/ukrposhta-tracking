//
//  Parcel.h
//  ukrposhta-tracking
//
//  Created by Vjacheslav Volodjko on 04.04.15.
//  Copyright (c) 2015 Tolik Shevchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UPParcelTrackerInfo;

@interface UPParcel : NSObject< NSCoding >

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *parcelID; // Barcode tracking identifier
@property (strong, nonatomic) UPParcelTrackerInfo *trackerInfo;

@end
