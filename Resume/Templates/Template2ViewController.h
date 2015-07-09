//
//  Template2ViewController.h
//  Resume
//
//  Created by OkSeJu on 2/8/15.
//  Copyright (c) 2015 com.fsoft.Resume. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface Template2ViewController : UIViewController <UIScrollViewDelegate, MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *phonenumber;
@property (strong, nonatomic) IBOutlet UITextField *address;
@property (strong, nonatomic) IBOutlet UITextView *objectives;
@property (strong, nonatomic) IBOutlet UITextView *skills;
@property (strong, nonatomic) IBOutlet UITextView *references;
@property (strong, nonatomic) IBOutlet UITextView *workexperiences;
@property (strong, nonatomic) IBOutlet UITextView *education;
@property (strong, nonatomic) IBOutlet UIScrollView *myScroll;

@property (strong, nonatomic) FileHandle *file_handle;
- (IBAction)cancelButtonClicked:(id)sender;
- (IBAction)doneButtonClicked:(id)sender;

@end
