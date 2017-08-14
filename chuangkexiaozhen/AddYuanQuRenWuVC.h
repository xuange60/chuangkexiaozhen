//
//  AddYuanQuRenWuVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/14.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "YuanQuRenWuTongGao.h"
#import "DuoXuanVC.h"
@interface AddYuanQuRenWuVC : BaseViewController<BussinessApiDelegate>

@property(nonatomic,strong)YuanQuRenWuTongGao*tongGao;

@property (strong, nonatomic) IBOutlet UITextField *zhuTi;

@property (strong, nonatomic) IBOutlet UIButton *typeBtn;


@property (strong, nonatomic) IBOutlet UIButton *chengDuBtn;

@property (strong, nonatomic) IBOutlet UIButton *personBtn;

@property (strong, nonatomic) IBOutlet UITextView *content;

@property (strong, nonatomic) IBOutlet UIButton *date;






@end
