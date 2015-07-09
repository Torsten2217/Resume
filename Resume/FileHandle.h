//
//  FileHandle.h
//  Resume
//
//  Created by OkSeJu on 1/23/15.
//  Copyright (c) 2015 com.fsoft.Resume. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface FileHandle : NSObject

- ( void ) initFile:(NSString *) filename;
- (NSArray *) getContents:(NSString *)filename;
- (bool) setContents:(NSString *)filename strings:(NSArray *) str;
-(NSMutableData *)createPDFDatafromUIView:(UIView *)view;
-(NSString*)createPDF:(NSString*)pdffile withView:(UIView *)view;

@end
