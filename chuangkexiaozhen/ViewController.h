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
@interface ViewController : UIViewController<UITextFieldDelegate>





@property (strong, nonatomic) IBOutlet UIButton *youke;
@property (strong, nonatomic) IBOutlet UITextField *username;

@property (strong, nonatomic) IBOutlet UITextField *pwd;



@property (strong, nonatomic) IBOutlet UIButton *login;





@end

