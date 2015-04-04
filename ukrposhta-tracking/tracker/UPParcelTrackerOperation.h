//
//  UPParcelTrackerOperation.h
//  ukrposhta-tracking
//
//  Created by Vjacheslav Volodjko on 04.04.15.
//  Copyright (c) 2015 Tolik Shevchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UPParcelTrackerOperation : NSObject< NSCoding >

@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSNumber *eventID;
@property (strong, nonatomic) NSString *postOfficeIndex;
@property (strong, nonatomic) NSString *postOfficeName;
@property (strong, nonatomic) NSString *operationDescription;

@end
