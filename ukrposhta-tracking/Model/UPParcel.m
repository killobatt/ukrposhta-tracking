//
//  Parcel.m
//  ukrposhta-tracking
//
//  Created by Vjacheslav Volodjko on 04.04.15.
//  Copyright (c) 2015 Tolik Shevchenko. All rights reserved.
//

#import "UPParcel.h"

static NSString * const kUPParcelNameKey = @"name";
static NSString * const kUPParcelIDKey = @"id";
static NSString * const kUPParcelTrackerInfoKey = @"tracker-info";

@implementation UPParcel

- (BOOL)isEqual:(UPParcel *)object
{
    return [self.parcelID isEqual:object.parcelID];
}

- (NSUInteger)hash
{
    return [self.parcelID hash];
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:kUPParcelNameKey];
        self.parcelID = [aDecoder decodeObjectForKey:kUPParcelIDKey];
        self.trackerInfo = [aDecoder decodeObjectForKey:kUPParcelTrackerInfoKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:kUPParcelNameKey];
    [aCoder encodeObject:self.parcelID forKey:kUPParcelIDKey];
    [aCoder encodeObject:self.trackerInfo forKey:kUPParcelTrackerInfoKey];
}

@end
