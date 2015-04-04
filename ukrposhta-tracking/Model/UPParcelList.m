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

static NSString * const kUPParcelListParcelsKey = @"parcels";

@interface UPParcelList ()
@property (strong, nonatomic) NSMutableArray *parcelList;
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
    [self.parcelList addObject:parcel];
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

- (void)updateTrackerInfoForParcel:(UPParcel *)parcel completionBlock:(void (^)(UPParcel *))block
{
    [UPParcelTracker trackerInfoForParcelID:parcel.parcelID
                            completionBlock:^(NSString *parcelID, UPParcelTrackerInfo *info) {
                                UPParcel *parcel = [self parcelWithParcelID:parcelID];
                                parcel.trackerInfo = info;
                                [self save];
                            }];
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
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.parcelList forKey:kUPParcelListParcelsKey];
}

@end
