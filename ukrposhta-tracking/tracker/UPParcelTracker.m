//
//  UPParcelTracker.m
//  ukrposhta-tracking
//
//  Created by Tolik on 4/4/15.
//  Copyright (c) 2015 Tolik Shevchenko. All rights reserved.
//

#import "UPParcelTracker.h"
#import "XPathQuery.h"

@implementation UPParcelTracker

+ (void)trackerInfoForParcelID:(NSString *)parcelID completionBlock:(void (^)(NSString *parcelID, UPParcelTrackerInfo *info))block;
{
    NSURL *url = [self URLWithBase:@"services.ukrposhta.com/barcodestatistic/barcodestatistic.asmx/GetBarcodeInfo"
                        parameters:@{@"guid": @"fcc8d9e1-b6f9-438f-9ac8-b67ab44391dd",
                                     @"culture": @"uk",
                                     @"barcode": parcelID}];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url
                                                             completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                                 
                                                                 NSArray *parsedXMLArray = PerformXMLXPathQuery(data, @"/");
                                                                 NSLog(@"Received XML data:%@", parsedXMLArray);
                                                                 
                                                                 UPParcelTrackerInfo *info = [[UPParcelTrackerInfo alloc] init];
                                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                                     block(parcelID, info);
                                                                 });
                                                             }
                                  ];
    [task resume];
}

+ (NSURL*)URLWithBase:(NSString *)baseURLString parameters:(NSDictionary *)parameters
{
    NSString *result = [NSString stringWithFormat:@"http://%@?", baseURLString];
    
    for (NSString *key in parameters.allKeys)
    {
        result = [result stringByAppendingFormat:@"%@=%@&", key, [parameters objectForKey:key]];
    }
    
    result = [result substringToIndex:[result length] - 1];
    result = [result stringByAddingPercentEscapesUsingEncoding:NSUnicodeStringEncoding];
    return [NSURL URLWithString:result];
}

@end

