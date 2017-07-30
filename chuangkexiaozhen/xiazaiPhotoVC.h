//
//  xiazaiPhotoVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/30.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface xiazaiPhotoVC :  BaseViewController<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;

@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@property (strong,nonatomic) NSData* imgdata;

-(void)setData:(NSData*)data;


@end
