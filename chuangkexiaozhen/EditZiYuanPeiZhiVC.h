//
//  EditZiYuanPeiZhiVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/12.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "DuoXuanVC.h"
@interface EditZiYuanPeiZhiVC : BaseViewController

-(void)setStr:(NSString*)strId infoAry:(NSArray*)ary;
@property(nonatomic,strong)NSString*strID;
@property(nonatomic,strong)NSArray*ary;


@property (strong, nonatomic) IBOutlet UITextField *chushiDuiXiang;

@property (strong, nonatomic) IBOutlet UILabel *numberOfOffice;

@property (strong, nonatomic) IBOutlet UIButton *ofoCodes;

@property (strong, nonatomic) IBOutlet UILabel *numberOftc;

@property (strong, nonatomic) IBOutlet UIButton *TcCodes;

@property (strong, nonatomic) IBOutlet UILabel *numberOfoe;

@property (strong, nonatomic) IBOutlet UIButton *OeCodes;

@property (strong, nonatomic) IBOutlet UILabel *numberOfegc;


@property (strong, nonatomic) IBOutlet UIButton *EgcCodes;

@property (strong, nonatomic) IBOutlet UILabel *numberOfpl;

@property (strong, nonatomic) IBOutlet UIButton *PlCodes;

@property (strong, nonatomic) IBOutlet UILabel *printAccount;

@property (strong, nonatomic) IBOutlet UILabel *printPassword;

@property (strong, nonatomic) IBOutlet UILabel *name;

@property (strong, nonatomic) IBOutlet UILabel *concatType;

@property (strong, nonatomic) IBOutlet UITextView *beizhu;






@end
