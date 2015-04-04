//
//  UPParcelTrackerInfo.h
//  ukrposhta-tracking
//
//  Created by Tolik on 4/4/15.
//  Copyright (c) 2015 Tolik Shevchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UPParcelTrackerInfo : NSObject< NSCoding >

- (instancetype)initWithOperationsXMLArray:(NSArray *)XMLArray NS_DESIGNATED_INITIALIZER;
@property (strong, nonatomic) NSArray *operations;//an array of UPParcelTrackerOperation instances

@end
