//
//  DianZiHeTongViewController.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/1.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"

@interface DianZiHeTongViewController : BaseViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong,nonatomic) NSMutableString* resourceids;
@property (strong,nonatomic) NSMutableArray* images;


@property (strong, nonatomic) IBOutlet UIImageView *iv1;

@property (strong, nonatomic) IBOutlet UIImageView *iv2;

@property (strong, nonatomic) IBOutlet UIImageView *iv3;




@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *ind1;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *ind2;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *ind3;

@property (strong,nonatomic) NSString* ids;


@end
