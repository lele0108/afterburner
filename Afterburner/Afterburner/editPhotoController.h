//
//  editPhotoController.h
//  Afterburner
//
//  Created by Jimmy Liu on 12/31/14.
//  Copyright (c) 2014 jimmyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDImageCache.h"
#import "MWCommon.h"
#import "MWPhotoBrowser.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Foundation/Foundation.h>

@interface editPhotoController : UIViewController

@property (nonatomic, strong) MWPhoto *photo;
@property (strong, nonatomic) IBOutlet UIImageView *flickrImage;

@end
