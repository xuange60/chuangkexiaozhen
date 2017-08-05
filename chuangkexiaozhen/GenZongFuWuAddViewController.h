//
//  GenZongFuWuAddViewController.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/5.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "GenZongFuWu.h"
#import "BussinessApi.h"
@interface GenZongFuWuAddViewController : BaseViewController<BussinessApiDelegate>

@property (strong,nonatomic) GenZongFuWu* genzongfuwu;
@property (strong, nonatomic) IBOutlet UITextField *genzongtitle;

@property (strong, nonatomic) IBOutlet UITextView *content;



@end
