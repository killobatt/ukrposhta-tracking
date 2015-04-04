//
//  UPParcelTrackerTests.m
//  ukrposhta-tracking
//
//  Created by Tolik on 4/4/15.
//  Copyright (c) 2015 Tolik Shevchenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "UPParcelTracker.h"

@interface UPParcelTrackerTests : XCTestCase

@end

@implementation UPParcelTrackerTests

- (void)testTracking
{
    XCTestExpectation *completionExpectation = [self expectationWithDescription:@"completionBlock is expected to be called"];
    NSString *expectedParcelID = @"RR739685186PL";
    
    [UPParcelTracker trackerInfoForParcelID:expectedParcelID completionBlock:^(NSString *parcelID, UPParcelTrackerInfo *info) {
        [completionExpectation fulfill];
        
        XCTAssertEqualObjects(expectedParcelID, parcelID);
        XCTAssertNotNil(info);
    }];
    
    [self waitForExpectationsWithTimeout:2.0 handler:nil];
}

@end
