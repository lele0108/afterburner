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
#import "chooseMenuTableCells.h"

#define API_KEY @"c0a46f8bf9dd54d3f2f2662ef84977d8"
#define SECRET @"c95a269917cd4b9a"

@interface choosePhotoController () <UITableViewDataSource, UITableViewDelegate>
@end

@implementation choosePhotoController
@synthesize photoTable = _photoTable;
@synthesize selections = _selections;
@synthesize titles = _titles;
@synthesize desps = _desps;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.photoTable.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.photoTable.dataSource = self;
    CGRect newFrame = self.photoTable.tableHeaderView.frame;
    newFrame.size.height = 44;
    self.photoTable.tableHeaderView.frame = newFrame;
    [self.photoTable setTableHeaderView:self.photoTable.tableHeaderView];
    self.photos = [[NSMutableArray alloc] init];
    self.queryParams = [[NSMutableDictionary alloc] init];
    self.thumbs = [[NSMutableArray alloc] init];
    self.selections = [[NSMutableArray alloc] init];
    
    _titles = @[@"Recent Uploads",
                  @"Editor Selections",
                  @"Nature Photos",
                  @"Urban Photos",
                  @"Hipster Photos",
                  @"Romatic Photos"];
    
    _desps = @[@"A collection of recent uploads by random Flickr users on the internet.",
                   @"A special selection of photos by our editors perfect for Valentine Cards.",
                   @"Trees are green and roses are red.",
                   @"Buildings are tall and so am I.",
                   @"One word. Coffee.",
                   @"Beauitiful scenes that invoke romantic memories and awe."];
    
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

- (BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index {
    return [[_selections objectAtIndex:index] boolValue];
}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected {
    [_selections replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:selected]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"photoCell";
    chooseMenuTableCells *cell = [tableView
                              dequeueReusableCellWithIdentifier:CellIdentifier
                              forIndexPath:indexPath];
    
    // Configure the cell...
    
    long row = [indexPath row];
    
    cell.title.text = _titles[row];
    cell.desp.text = _desps[row];
    
    NSLog(@"The code runs through here!");
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:  { //popular photos
            NSDictionary *temp = @{@"method" : @"flickr.photos.getRecent",
                                          @"api_key" : API_KEY,
                                          @"extras" : @"url_l,url_sq",
                                          @"format" : @"json",
                                          @"nojsoncallback" : @"1"};
            self.queryParams = [temp mutableCopy];
            [self callFlickr];
            break;
        }
        case 1: { //editor selections
            NSDictionary *temp = @{@"method" : @"flickr.photos.search",
                                 @"api_key" : API_KEY,
                                 @"text" : @"valentine",
                                 @"extras" : @"url_l,url_sq",
                                 @"format" : @"json",
                                 @"nojsoncallback" : @"1"};
            self.queryParams = [temp mutableCopy];
            [self callFlickr];
            break;
        }
        case 2: { //nature photos
            NSDictionary *temp = @{@"method" : @"flickr.photos.search",
                                 @"api_key" : API_KEY,
                                 @"text" : @"nature",
                                 @"extras" : @"url_l,url_sq",
                                 @"format" : @"json",
                                 @"nojsoncallback" : @"1"};
            self.queryParams = [temp mutableCopy];
            [self callFlickr];
            break;
        }
        case 3: { //urban photos
            NSDictionary *temp = @{@"method" : @"flickr.photos.search",
                                 @"api_key" : API_KEY,
                                 @"text" : @"urban",
                                 @"extras" : @"url_l,url_sq",
                                 @"format" : @"json",
                                 @"nojsoncallback" : @"1"};
            self.queryParams = [temp mutableCopy];
            [self callFlickr];
            break;
        }
        case 4: { //hipster photos
            NSDictionary *temp = @{@"method" : @"flickr.photos.search",
                                 @"text" : @"coffee",
                                 @"api_key" : API_KEY,
                                 @"extras" : @"url_l,url_sq",
                                 @"format" : @"json",
                                 @"nojsoncallback" : @"1"};
            self.queryParams = [temp mutableCopy];
            [self callFlickr];
            break;
        }
        case 5: { //romantic photos
            NSDictionary *temp = @{@"method" : @"flickr.photos.search",
                                 @"text" : @"romantic",
                                 @"api_key" : API_KEY,
                                 @"extras" : @"url_l,url_sq",
                                 @"format" : @"json",
                                 @"nojsoncallback" : @"1"};
            self.queryParams = [temp mutableCopy];
            [self callFlickr];
            break;
        }
        default:
            break;
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSDictionary *temp = @{@"method" : @"flickr.photos.search",
                           @"api_key" : API_KEY,
                           @"text" : searchBar.text,
                           @"extras" : @"url_l,url_sq",
                           @"format" : @"json",
                           @"nojsoncallback" : @"1"};
    self.queryParams = [temp mutableCopy];
    [self.view endEditing:YES];
    [self callFlickr];
}

-(void)callFlickr {
    [self.photos removeAllObjects];
    [self.thumbs removeAllObjects];
    [[SVHTTPClient sharedClient] setBasePath:@"https://api.flickr.com/services/rest/"];
    [[SVHTTPClient sharedClient] GET:@""
                          parameters:self.queryParams
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
                                  browser.startOnGrid =YES; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
                                  browser.wantsFullScreenLayout = YES; // iOS 5 & 6 only: Decide if you want the photo browser full screen, i.e. whether the status bar is affected (defaults to YES)
                                  _selections = [NSMutableArray new];
                                  for (int i = 0; i < self.photos.count; i++) {
                                      [_selections addObject:[NSNumber numberWithBool:NO]];
                                  }
                                  [self.navigationController pushViewController:browser animated:YES];
                                  //do stuff
                              } else {
                                  NSLog(@"%@", @"There was a error with the API call");
                              }
                          }];

}



@end
