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

#define API_KEY @"c0a46f8bf9dd54d3f2f2662ef84977d8"
#define SECRET @"c95a269917cd4b9a"

@interface choosePhotoController () <UITableViewDataSource, UITableViewDelegate>
@end

@implementation choosePhotoController
@synthesize photoTable = _photoTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photos = [[NSMutableArray alloc] init];
    self.thumbs = [[NSMutableArray alloc] init];
    [[SVHTTPClient sharedClient] setBasePath:@"https://api.flickr.com/services/rest/"];
    
    NSDictionary *queryParams = @{@"method" : @"flickr.photos.getRecent",
                                  @"api_key" : API_KEY,
                                  @"extras" : @"url_l,url_sq",
                                  @"format" : @"json",
                                  @"nojsoncallback" : @"1"};
    
    [[SVHTTPClient sharedClient] GET:@""
                          parameters:queryParams
                          completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
                              if (!error) {
                                  NSArray *temp = response[@"photos"][@"photo"];
                                  for (id object in temp) {
                                      NSDictionary *photodata = object;
                                      [self.photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:photodata[@"url_l"]]]];
                                      [self.thumbs addObject:[MWPhoto photoWithURL:[NSURL URLWithString:photodata[@"url_sq"]]]];
                                  }
                                  MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
                                  
                                  // Set options
                                  browser.displayActionButton = NO; // Show action button to allow sharing, copying, etc (defaults to YES)
                                  browser.displayNavArrows = NO; // Whether to display left and right nav arrows on toolbar (defaults to NO)
                                  browser.displaySelectionButtons = YES; // Whether selection buttons are shown on each image (defaults to NO)
                                  browser.zoomPhotosToFill = YES; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
                                  browser.alwaysShowControls = NO; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
                                  browser.enableGrid = YES; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
                                  browser.startOnGrid = YES; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
                                  //browser.wantsFullScreenLayout = YES; // iOS 5 & 6 only: Decide if you want the photo browser full screen, i.e. whether the status bar is affected (defaults to YES)
                                  
                                  // Optionally set the current visible photo before displaying
                                  
                                  // Present
                                  [self.navigationController pushViewController:browser animated:YES];
                                  //do stuff
                              } else {
                                  NSLog(@"%@", @"There was a error with the API call");
                              }
                          }];

}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    if (index < _thumbs.count)
        return [_thumbs objectAtIndex:index];
    return nil;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count)
        return [self.photos objectAtIndex:index];
    return nil;
}


@end
