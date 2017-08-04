//
//  AddNaShuiVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/4.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "ComboViewController.h"
#import "FuHusChengZhangGuanLi.h"

@interface AddNaShuiVC : BaseViewController

<FuHusChengZhangGuanLiDelegate>

@property (strong, nonatomic) IBOutlet UIButton *btn1Title;
@property(nonatomic,strong)FuHusChengZhangGuanLi*fuHua;


@property (strong, nonatomic) IBOutlet UITextField *jinE;

@property (strong, nonatomic) IBOutlet UITextField *leiBie;

@property (strong, nonatomic) IBOutlet UITextField *duiXiang;


@property (strong, nonatomic) IBOutlet UIButton *btn2Title;

- (IBAction)Btn2Click:(id)sender;


@property (strong, nonatomic) IBOutlet UIButton *btn3Title;

- (IBAction)Btn3Click:(id)sender;


- (IBAction)ShangChuan:(id)sender;


- (IBAction)TiJiao:(id)sender;

@property(nonatomic,strong)NSMutableString*Mstr;

@property(nonatomic,strong)NSMutableArray*mArray;

@property(nonatomic,strong)NSString*photosIDS;


@end
