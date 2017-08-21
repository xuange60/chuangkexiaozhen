//
//  TuanDuiGuanLiVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/5.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "RenYuanJieGouVC.h"
#import "liugeCommonVC.h"
#import "TuanDuiYunYing.h"
@interface TuanDuiGuanLiVC : BaseViewController<BussinessApiDelegate>

@property(nonatomic,strong) NSString* isadmin;
@property(nonatomic,strong) TuanDuiYunYing* yunying;

@property(nonatomic,strong) NSArray* array;

@property(nonatomic,strong) NSString* strIds;

@end
