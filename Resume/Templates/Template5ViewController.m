//
//  Template5ViewController.m
//  Resume
//
//  Created by OkSeJu on 2/8/15.
//  Copyright (c) 2015 com.fsoft.Resume. All rights reserved.
//

#import "Template5ViewController.h"
#import "EditResumeViewController.h"

@interface Template5ViewController ()

@end

@implementation Template5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.file_handle = [[FileHandle alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButtonClicked:(id)sender{
    EditResumeViewController *editResume = [[EditResumeViewController alloc] initWithNibName:@"EditResume" bundle:nil];
    [self.navigationController pushViewController:editResume animated:YES];
}

- (IBAction)doneButtonClicked:(id)sender{//
    NSString *pdfFile = [self.file_handle createPDF:@"resume" withView:self.view];
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        NSArray *toRecipents = [NSArray arrayWithObject:@"order@careerdx.com"];
        [mailer setToRecipients:[toRecipents objectAtIndex:0]];
        //[mailer setToRecipients:[NSArray arrayWithObject:[_emailTField text]]];
        [mailer setSubject:[[self name].text stringByAppendingString:@" resume"]];
        NSString *emailBody = @"My resume is in pdf file.";
        [mailer setMessageBody:emailBody isHTML:NO];
        NSLog(@"file name %@",pdfFile);
        NSData *data=[NSData dataWithContentsOfFile:pdfFile];
        [mailer addAttachmentData:data mimeType:@"pdf" fileName:@"resume.pdf"];
        NSLog(@"mailer %@",mailer);
        [self presentViewController:mailer animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"message:@"Your device doesn't support the composer sheet"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    EditResumeViewController *editResume = [[EditResumeViewController alloc] initWithNibName:@"EditResume" bundle:nil];
    [self.navigationController pushViewController:editResume animated:YES];
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
