//
//  PersionalInfoViewController.m
//  Resume
//
//  Created by OkSeJu on 1/21/15.
//  Copyright (c) 2015 com.fsoft.Resume. All rights reserved.
//

#import "PersionalInfoViewController.h"

@interface PersionalInfoViewController ()

@end

@implementation PersionalInfoViewController

NSString *filename = @"persionalinfo.txt";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.file_handle = [[FileHandle alloc] init];
    [self displayContents:filename];
    _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
    _tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:_tapRecognizer];
}

- (void) didTapAnywhere:(UITapGestureRecognizer*)sender{
    [self.view endEditing:YES];
}

- (BOOL) prefersStatusBarHidden{
    return YES;
}

- (void)displayContents:(NSString *)filename{
    NSArray *infomations = [self.file_handle getContents:filename];
    _nameText.text = [infomations objectAtIndex:0];
    _emailText.text = [infomations objectAtIndex:1];
    _phoneNumber.text = [infomations objectAtIndex:2];
    _addressText.text = [infomations objectAtIndex:3];
}

-(BOOL)isReadyToSend{
    BOOL readyToSend = TRUE;
    if( ![_nameText.text isEqual:@""] && ![_emailText.text isEqual:@""] && ![_phoneNumber.text isEqual:@""] && ![_addressText.text isEqual:@""]){
        readyToSend = TRUE;
    }
    else
        readyToSend = FALSE;
    return readyToSend;
}

- (void)finalWrite:(NSString *)filename{
    NSArray *rows = [[NSArray alloc] initWithObjects:_nameText.text, _emailText.text, _phoneNumber.text, _addressText.text, nil];
    [self.file_handle setContents:filename strings:rows];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self dismissViewControllerAnimated:true completion:nil];
    }
}

- (IBAction)returnClicked:(id)sender {
    if([self isReadyToSend]){
        [self finalWrite:filename];
        [self dismissViewControllerAnimated:true completion:nil];
    }
    else{
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"Write Alert!" message:@"what is written isn't correct.\nMust fill total 4 lines. Continue?" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"yes", nil];
        [al show];
        //[al autorelease];
    }
}
    //[self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"EditResume"] animated:YES completion:nil];
- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     // Dispose of any resources that can be recreated.
}
    
@end
