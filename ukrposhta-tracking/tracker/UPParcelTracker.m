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
                                                                 
                                                                 NSArray *operationsXMLArray = nil;
                                                                 if (nil == error)
                                                                 {
                                                                     NSArray *parsedXMLArray = PerformXMLXPathQuery(data, @"/");
                                                                     NSLog(@"Received XML data:%@", parsedXMLArray);
                                                                     
                                                                     if (parsedXMLArray.count > 0 && [parsedXMLArray[0] isKindOfClass:[NSDictionary class]])
                                                                     {
                                                                         operationsXMLArray = [parsedXMLArray[0] objectForKey:@"nodeChildArray"];
                                                                     }
                                                                     else
                                                                     {
                                                                         NSLog(@"Wrong parsedXMLArray structure:%@", parsedXMLArray);
                                                                     }
                                                                 }
                                                                 else
                                                                 {
                                                                     NSLog(@"Error has been received:%@", error);
                                                                 }
                                                                 
                                                                 UPParcelTrackerInfo *info = [[UPParcelTrackerInfo alloc] initWithOperationsXMLArray:operationsXMLArray];
                                                                 
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

