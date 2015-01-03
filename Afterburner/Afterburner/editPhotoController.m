//
//  editPhotoController.m
//  Afterburner
//
//  Created by Jimmy Liu on 12/31/14.
//  Copyright (c) 2014 jimmyliu. All rights reserved.
//

#import "editPhotoController.h"
#import "userInfoController.h"

@implementation editPhotoController
@synthesize photo = _photo;

-(void) viewDidLoad {
    UIImage *temp = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://farm8.staticflickr.com//7535//15558065274_669d51baf9_b.jpg"]]];
    [self.flickrImage setImage:temp];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"userInfoSegue"])
    {
        userInfoController *vc = [segue destinationViewController];
        vc.photoDetailModel = [NSArray arrayWithObjects: @"https://farm8.staticflickr.com//7535//15558065274_669d51baf9_b.jpg", nil];
    }
}

@end
