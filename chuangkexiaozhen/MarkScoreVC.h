//
//  MarkScoreVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/8.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "DaBianGuanLi.h"
#import "ComboViewController.h"
#import "NSMutableDictionary+NSMutableDictory_Extend.h"

@interface MarkScoreVC : BaseViewController<BussinessApiDelegate>

@property(nonatomic,strong)DaBianGuanLi*dabian;

@property(nonatomic,strong)NSString*photosIDS;

@property (strong, nonatomic) IBOutlet UITextField *textF1;

@property (strong, nonatomic) IBOutlet UITextField *textF2;


@property (strong, nonatomic) IBOutlet UITextField *textF3;

@property (strong, nonatomic) IBOutlet UITextField *textF4;


@property (strong, nonatomic) IBOutlet UITextField *textF5;


@property (strong, nonatomic) IBOutlet UIButton *btn;


-(void)setShuJu:(NSString*)strId;

@property(nonatomic,strong)NSString*strID;



@end
