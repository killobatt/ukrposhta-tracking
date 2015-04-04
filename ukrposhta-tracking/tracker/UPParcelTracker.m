//
//  UPParcelTracker.m
//  ukrposhta-tracking
//
//  Created by Tolik on 4/4/15.
//  Copyright (c) 2015 Tolik Shevchenko. All rights reserved.
//

#import "UPParcelTracker.h"

@implementation UPParcelTracker

+ (void)trackerInfoForParcelID:(NSString *)parcelID completionBlock:(void (^)(NSString *parcelID, UPParcelTrackerInfo *info))block;
{
    NSURL *url = [self URLWithBase:@"services.ukrposhta.com/barcodestatistic/barcodestatistic.asmx"
                        parameters:@{@"op": parcelID}];
    
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url
                                                             completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                                 NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                                 
                                                                 NSLog(@"Received data:%@", jsonDictionary);
                                                                 
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

