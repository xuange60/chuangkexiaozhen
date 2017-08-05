//
//  HuoDongLuYanDetailViewController.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/6.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "HuoDong.h"
#import "BussinessApi.h"
@interface HuoDongLuYanDetailViewController : BaseViewController<BussinessApiDelegate>

@property (strong,nonatomic) HuoDong* huodong;
@property (strong,nonatomic) NSString* huodongid;

@property (strong, nonatomic) IBOutlet UITextField *name;


@property (strong, nonatomic) IBOutlet UITextField *address;


@property (strong, nonatomic) IBOutlet UITextField *time;


@property (strong, nonatomic) IBOutlet UITextField *organizationList;

@property (strong, nonatomic) IBOutlet UITextField *url;

@property (strong, nonatomic) IBOutlet UITextField *noticeList;

@property (strong, nonatomic) IBOutlet UITextView *content;


@end
