//
//  BuyViewController.m
//  Resume
//
//  Created by OkSeJu on 2/8/15.
//  Copyright (c) 2015 com.fsoft.Resume. All rights reserved.
//

#import "BuyViewController.h"
#import "SixTemplatesViewController.h"

@interface BuyViewController ()

@end

@implementation BuyViewController

@synthesize productID = _productID;
BOOL nextOk;
@synthesize templateID = _templateID;

- (void)viewDidLoad {
    [super viewDidLoad];
    _validProducts = [[NSMutableArray alloc] init];
    [self fetchAvailableProducts];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:_productID];
    [[NSUserDefaults standardUserDefaults] synchronize];
    nextOk = FALSE;
    if ([[NSUserDefaults standardUserDefaults] boolForKey:_productID]) {
        [self.buyButton setTitle:@"Next" forState:UIControlStateNormal];
        nextOk = TRUE;
    }
}

- (void) fetchAvailableProducts{
    NSSet *productIdentifiers = [NSSet setWithObjects:_productID, nil];
    _productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
    _productsRequest.delegate = self;
    [_productsRequest start];
}

- (BOOL)canMakePurchases{
    return [SKPaymentQueue canMakePayments];
}

- (void) purchaseMyProduct:(SKProduct *)product{
    if([self canMakePurchases]){
        SKPayment *payment = [SKPayment paymentWithProduct:product]
        ;
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Purchase are disable in your device" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (IBAction) cancelClicked:(id)sender{
    //[self dismissViewControllerAnimated:true completion:nil];
    [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"EditResume"] animated:YES completion:nil];
}

- (IBAction)clickBuy:(id)sender {
    if (nextOk == TRUE) {
        SixTemplatesViewController *target = [self.storyboard instantiateViewControllerWithIdentifier:@"SixTemplates"];
        target.templateID = _templateID;
        [self presentViewController:target animated:YES completion:nil];
    }
    else{
        [self purchaseMyProduct:[_validProducts objectAtIndex:0]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark StoreKit Delegate
-(void) paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
    for (SKPaymentTransaction *transaction in transactions ){
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"Purchasing");
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStatePurchased:
                if ([transaction.payment.productIdentifier isEqualToString:_productID]) {
                    NSLog(@"Purchased");
                    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                    nextOk = TRUE;
                    [self.buyButton setTitle:@"Next" forState:UIControlStateNormal];
                }
                break;
            default:
                nextOk = FALSE;
                break;
        }
    }
}

- (void) productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    SKProduct *validProduct = nil;
    int count = [response.products count];
    if( count > 0 ){
        _validProducts = response.products;
        validProduct = [response.products objectAtIndex:0];
        if ([validProduct.productIdentifier isEqualToString:_productID]) {
            [_productIDField setText:[NSString stringWithFormat:@"%@", validProduct.localizedTitle]];
            [_DescriptionField setText:[NSString stringWithFormat:@"%@",validProduct.localizedDescription]];
            [_priceField setText:[NSString stringWithFormat:@"%@", validProduct.price]];
        }
        else{
            UIAlertView *tmp = [[UIAlertView alloc] initWithTitle:@"Not Available" message:@"No products to purchase" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [tmp show];
        }
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
