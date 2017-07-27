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
@interface ShiTiVC : BaseViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) IBOutlet UITextField *textF1;
@property (strong, nonatomic) IBOutlet UIButton *btn1;

@property (strong, nonatomic) IBOutlet UIView *view2;
@property (strong, nonatomic) IBOutlet UITextField *textF2;
@property (strong, nonatomic) IBOutlet UIButton *btn2;

@property (strong, nonatomic) IBOutlet XiaLaView *xialaView;

@property (strong, nonatomic) IBOutlet UIButton *xuanWenJianBtn;
@property (strong, nonatomic) IBOutlet UIImageView *imgView;







- (IBAction)btn1Click:(id)sender;

- (IBAction)btn2Click:(id)sender;





@end
