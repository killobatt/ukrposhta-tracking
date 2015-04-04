//
//  UPParcelTrackerInfo.m
//  ukrposhta-tracking
//
//  Created by Tolik on 4/4/15.
//  Copyright (c) 2015 Tolik Shevchenko. All rights reserved.
//

#import "UPParcelTrackerInfo.h"
#import "UPParcelTrackerOperation.h"

static NSString * const kUPParcelTrackerInfoOperationsKey = @"operations";

@interface UPParcelTrackerInfo ()
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
@end

@implementation UPParcelTrackerInfo

- (instancetype)initWithOperationsXMLArray:(NSArray *)XMLArray
{
    if (0 == XMLArray.count)
    {
        return nil;
    }
    
    self = [super init];
    if (self)
    {
        NSMutableArray *operations = [[NSMutableArray alloc] initWithCapacity:XMLArray.count];
        for (NSDictionary *node in XMLArray)
        {
            UPParcelTrackerOperation *trackerOperation = [[UPParcelTrackerOperation alloc] initWithOperationXMLDictionary:node];
            if (nil != trackerOperation)
            {
                [operations addObject:trackerOperation];
            }
        }
        _operations = [operations copy];
    }
    return self;
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
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
