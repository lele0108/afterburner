//
//  userInfoController.h
//  Afterburner
//
//  Created by Jimmy Liu on 1/2/15.
//  Copyright (c) 2015 jimmyliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface userInfoController : UIViewController

@property (nonatomic, strong) NSArray *photoDetailModel;
@property (strong, nonatomic) IBOutlet UITextField *fromField;
@property (strong, nonatomic) IBOutlet UITextField *toField;
@property (strong, nonatomic) IBOutlet UITextField *senderEmail;
@property (strong, nonatomic) IBOutlet UITextField *recipientEmail;
@property (strong, nonatomic) IBOutlet UINavigationItem *sendButton;
- (IBAction)sendRequest:(id)sender;

@end
