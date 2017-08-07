//
//  AddZhuanLiVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/3.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "ComboViewController.h"
#import "BussinessApi.h"
#import "ImgeUpViewController.h"
@interface AddZhuanLiVC : BaseViewController<UIImagePickerControllerDelegate,BussinessApiDelegate>

@property(nonatomic,strong)BussinessApi*api;

@property (strong, nonatomic) IBOutlet UITextField *name;

@property (strong, nonatomic) IBOutlet UITextField *biMa;

@property (strong, nonatomic) IBOutlet UIButton *leiBieBtn;





- (IBAction)leiBieBtnClick:(id)sender;



- (IBAction)shangChuanClick:(id)sender;


- (IBAction)TiJiaoClick:(id)sender;


@property(nonatomic,strong)NSMutableString*Mstr;
@property(nonatomic,strong) UIImageView*imgView;
@property(nonatomic,strong)NSMutableArray*mArray;

@property(nonatomic,strong)NSString*photosIDS;




@end
