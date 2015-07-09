//
//  Template1ViewController.h
//  Resume
//
//  Created by OkSeJu on 2/8/15.
//  Copyright (c) 2015 com.fsoft.Resume. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileHandle.h"
#import <MessageUI/MessageUI.h>

@interface Template1ViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextView *objectivesTextView;
@property (strong, nonatomic) IBOutlet UITextView *skillTextView;
@property (strong, nonatomic) IBOutlet UITextView *educationTextView;
@property (strong, nonatomic) IBOutlet UITextView *workExperienceTextView;
@property (strong, nonatomic) IBOutlet UITextView *referencesTextView;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *phonenumber;
@property (strong, nonatomic) IBOutlet UITextField *address;

@property (strong, nonatomic) FileHandle *file_handle;

- (IBAction)cancelButtonClicked:(id)sender;
- (IBAction)doneButtonClicked:(id)sender;

@end
