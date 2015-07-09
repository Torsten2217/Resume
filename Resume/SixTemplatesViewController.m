//
//  SixTemplatesViewController.m
//  Resume
//
//  Created by OkSeJu on 2/10/15.
//  Copyright (c) 2015 com.fsoft.Resume. All rights reserved.
//

#import "SixTemplatesViewController.h"
#import "SendResultViewController.h"

@interface SixTemplatesViewController ()

@end

@implementation SixTemplatesViewController
@synthesize templateID = _templateID;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) initTemplate1{
    ;
}
- (IBAction)cancelButtonClicked:(id)sender{
    [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"EditResume"] animated:YES completion:nil];
}

- (IBAction)doneButtonClicked:(id)sender{
    SendResultViewController *target = [self.storyboard instantiateViewControllerWithIdentifier:@"ChooseTemplate"];
    [self presentViewController:target animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
