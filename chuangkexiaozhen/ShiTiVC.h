//
//  ShiTiVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/24.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "XiaLaView.h"
#import "BussinessApi.h"
@interface ShiTiVC : BaseViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(nonatomic,strong)NSString*resourceID;

@property (strong, nonatomic) IBOutlet UITextField *textField1;

@property (strong, nonatomic) IBOutlet UITextField *textField2;
@property (strong, nonatomic) IBOutlet UITextField *textField3;

@property (strong, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) IBOutlet UITextField *textF1;
@property (strong, nonatomic) IBOutlet UIButton *btn1;

@property (strong, nonatomic) IBOutlet UIView *view2;
@property (strong, nonatomic) IBOutlet UITextField *textF2;
@property (strong, nonatomic) IBOutlet UIButton *btn2;

@property (strong, nonatomic) IBOutlet XiaLaView *xialaView;
@property (strong, nonatomic) IBOutlet UIView *view3;

@property (strong, nonatomic) IBOutlet UIView *view4;
@property (strong, nonatomic) IBOutlet UITextField *statueF;






@property (strong, nonatomic) IBOutlet UIButton *xuanWenJianBtn;
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *jihuashuLab;
@property (strong, nonatomic) IBOutlet UILabel *tishiLab;
@property (strong, nonatomic) IBOutlet UIButton *shenqingBtn;







- (IBAction)btn1Click:(id)sender;

- (IBAction)btn2Click:(id)sender;





@end
