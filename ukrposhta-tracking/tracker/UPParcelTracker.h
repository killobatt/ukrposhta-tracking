//
//  UPParcelTracker.h
//  ukrposhta-tracking
//
//  Created by Tolik on 4/4/15.
//  Copyright (c) 2015 Tolik Shevchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UPParcelTrackerInfo.h"

@interface UPParcelTracker : NSObject
+ (void)trackerInfoForParcelID:(NSString *)parcelID completionBlock:(void (^)(NSString *parcelID, UPParcelTrackerInfo *info))block;
@end
