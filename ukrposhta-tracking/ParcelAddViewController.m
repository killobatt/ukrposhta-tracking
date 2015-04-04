//
//  ParcelAddViewController.m
//  ukrposhta-tracking
//
//  Created by Vjacheslav Volodjko on 04.04.15.
//  Copyright (c) 2015 Tolik Shevchenko. All rights reserved.
//

#import "ParcelAddViewController.h"
#import "UPParcels.h"

@interface ParcelAddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *parcelNameField;
@property (weak, nonatomic) IBOutlet UITextField *parcelIDField;

@end

@implementation ParcelAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"unwind"]) {
        UPParcel *parcel = [UPParcel new];
        parcel.name = self.parcelNameField.text;
        parcel.parcelID = self.parcelIDField.text;
        [[UPParcelList sharedInstance] addParcel:parcel];
    }
}

@end
