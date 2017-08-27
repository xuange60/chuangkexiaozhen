//
//  RegeistVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/24.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"
@interface RegeistVC : UIViewController<UITextFieldDelegate>


@property(nonatomic,strong)NSTimer*timer;
@property(nonatomic)int i;
@property(nonatomic,strong)UIGestureRecognizer*ges;




@property (strong, nonatomic) IBOutlet CustomButton *yzmBtn;

@property (strong, nonatomic) IBOutlet UIButton *xzlxBtn;
@property (strong, nonatomic) IBOutlet UIButton *zhuceBtn;

@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *mobile;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *checkcode;
@property (strong, nonatomic) IBOutlet UITextField *pwd;

@property (strong, nonatomic) IBOutlet UITextField *pwd2;

@property (strong, nonatomic) IBOutlet UIButton *usertype;

- (IBAction)yzmBtnClick:(id)sender;

- (IBAction)zhuceBtnClick:(id)sender;





@end
