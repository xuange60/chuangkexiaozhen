//
//  FuWuShenQingAddViewController.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/3.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "YuanQuFuWuShenQing.h"
#import "ComboViewController.h"
#import "ComBoRowsViewController.h"
#import "ImgeUpViewController.h"

@interface FuWuShenQingAddViewController : BaseViewController<BussinessApiDelegate>

@property (strong,nonatomic) YuanQuFuWuShenQing* yuanqufuwushenqing;
@property (strong,nonatomic) NSString* resourids;
@property (strong, nonatomic) IBOutlet UIButton *fuwutype;
@property (strong, nonatomic) IBOutlet UITextView *fuwucontent;

@end
