//
//  BuyViewController.h
//  Resume
//
//  Created by OkSeJu on 2/8/15.
//  Copyright (c) 2015 com.fsoft.Resume. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface BuyViewController : UIViewController <SKProductsRequestDelegate, SKPaymentTransactionObserver>

@property (strong, nonatomic) SKProductsRequest *productsRequest;
@property (strong, nonatomic) NSArray *validProducts;
@property (strong, nonatomic) IBOutlet UITextField *productIDField;
@property (strong, nonatomic) IBOutlet UITextField *DescriptionField;
@property (strong, nonatomic) IBOutlet UITextField *priceField;
@property (strong, nonatomic) IBOutlet UIButton *buyButton;
@property (strong, nonatomic) NSString *productID;
@property NSInteger templateID;
- (IBAction) cancelClicked:(id)sender;
- (IBAction) clickBuy:(id)sender;
- (void) fetchAvailableProducts;
- (BOOL) canMakePurchases;
- (void) purchaseMyProduct:(SKProduct *)product;

@end
