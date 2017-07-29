//
//  BaseViewController.h
//  chuangkexiaozhen
//
//  Created by zx on 17/7/26.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (strong,nonatomic) NSString* title;

-(void) setNavigationItemTitle:(NSString*) title;
-(void) backvc;
@end
