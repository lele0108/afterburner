//
//  choosePhotoController.m
//  Afterburner
//
//  Created by Jimmy Liu on 12/29/14.
//  Copyright (c) 2014 jimmyliu. All rights reserved.
//

#import "choosePhotoController.h"
#import "SDImageCache.h"
#import "MWCommon.h"
#import "SVHTTPRequest.h"

#define API_KEY @"eed7d3ac0db9d9d7c6177e51db70f78c"

@interface choosePhotoController () <UITableViewDataSource, UITableViewDelegate>
@end

@implementation choosePhotoController
@synthesize photoTable = _photoTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[SVHTTPClient sharedClient] setBasePath:@"https://api.flickr.com/services/rest/"];
    
    NSDictionary *queryParams = @{@"method" : @"flickr.photos.getRecent",
                                  @"api_key" : API_KEY,
                                  @"extras" : @"url_l",
                                  @"format" : @"json",
                                  @"nojsoncallback" : @"1"};
    
    [[SVHTTPClient sharedClient] GET:@""
                          parameters:queryParams
                          completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
                              if (!error) {
                                  NSArray *temp = response[@"photos"][@"photo"];
                                  for (id object in temp) {
                                      NSLog(@"Value of array = %@", object);
                                  }
                                  //do stuff
                              } else {
                                  NSLog(@"%@", @"There was a error with the API call");
                              }
                          }];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


@end
