//
//  ChooseTemplateViewController.m
//  Resume
//
//  Created by OkSeJu on 2/4/15.
//  Copyright (c) 2015 com.fsoft.Resume. All rights reserved.
//

#import "ChooseTemplateViewController.h"
#import "BuyViewController.h"

#import "Template1ViewController.h"
#import "Template2ViewController.h"
#import "Template3ViewController.h"
#import "Template4ViewController.h"
#import "Template5ViewController.h"
#import "Template6ViewController.h"

@interface ChooseTemplateViewController ()
@property (nonatomic, readonly) UIView *view;
@end

@implementation ChooseTemplateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *myTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureTapEvent:)];
    UITapGestureRecognizer *myTapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureTapEvent:)];
    UITapGestureRecognizer *myTapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureTapEvent:)];
    UITapGestureRecognizer *myTapGesture3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureTapEvent:)];
    UITapGestureRecognizer *myTapGesture4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureTapEvent:)];
    UITapGestureRecognizer *myTapGesture5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureTapEvent:)];
    _templateImage1.userInteractionEnabled = YES;
    [_templateImage1 addGestureRecognizer:myTapGesture];
    _templateImage2.userInteractionEnabled = YES;
    [_templateImage2 addGestureRecognizer:myTapGesture1];
    _templateImage3.userInteractionEnabled = YES;
    [_templateImage3 addGestureRecognizer:myTapGesture2];
    _templateImage4.userInteractionEnabled = YES;
    [_templateImage4 addGestureRecognizer:myTapGesture3];
    _templateImage5.userInteractionEnabled = YES;
    [_templateImage5 addGestureRecognizer:myTapGesture4];
    _templateImage6.userInteractionEnabled = YES;
    [_templateImage6 addGestureRecognizer:myTapGesture5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)cancel:(id)sender{
    [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"EditResume"] animated:YES completion:nil];
}

- (void) gestureTapEvent:(UITapGestureRecognizer *)gesture{
   UIImageView *myImageView = (UIImageView *)gesture.view;
/*     NSInteger index = myImageView.tag;
    if( index == 0){
        Template1ViewController *target = [[Template1ViewController alloc] initWithNibName:@"Template1ViewController" bundle:nil];
            [self presentViewController:target animated:YES completion:nil];
    }
    else if (index == 1){
            Template2ViewController *target = [[Template2ViewController alloc] initWithNibName:@"Template2ViewController" bundle:nil];
            [self presentViewController:target animated:YES completion:nil];
    }
    else if (index == 2){
        Template3ViewController *target = [[Template3ViewController alloc] initWithNibName:@"Template3ViewController" bundle:nil];
        [self presentViewController:target animated:YES completion:nil];
    }
    else if (index == 3){
        Template4ViewController *target = [[Template4ViewController alloc] initWithNibName:@"Template4ViewController" bundle:nil];
        [self presentViewController:target animated:YES completion:nil];
    }
    else if (index == 4){
        Template5ViewController *target = [[Template5ViewController alloc] initWithNibName:@"Template5ViewController" bundle:nil];
        [self presentViewController:target animated:YES completion:nil];
    }
    if (index ==5){
        Template6ViewController *target = [[Template6ViewController alloc] initWithNibName:@"Template6ViewController" bundle:nil];
        [self presentViewController:target animated:YES completion:nil];
    }
*/
    BuyViewController *target = [self.storyboard instantiateViewControllerWithIdentifier:@"BuyControll"];
    target.templateID = myImageView.tag;
    [self presentViewController:target animated:YES completion:nil];
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
