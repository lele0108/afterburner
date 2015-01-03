//
//  userInfoController.m
//  Afterburner
//
//  Created by Jimmy Liu on 1/2/15.
//  Copyright (c) 2015 jimmyliu. All rights reserved.
//

#import "userInfoController.h"
#import "SVHTTPRequest.h"

@implementation userInfoController

-(void) viewDidLoad {
    
}

- (IBAction)sendRequest:(id)sender {
    NSLog(@"This is it: %@", @"This is my string text!");
    [SVHTTPRequest POST:@"http://afterburnerapi.herokuapp.com/api/card"
             parameters:[NSDictionary dictionaryWithObjectsAndKeys:
                         @"from", @"Jimmy Liu",
                         @"to", @"Tommy Liu",
                         @"text", @"I love you!",
                         @"photoURL", @"https://farm8.staticflickr.com//7535//15558065274_669d51baf9_b.jpg",
                         @"senderEmail", @"sicong.liu98@gmail,com",
                         @"userEmail", @"sicong.liu98@gmail.com",
                         nil]
            completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
                //watchersLabel.text = [NSString stringWithFormat:@"SVHTTPRequest has %@ watchers", [response valueForKey:@"watchers"]];
            }];
}

- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
    value = @"application/x-www-form-urlencoded";
}

@end
