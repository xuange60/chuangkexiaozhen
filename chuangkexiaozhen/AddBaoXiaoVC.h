//
//  AddBaoXiaoVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/20.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "ImgeUpViewController.h"
#import "DuoXuanVC.h"
#import "HuoDongBaoXiao.h"
@interface AddBaoXiaoVC : BaseViewController<BussinessApiDelegate>

@property(nonatomic,strong)HuoDongBaoXiao*baoxiao;
@property(nonatomic,strong)NSMutableDictionary*dic;
@property(nonatomic,strong)NSString*_photoIds;
@property (strong, nonatomic) IBOutlet UIButton *luyanBtn;

@property (strong, nonatomic) IBOutlet UIButton *baoxiaoLevel;


@property (strong, nonatomic) IBOutlet UITextView *mingxi;

@property (strong, nonatomic) IBOutlet UITextField *money;


@property (strong, nonatomic) IBOutlet UIButton *shenpiBtn;

@property (strong, nonatomic) IBOutlet UIButton *shenqingBtn;


@end
