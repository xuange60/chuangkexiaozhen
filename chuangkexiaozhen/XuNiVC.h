//
//  XuNiVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/25.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface XuNiVC : BaseViewController
@property (strong, nonatomic) IBOutlet UITextField *F1;
@property (strong, nonatomic) IBOutlet UITextField *F2;
@property (strong, nonatomic) IBOutlet UITextField *F3;
@property (strong, nonatomic) IBOutlet UIView *MyView;


@property (strong, nonatomic) IBOutlet UIButton *duoxuan;

@property (strong, nonatomic) IBOutlet UITextView *textView;

- (IBAction)BtnClicked:(id)sender;






@end
