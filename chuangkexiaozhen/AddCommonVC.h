//
//  AddCommonVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/21.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "TuanDuiYunYing.h"
#import "DuoXuanVC.h"
#import "ImgeUpViewController.h"
@interface AddCommonVC : BaseViewController<BussinessApiDelegate>


@property(nonatomic,strong)NSString*strTitle;
@property(nonatomic,strong)NSString*photosIDS;
@property (strong, nonatomic) IBOutlet UILabel *lab1;

@property (strong, nonatomic) IBOutlet UILabel *lab2;

@property (strong, nonatomic) IBOutlet UILabel *lab3;

@property (strong, nonatomic) IBOutlet UILabel *lab4;

@property (strong, nonatomic) IBOutlet UILabel *lab5;

@property (strong, nonatomic) IBOutlet UITextField *textF1;
@property (strong, nonatomic) IBOutlet UITextField *textF2;
@property (strong, nonatomic) IBOutlet UITextField *textF3;
@property (strong, nonatomic) IBOutlet UITextField *textF4;
@property (strong, nonatomic) IBOutlet UITextField *textF5;




@property (strong, nonatomic) IBOutlet UILabel *lab6;
@property (strong, nonatomic) IBOutlet UILabel *lab7;
@property (strong, nonatomic) IBOutlet UIButton *btn1;
@property (strong, nonatomic) IBOutlet UIButton *btn2;
@property (strong, nonatomic) IBOutlet UIImageView *btn11;
@property (strong, nonatomic) IBOutlet UIImageView *btn12;

@property (strong, nonatomic) IBOutlet UIButton *chuanBtn;

@property (strong, nonatomic) IBOutlet UILabel *fujian;






@property(nonatomic,strong)TuanDuiYunYing*yunying;
@property(nonatomic,strong)NSMutableDictionary*dic;


@end
