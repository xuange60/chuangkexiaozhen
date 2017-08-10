//
//  EditShiTiVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/9.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "ShiTiRuZhuGuanLi.h"
#import "ComboViewController.h"
@interface EditShiTiVC : BaseViewController<BussinessApiDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textF1;

@property (strong, nonatomic) IBOutlet UITextField *textF2;

@property (strong, nonatomic) IBOutlet UITextField *textF3;
@property (strong, nonatomic) IBOutlet UIButton *btn1;

@property (strong, nonatomic) IBOutlet UIButton *btn2;


@property(nonatomic,strong)ShiTiRuZhuGuanLi*shiti;
@property(nonatomic,strong)NSString*strID;
@property(nonatomic,strong)NSArray*array;

-(void)setShuJu:(NSString*)strId  infoAry:(NSArray*)ary;

@end
