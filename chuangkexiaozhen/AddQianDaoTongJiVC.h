//
//  AddQianDaoTongJiVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/15.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "QianDaoTongJi.h"
#import "DuoXuanVC.h"
#import "ImgeUpViewController.h"
@interface AddQianDaoTongJiVC : BaseViewController<BussinessApiDelegate>

@property(nonatomic,strong)QianDaoTongJi*qiandao;
@property (strong, nonatomic) IBOutlet UIButton *huodongBtn;
@property(nonatomic,strong)NSMutableDictionary*dicM;

@property (strong, nonatomic) IBOutlet UITextField *shidaoNum;

@property (strong, nonatomic) IBOutlet UITextField *yingdaoNum;

@property (strong, nonatomic) IBOutlet UILabel *bilv;

@property (strong, nonatomic) IBOutlet UITextView *beizhu;


@property(nonatomic) int num1;
@property(nonatomic) int num2;

@property(nonatomic)NSString*photoIds;


@end
