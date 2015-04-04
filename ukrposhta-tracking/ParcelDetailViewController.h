//
//  DetailViewController.h
//  ukrposhta-tracking
//
//  Created by Tolik on 4/4/15.
//  Copyright (c) 2015 Tolik Shevchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UPParcel;

@interface ParcelDetailViewController : UIViewController

@property (strong, nonatomic) UPParcel *parcel;

@end

