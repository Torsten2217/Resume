//
//  ResumeIAPHelper.h
//  BuyResume
//
//  Created by Michael Beyer on 16.09.13.
//  Copyright (c) 2013 Michael Beyer. All rights reserved.
//

#import "IAPHelper.h"

@interface ResumeIAPHelper : IAPHelper

+ (ResumeIAPHelper *)sharedInstance;

- (NSString *)imageNameForProduct:(SKProduct *)product;
- (NSString *)descriptionForProduct:(SKProduct *)product;

@end
