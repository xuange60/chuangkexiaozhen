//
//  AddShiTiVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/9.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "ShiTiRuZhuGuanLi.h"
#import "ComboViewController.h"
@interface AddShiTiVC : BaseViewController<BussinessApiDelegate>

@property (strong, nonatomic) IBOutlet UIButton *btn1;

@property (strong, nonatomic) IBOutlet UITextField *textField;

@property (strong, nonatomic) IBOutlet UITextField *address;

@property(nonatomic,strong)ShiTiRuZhuGuanLi*shiti;
@property(nonatomic,strong)NSArray*array;


@property(nonatomic,strong)NSString*strID;

-(void)setData:(NSString*)strId;




@end
