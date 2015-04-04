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

@interface UPParcelTrackerOperation ()
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
@end

@implementation UPParcelTrackerOperation

+ (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"dd.MM.yyyy";
    });
    
    return dateFormatter;
}

- (instancetype)initWithOperationXMLDictionary:(NSDictionary *)XMLDictionary
{
    if (nil == XMLDictionary || ![XMLDictionary isKindOfClass:[NSDictionary class]] || ![XMLDictionary[@"nodeName"] isEqualToString:@"BarcodeInfoService"])
    {
        return nil;
    }
    
    NSArray *operationFields = XMLDictionary[@"nodeChildArray"];
    if (0 == operationFields.count)
    {
        return nil;
    }
    
    self = [super init];
    if (self)
    {
        _eventID = @([operationFields[1][@"nodeContent"] integerValue]);
        _postOfficeIndex = @([operationFields[2][@"nodeContent"] integerValue]);
        _date = [[UPParcelTrackerOperation dateFormatter] dateFromString:operationFields[3][@"nodeContent"]];
        _postOfficeName = operationFields[4][@"nodeContent"];
        _operationDescription = operationFields[5][@"nodeContent"];
    }
    return self;
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
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
