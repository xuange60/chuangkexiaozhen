//
//  HuoDongLuYanAddVC.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/9/7.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "HuoDong.h"
#import "ImgeUpViewController.h"
#import "DuoXuanVC.h"
@interface HuoDongLuYanAddVC : BaseViewController<BussinessApiDelegate>

@property (strong,nonatomic) HuoDong* huodong;


@property (strong, nonatomic) IBOutlet UITextField *name;


@property (strong, nonatomic) IBOutlet UITextField *address;


@property (strong, nonatomic) IBOutlet UIButton *time;


@property (strong, nonatomic) IBOutlet UITextField *organizationList;

@property (strong, nonatomic) IBOutlet UITextField *url;

@property (strong, nonatomic) IBOutlet UIButton *noticeList;

@property (strong, nonatomic) IBOutlet UITextView *content;

@property(nonatomic,strong)NSString*photoIds;
@property(nonatomic,strong)NSDictionary*dic;

@end
