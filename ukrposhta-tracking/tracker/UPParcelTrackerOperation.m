//
//  UPParcelTrackerOperation.m
//  ukrposhta-tracking
//
//  Created by Vjacheslav Volodjko on 04.04.15.
//  Copyright (c) 2015 Tolik Shevchenko. All rights reserved.
//

#import "UPParcelTrackerOperation.h"

static NSString * const kUPOperationPostOfficeKey = @"postOfficeName";
static NSString * const kUPOperationPostIndexKey = @"postOfficeIndex";
static NSString * const kUPOperationDateKey = @"date";
static NSString * const kUPOperationEventIDKey = @"eventID";
static NSString * const kUPOperationOperationDescriptionKey = @"description";

@implementation UPParcelTrackerOperation

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.postOfficeName = [aDecoder decodeObjectForKey:kUPOperationPostOfficeKey];
        self.postOfficeIndex = [aDecoder decodeObjectForKey:kUPOperationPostIndexKey];
        self.date = [aDecoder decodeObjectForKey:kUPOperationDateKey];
        self.eventID = [aDecoder decodeObjectForKey:kUPOperationEventIDKey];
        self.operationDescription = [aDecoder decodeObjectForKey:kUPOperationOperationDescriptionKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.postOfficeName forKey:kUPOperationPostOfficeKey];
    [aCoder encodeObject:self.postOfficeIndex forKey:kUPOperationPostIndexKey];
    [aCoder encodeObject:self.date forKey:kUPOperationDateKey];
    [aCoder encodeObject:self.eventID forKey:kUPOperationEventIDKey];
    [aCoder encodeObject:self.operationDescription forKey:kUPOperationOperationDescriptionKey];
}

@end
