//
//  AddActiveVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/1.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "BussinessApi.h"
#import "ImgeUpViewController.h"

@interface AddActiveVC : BaseViewController<UIImagePickerControllerDelegate,BussinessApiDelegate>

@property(nonatomic,strong)BussinessApi*api;

@property (strong, nonatomic) IBOutlet UITextField *activeName;
@property (strong, nonatomic) IBOutlet UITextField *danWei;

@property (strong, nonatomic) IBOutlet UITextField *renShu;
@property (strong, nonatomic) IBOutlet UIButton *activeLevelBtn;



- (IBAction)ActiveLevelClick:(id)sender;


- (IBAction)shangChuanClick:(id)sender;


- (IBAction)TiJiaoClick:(id)sender;


@property(nonatomic,strong)NSMutableString*Mstr;
@property(nonatomic,strong) UIImageView*imgView;
@property(nonatomic,strong)NSMutableArray*mArray;

@property(nonatomic,strong)NSString*photosIDS;










@end
