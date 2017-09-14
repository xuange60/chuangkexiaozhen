//
//  ViewController.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/18.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONKit.h"
#import "GDataXMLNode.h"
#import "TFHpple.h"
#import "TFHppleElement.h"
#import "XPathQuery.h"
#import "AFHTTPSessionManager.h"
#import "MainViewController.h"
#import "CommNetWork.h"
#import "MBProgressHUD.h"

@interface ViewController : UIViewController<UITextFieldDelegate>



@property(nonatomic,strong)UITextField*TF;


@property (strong, nonatomic) IBOutlet UITextField *username;

@property (strong, nonatomic) IBOutlet UITextField *pwd;



@property (strong, nonatomic) IBOutlet UIButton *login;


@property (strong,nonatomic) MBProgressHUD* HUD;


@end

