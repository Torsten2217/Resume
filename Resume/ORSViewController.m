//
//  ORSViewController.m
//  Resume
//
//  Created by OkSeJu on 1/21/15.
//  Copyright (c) 2015 com.fsoft.Resume. All rights reserved.
//

#import "ORSViewController.h"

@interface ORSViewController ()

@end

@implementation ORSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *tmp = [self convertStringToTitle:_receiveString];
    [_returnButton setTitle:tmp forState:UIControlStateNormal];
    self.file_handle = [[FileHandle alloc] init];
    [self displayContents:self.thisFile];
    _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
    _tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:_tapRecognizer];
}

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if ([sender isEqual:_contents])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (void) didTapAnywhere:(UITapGestureRecognizer*)sender{
    [self.view endEditing:YES];
}

- (BOOL) prefersStatusBarHidden{
    return YES;
}

- (id)convertStringToTitle:(NSString *)givenText{
    NSString *fname;
    if( [givenText isEqualToString:@"Objectives"]){
        fname = @" <          Objectives";
        self.thisFile = @"objectives.txt";
    }
    else if ([givenText isEqualToString:@"Skills"]){
        fname = @" <            Skills";
        self.thisFile = @"skills.txt";
    }
    else{
        fname = @" <          References";
        self.thisFile = @"references.txt";
    }
    return fname;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)displayContents:(NSString *) filename{
    NSArray *objectives = [self.file_handle getContents:filename];
    _contents.text = @"";
    for( NSString * each in objectives){
        if (![each isEqualToString:@""]) {
            _contents.text = [_contents.text stringByAppendingString:each];
            _contents.text = [_contents.text stringByAppendingString:@"\n"];
        }
    }
}

- (void)finalWrite:(NSString *)filename{
    NSArray *rows = [_contents.text componentsSeparatedByString:@"\n"];
    if ([rows count] > 0 && ![[rows objectAtIndex:0]  isEqual: @""] ) {
        [self.file_handle setContents:filename strings:rows];
    }
}

- (IBAction)returnClicked:(id)sender {
    [self finalWrite:_thisFile];
    [self dismissViewControllerAnimated:true completion:nil];
    //[self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"EditResume"] animated:YES completion:nil];
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