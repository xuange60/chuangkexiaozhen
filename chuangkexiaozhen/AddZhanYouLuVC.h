//
//  AddZhanYouLuVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/5.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "FuHusChengZhangGuanLi.h"
#import "ComboViewController.h"
#import "ImgeUpViewController.h"

@interface AddZhanYouLuVC : BaseViewController@property (strong, nonatomic) IBOutlet UIButton *btn1Title;
@property(nonatomic,strong)FuHusChengZhangGuanLi*fuHua;


@property (strong, nonatomic) IBOutlet UITextField *zhanyoulu;
@property (strong, nonatomic) IBOutlet UITextField *xifenshichang;

@property (strong, nonatomic) IBOutlet UITextField *renzhengjigou;


@property (strong, nonatomic) IBOutlet UIButton *btn3Title;

- (IBAction)Btn3Click:(id)sender;


- (IBAction)ShangChuan:(id)sender;


- (IBAction)TiJiao:(id)sender;

@property(nonatomic,strong)NSMutableString*Mstr;

@property(nonatomic,strong)NSMutableArray*mArray;

@property(nonatomic,strong)NSString*photosIDS;



@end
