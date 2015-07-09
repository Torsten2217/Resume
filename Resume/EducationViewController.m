//
//  EducationViewController.m
//  Resume
//
//  Created by OkSeJu on 1/21/15.
//  Copyright (c) 2015 com.fsoft.Resume. All rights reserved.
//

#import "EducationViewController.h"

@interface EducationViewController ()

@end

int panelCount;//object count
NSMutableArray *subPanels;//panel objects
NSMutableArray *rows;// content's rows count
NSMutableArray *strArray;//real strings
NSUInteger selectRowNumber;

@implementation EducationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.file_handle = [[FileHandle alloc] init];
    rows = [[NSMutableArray alloc] init];
    strArray = [[NSMutableArray alloc] init];
    selectRowNumber = 0;
    panelCount = [self getPanelsCount:@"education.txt"];
    _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
    _tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:_tapRecognizer];
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
    if  (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
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

- (NSArray *)calcOnePanel:(NSString *)strval {
    NSArray *marr = [self getComponents:strval];
    return marr;
}

-(NSArray *)getComponents:(NSString *)orig{
    NSArray *temp = [orig componentsSeparatedByString:@"\n"];
    NSString *t1 = @"", *t2 = @"", *t3 = @"";
    int rep = 0;
    for( NSString *each in temp){
        if( ![each isEqualToString:@""]){
            if( rep == 0){
                t1 = each;
            }
            else if (rep == 1){
                t2 = each;
            }
            else{
                if(rep > 1){
                    t3 = [t3 stringByAppendingString:each];
                    t3= [t3 stringByAppendingString:@"\n"];
                }
            }
        }
        rep++;
    }
    //t3 = [t3 substringToIndex:t3.length - 2];
    NSArray *ret = [[NSArray alloc] initWithObjects:t1, t2, t3, nil];
    return ret;
}

- (int)getPanelsCount:(NSString*)filename{
    NSArray *educations  = [[self file_handle] getContents:filename];//all sum
    NSString *prefix = @"", *suffix = @"";
    BOOL on = false;
    int cnt = 0;
    int loop = 0;
    for( NSString * each in educations){
        //        if (![each isEqualToString:@""]) {
        if([each hasPrefix:@"-"]){
            suffix = [suffix stringByAppendingString:[each substringFromIndex:1]];
            suffix = [suffix stringByAppendingString:@"\n"];
            cnt++;
            on = true;
        }
        else{
            if( on ){
                //prefix = [prefix substringFromIndex:3];
                prefix = [prefix stringByAppendingString:suffix];
                [strArray addObject:prefix];
                [rows addObject:[NSNumber numberWithInteger:cnt]];
                prefix = @"";
                suffix = @"";
                cnt = 0;
                on = false;
                loop++;
            }
            if(![each isEqualToString:@""] && ![each isEqualToString:@"##"]) {
                prefix = [prefix stringByAppendingString:each];
                prefix = [prefix stringByAppendingString:@"\n"];
            }
        }
        //        }
    }
    return loop;
}

- (IBAction)deleteClicked:(id)sender {
    if ( [strArray count] == 1 ) {
        return;
    }
    else{
        [strArray removeObjectAtIndex:selectRowNumber];
        [rows removeObjectAtIndex:selectRowNumber];
        selectRowNumber--;
        [_dataShowTView reloadData];
    }
}

- (IBAction)addClicked:(id)sender {
    NSString *add = @"2015.10 - \nNew York University\nPhysics faculty\nEconomics institute\n";
    [strArray addObject:add];
    [rows addObject:[NSNumber numberWithInteger:2]];
    [_dataShowTView reloadData];
}

- (IBAction)returnClicked:(id)sender {
    [self finalWrite:@"education.txt"];
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *) makeMinusAdd:(NSString *)orig {
    NSArray *temp = [orig componentsSeparatedByString:@"\n"];
    NSString *total = @"";
    for ( NSString *each in temp ) {
        total = [total stringByAppendingString:@"-"];
        total = [total stringByAppendingString:each];
        total = [total stringByAppendingString:@"\n"];
    }
    //    total = [total substringToIndex:[total length] - 3];
    return total;
}

- (void)finalWrite:(NSString *)filename{
    NSString *total = @"";
    for (int i = 0; i < [_dataShowTView numberOfRowsInSection:0]; i++) {
        total = [total stringByAppendingString:@"##\n"];
        NSIndexPath *rowpath = [NSIndexPath indexPathForRow:i inSection:0];
        SimpleTableCell *cell = (SimpleTableCell *)[_dataShowTView cellForRowAtIndexPath:rowpath];
        total = [total stringByAppendingString:[[cell period] text]];
        total = [total stringByAppendingString:@"\n"];
        total = [total stringByAppendingString:[[cell title1] text]];
        total = [total stringByAppendingString:@"\n"];
        total = [total stringByAppendingString:[self makeMinusAdd:[[cell content] text]]];
        if (![total hasSuffix:@"\n"]) {
            total = [total stringByAppendingString:@"\n"];
        }
    }
    total = [total substringToIndex:[total length] - 1];
    NSArray *input = [total componentsSeparatedByString:@"\n"];
    [self.file_handle setContents:filename strings:input];
}

#pragma mark - Table view datasource and delegate methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    // Number of sections is the number of regions
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [strArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectRowNumber = [indexPath row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"SimpleTableCell";
    SimpleTableCell *cell = (SimpleTableCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSArray *vlist = [self calcOnePanel:[strArray objectAtIndex:indexPath.row]];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SimpleTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.period.text = [vlist objectAtIndex:0];
    cell.title1.text = [vlist objectAtIndex:1];
    cell.content.text = [vlist objectAtIndex:2];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50 + [[rows objectAtIndex:indexPath.row] integerValue] * 20;
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