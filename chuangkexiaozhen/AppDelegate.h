//
//  AppDelegate.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/18.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate,BMKLocationServiceDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,strong)BMKMapManager*mapManager;
@property(nonatomic,strong)BMKLocationService*locaService;

@end

