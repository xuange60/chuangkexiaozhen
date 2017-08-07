//
//  AddChanXueYanVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/1.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "ImgeUpViewController.h"
#import "BussinessApi.h"
@interface AddChanXueYanVC : BaseViewController<UIImagePickerControllerDelegate,BussinessApiDelegate>

@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *effct;
@property (strong, nonatomic) IBOutlet UITextField *money;

@property (strong, nonatomic) IBOutlet UIButton *jiGouLevel;
@property (strong, nonatomic) IBOutlet UIButton *moneyLevel;


@property(nonatomic,strong)BussinessApi*api;

@property(nonatomic,strong)NSMutableString*Mstr;
@property(nonatomic,strong) UIImageView*imgView;
@property(nonatomic,strong)NSMutableArray*mArray;

@property(nonatomic,strong)NSString*photosIDS;





@end
