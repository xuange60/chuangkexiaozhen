//
//  BaseViewController.h
//  chuangkexiaozhen
//
//  Created by zx on 17/7/26.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BussinessApi.h"
#import "MBProgressHUD.h"
@interface BaseViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>

@property(nonatomic,strong)MBProgressHUD*HUD;

@property (strong,nonatomic) NSString* navtitle;

@property (strong, nonatomic) UIBarButtonItem* rightbutton;


-(void) setNavigationItemTitle:(NSString*) title;
-(void) backvc;
-(void)tiShiKuangDisplay:(NSString*)text  viewController:(UIViewController*)vc;

-(void)receiveCurrentViewController:(UIViewController*)viewController;


@property(nonatomic,strong)UIViewController*currentVC;


@end
