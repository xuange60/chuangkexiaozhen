//
//  ComboViewController.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/7/27.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface ComboViewController : BaseViewController


@property (strong,nonatomic) NSArray* array;

@property (strong,nonatomic) UIButton* clickbtn;

@property (strong, nonatomic) IBOutlet UIButton *btn1;

@property (strong, nonatomic) IBOutlet UIButton *btn2;

@property (strong, nonatomic) IBOutlet UIButton *btn3;

@property (strong, nonatomic) IBOutlet UIButton *btn4;


@property (strong, nonatomic) IBOutlet UIButton *btn5;


@property (strong, nonatomic) IBOutlet UIButton *btn6;

@property (strong, nonatomic) IBOutlet UIButton *btn7;

@property (strong, nonatomic) IBOutlet UIButton *btn8;


@property (strong, nonatomic) IBOutlet UIButton *btn9;

@property (strong, nonatomic) IBOutlet UIButton *btn10;


-(void) setDatas:(NSArray*)array withBtn:(UIButton*) btn;

-(void) initWithData;




@end
