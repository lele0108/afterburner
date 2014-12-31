//
//  choosePhotoController.h
//  Afterburner
//
//  Created by Jimmy Liu on 12/29/14.
//  Copyright (c) 2014 jimmyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Foundation/Foundation.h>


@interface choosePhotoController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *photoTable;
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSMutableArray *thumbs;
@property (nonatomic, strong) NSMutableArray *selections;
@property (nonatomic, strong) ALAssetsLibrary *assetLibrary;
@property (nonatomic, strong) NSMutableArray *assets;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *desps;

@end
