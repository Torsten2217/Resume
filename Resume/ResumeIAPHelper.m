//
//  ResumeIAPHelper.m
//  BuyResume
//
//  Created by Michael Beyer on 16.09.13.
//  Copyright (c) 2013 Michael Beyer. All rights reserved.
//

#import "ResumeIAPHelper.h"

static NSString *kIdentifierResumeTemplate1       = @"com.fsoft.Resume.Tempalte1";
static NSString *kIdentifierResumeTemplate2       = @"com.fsoft.Resume.Tempalte2";
static NSString *kIdentifierResumeTemplate3       = @"com.fsoft.Resume.Tempalte3";
static NSString *kIdentifierResumeTemplate4       = @"com.fsoft.Resume.Tempalte4";
static NSString *kIdentifierResumeTemplate5       = @"com.fsoft.Resume.Tempalte5";
static NSString *kIdentifierResumeTemplate6       = @"com.fsoft.Resume.Tempalte6";

@implementation ResumeIAPHelper

// Obj-C Singleton pattern
+ (ResumeIAPHelper *)sharedInstance {
    static ResumeIAPHelper *sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        NSSet *productIdentifiers = [NSSet setWithObjects:
                                     kIdentifierResumeTemplate1,
                                     kIdentifierResumeTemplate2,
                                     kIdentifierResumeTemplate3,
                                     kIdentifierResumeTemplate4,
                                     kIdentifierResumeTemplate5,
                                     kIdentifierResumeTemplate6,
                                     nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    return sharedInstance;
}

- (NSString *)imageNameForProduct:(SKProduct *)product
{
    if ([product.productIdentifier isEqualToString:kIdentifierResumeTemplate1]) {
        return @"ResumeTemplate1";
    }
    if ([product.productIdentifier isEqualToString:kIdentifierResumeTemplate2]) {
        return @"ResumeTemplate2";
    }
    if ([product.productIdentifier isEqualToString:kIdentifierResumeTemplate3]) {
        return @"ResumeTemplate3";
    }
    if ([product.productIdentifier isEqualToString:kIdentifierResumeTemplate4]) {
        return @"ResumeTemplate4";
    }
    if ([product.productIdentifier isEqualToString:kIdentifierResumeTemplate5]) {
        return @"ResumeTemplate5";
    }
    if ([product.productIdentifier isEqualToString:kIdentifierResumeTemplate6]) {
        return @"ResumeTemplate6";
    }
    return nil;
}

- (NSString *)descriptionForProduct:(SKProduct *)product
{
    
    if ([product.productIdentifier isEqualToString:kIdentifierResumeTemplate1]) {
        return product.localizedDescription;
    }
    if ([product.productIdentifier isEqualToString:kIdentifierResumeTemplate2]) {
        return product.localizedDescription;
    }
    if ([product.productIdentifier isEqualToString:kIdentifierResumeTemplate3]) {
        return product.localizedDescription;
    }
    if ([product.productIdentifier isEqualToString:kIdentifierResumeTemplate4]) {
        return product.localizedDescription;
    }
    if ([product.productIdentifier isEqualToString:kIdentifierResumeTemplate5]) {
        return product.localizedDescription;
    }
    if ([product.productIdentifier isEqualToString:kIdentifierResumeTemplate6]) {
        return product.localizedDescription;
    }
    return nil;
}

@end
