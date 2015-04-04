//
//  ParcelList.m
//  ukrposhta-tracking
//
//  Created by Vjacheslav Volodjko on 04.04.15.
//  Copyright (c) 2015 Tolik Shevchenko. All rights reserved.
//

#import "UPParcelList.h"
#import "UPParcel.h"
#import "UPParcelTracker.h"
#import "UPParcelTrackerInfo.h"
#import "UPParcelTrackerOperation.h"

#import <UIKit/UIKit.h>

static NSString * const kUPParcelListParcelsKey = @"parcels";
static NSString * const kUPParcelListUpdatedParcelsKey = @"updated-parcels";

@interface UPParcelList ()
@property (strong, nonatomic) NSMutableArray *parcelList;
@property (strong, nonatomic) NSMutableArray *updatedParcels;
@end

@implementation UPParcelList

#pragma mark - Singletone

+ (instancetype)sharedInstance
{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self loadParcelList];
        if (instance == nil) {
            instance = [[self alloc] init];
        }
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.parcelList = [@[] mutableCopy];
        self.updatedParcels = [@[] mutableCopy];
    }
    return self;
}

#pragma mark - Parcel List

- (NSArray *)parcels
{
    return self.parcelList;
}

- (void)addParcel:(UPParcel *)parcel
{
    [self.parcelList insertObject:parcel atIndex:0];
    [self save];
}

- (void)removeParcel:(UPParcel *)parcel;
{
    [self.parcelList removeObject:parcel];
    [self save];
}

- (UPParcel *)parcelWithParcelID:(NSString *)parcelID
{
    for (UPParcel *parcel in self.parcelList) {
        if ([parcel.parcelID isEqualToString:parcelID]) {
            return parcel;
        }
    }
    return nil;
}

#pragma mark - 

- (void)updateTrackerInfoForParcel:(UPParcel *)parcel completionBlock:(void (^)(UPParcel *parcel, BOOL updated))block
{
    [UPParcelTracker trackerInfoForParcelID:parcel.parcelID
                            completionBlock:^(NSString *parcelID, UPParcelTrackerInfo *info) {
                                UPParcel *parcel = [self parcelWithParcelID:parcelID];
                                BOOL updated = NO;
                                if (parcel.trackerInfo.operations) {
                                    UPParcelTrackerOperation *lastOperation = parcel.trackerInfo.operations.lastObject;
                                    UPParcelTrackerOperation *newLastOperation = info.operations.lastObject;
                                    if (lastOperation.date.timeIntervalSince1970 < newLastOperation.date.timeIntervalSince1970) {
                                        updated = YES;
                                        if (![self.updatedParcels containsObject:parcel]) {
                                            [self.updatedParcels addObject:parcel];
                                        }
                                        [self presentNotificationForParcel:parcel operation:newLastOperation];
                                    }
                                }
                                parcel.trackerInfo = info;
                                [self save];
                                block(parcel, updated);
                            }];
}

- (void)updateAllTrackerInfo
{
    for (UPParcel *parcel in self.parcels) {
        [self updateTrackerInfoForParcel:parcel completionBlock:^(UPParcel *parcel, BOOL updated) {
            
        }];
    }
}

#pragma mark - Notifications

- (void)presentNotificationForParcel:(UPParcel *)parcel operation:(UPParcelTrackerOperation *)operation
{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertTitle = [NSString stringWithFormat:@"%@ - %@", parcel.name, parcel.parcelID, nil];
    notification.alertBody = [NSString stringWithFormat:@"%@ - %@ - %@",
                              operation.date,
                              operation.postOfficeName,
                              operation.operationDescription, nil];
    notification.applicationIconBadgeNumber = self.numberOfUpdatedParcels;
    notification.fireDate = [NSDate date];
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

- (NSUInteger)numberOfUpdatedParcels
{
    return self.updatedParcels.count;
}

- (void)resetUpdatedParcels
{
    self.updatedParcels = [@[] mutableCopy];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

#pragma mark - Save / Load

- (void)save
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [data writeToFile:[self.class parcelListPath] atomically:YES];
}

+ (UPParcelList *)loadParcelList
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self.class parcelListPath]];
}

+ (NSString *)parcelListPath
{
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return [documentsPath stringByAppendingPathComponent:@"parcel.list"];
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.parcelList = [aDecoder decodeObjectForKey:kUPParcelListParcelsKey];
        self.updatedParcels = [aDecoder decodeObjectForKey:kUPParcelListUpdatedParcelsKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.parcelList forKey:kUPParcelListParcelsKey];
    [aCoder encodeObject:self.updatedParcels forKey:kUPParcelListUpdatedParcelsKey];
}

@end
