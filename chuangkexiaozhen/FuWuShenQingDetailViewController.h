//
//  FuWuShenQingDetailViewController.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/3.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"

@interface FuWuShenQingDetailViewController : BaseViewController

@property (strong,nonatomic) NSDictionary* data;


@property (strong, nonatomic) IBOutlet UIButton *fuwutype;


@property (strong, nonatomic) IBOutlet UITextView *fuwucontent;




@end
