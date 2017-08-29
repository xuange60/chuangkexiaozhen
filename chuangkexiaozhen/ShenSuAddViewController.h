//
//  ShenSuAddViewController.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/7/31.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"


@interface ShenSuAddViewController : BaseViewController


@property (strong, nonatomic) IBOutlet UIButton *type;

@property (strong, nonatomic) IBOutlet UITextView *detail;

@property (strong, nonatomic) IBOutlet UITextView *liyou;



@property (strong,nonatomic) NSDictionary* data;


@end
