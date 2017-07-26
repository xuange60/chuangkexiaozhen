//
//  MyView2.h
//  chuangkexiaozhen
//
//  Created by zx on 17/7/26.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyView2 : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *img;

@property (strong, nonatomic) IBOutlet UILabel *lab;


@property (strong, nonatomic) IBOutlet UIButton *btn1;
@property (strong, nonatomic) IBOutlet UILabel *lab1;


@property (strong, nonatomic) IBOutlet UIButton *btn2;
@property (strong, nonatomic) IBOutlet UILabel *lab2;



@property (strong, nonatomic) IBOutlet UIButton *btn3;

@property (strong, nonatomic) IBOutlet UILabel *lab3;


@property (strong, nonatomic) IBOutlet UIButton *btn4;
@property (strong, nonatomic) IBOutlet UILabel *lab4;

@property (strong, nonatomic) IBOutlet UIButton *btn5;

@property (strong, nonatomic) IBOutlet UILabel *lab5;


@property (strong, nonatomic) IBOutlet UIButton *btn6;

@property (strong, nonatomic) IBOutlet UILabel *lab6;



@property (strong, nonatomic) IBOutlet UIButton *btn7;

@property (strong, nonatomic) IBOutlet UILabel *lab7;


@property (strong, nonatomic) IBOutlet UIButton *btn8;

@property (strong, nonatomic) IBOutlet UILabel *lab8;



@property (strong, nonatomic) NSString* title;
@property (strong,nonatomic) NSArray* values;


-(void) initWithTitle:(NSString*) title andValues:(NSArray*) values;
@end
