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

@interface choosePhotoController () <UITableViewDataSource, UITableViewDelegate>
@end

@implementation choosePhotoController
@synthesize photoTable = _photoTable;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


@end
