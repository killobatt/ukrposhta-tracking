//
//  UPParcelTrackerInfo.m
//  ukrposhta-tracking
//
//  Created by Tolik on 4/4/15.
//  Copyright (c) 2015 Tolik Shevchenko. All rights reserved.
//

#import "UPParcelTrackerInfo.h"

static NSString * const kUPParcelTrackerInfoOperationsKey = @"operations";

@implementation UPParcelTrackerInfo

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.operations = [aDecoder decodeObjectForKey:kUPParcelTrackerInfoOperationsKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.operations forKey:kUPParcelTrackerInfoOperationsKey];
}

@end
