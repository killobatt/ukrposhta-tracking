//
//  ParcelList.h
//  ukrposhta-tracking
//
//  Created by Vjacheslav Volodjko on 04.04.15.
//  Copyright (c) 2015 Tolik Shevchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UPParcel;

@interface UPParcelList : NSObject< NSCoding >

+ (instancetype)sharedInstance;

@property (strong, readonly, nonatomic) NSArray *parcels;
- (void)addParcel:(UPParcel *)parcel;
- (void)removeParcel:(UPParcel *)parcel;

- (void)save;
- (void)updateTrackerInfoForParcel:(UPParcel *)parcel completionBlock:(void (^)(UPParcel *parcel))block;

@end
