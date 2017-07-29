//
//  ComBoRowsViewController.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/29.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"

@interface ComBoRowsViewController : BaseViewController

@property (nonatomic) BOOL flag1;
@property (nonatomic) BOOL flag2;
@property (nonatomic) BOOL flag3;
@property (nonatomic) BOOL flag4;
@property (nonatomic) BOOL flag5;
@property (nonatomic) BOOL flag6;
@property (nonatomic) BOOL flag7;
@property (nonatomic) BOOL flag8;
@property (nonatomic) BOOL flag9;
@property (nonatomic) BOOL flag10;

@property (strong,nonatomic) NSString* value1;
@property (strong,nonatomic) NSString* value2;
@property (strong,nonatomic) NSString* value3;
@property (strong,nonatomic) NSString* value4;
@property (strong,nonatomic) NSString* value5;
@property (strong,nonatomic) NSString* value6;
@property (strong,nonatomic) NSString* value7;
@property (strong,nonatomic) NSString* value8;
@property (strong,nonatomic) NSString* value9;
@property (strong,nonatomic) NSString* value10;

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


@property (strong,nonatomic) NSArray* array;

@property (strong,nonatomic) UIButton* clickbtn;
-(void) setDatas:(NSArray*)array withBtn:(UIButton*) btn;

-(void) initWithData;


@end
