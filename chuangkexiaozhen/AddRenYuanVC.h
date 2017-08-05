//
//  AddRenYuanVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/5.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "FuHusChengZhangGuanLi.h"
@interface AddRenYuanVC : BaseViewController<FuHusChengZhangGuanLiDelegate>

@property(nonatomic,strong)FuHusChengZhangGuanLi*fuHua;

@property (strong, nonatomic) IBOutlet UITextField *totalNum;

@property (strong, nonatomic) IBOutlet UITextField *shichangNum;


@property (strong, nonatomic) IBOutlet UITextField *shichangPercent;

@property (strong, nonatomic) IBOutlet UITextField *jishuNum;
@property (strong, nonatomic) IBOutlet UITextField *jishuPercent;
@property (strong, nonatomic) IBOutlet UITextField *yunyingNum;
@property (strong, nonatomic) IBOutlet UITextField *yunyingPercent;

- (IBAction)ShangChuan:(id)sender;
- (IBAction)TiJiao:(id)sender;

@property(nonatomic,strong)NSMutableString*Mstr;

@property(nonatomic,strong)NSMutableArray*mArray;

@property(nonatomic,strong)NSString*photosIDS;


@end
