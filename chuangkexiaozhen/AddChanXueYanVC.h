//
//  AddChanXueYanVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/1.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"

@interface AddChanXueYanVC : BaseViewController<UIImagePickerControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *effct;
@property (strong, nonatomic) IBOutlet UITextField *money;

@property (strong, nonatomic) IBOutlet UIButton *jiGouLevel;
@property (strong, nonatomic) IBOutlet UIButton *moneyLevel;

@property (strong, nonatomic) IBOutlet UIImageView *iv1;


@property (strong, nonatomic) IBOutlet UIImageView *iv2;
@property (strong, nonatomic) IBOutlet UIImageView *iv3;

@property(nonatomic,strong)NSMutableString*Mstr;
@property(nonatomic,strong) UIImageView*imgView;
@property(nonatomic,strong)NSMutableArray*mArray;

@property(nonatomic,strong)NSString*photosIDS;





@end