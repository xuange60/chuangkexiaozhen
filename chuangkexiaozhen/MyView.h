//
//  MyView.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/22.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyView : UITableViewCell

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


@property (strong, nonatomic) NSString* title;
@property (strong,nonatomic) NSArray* values;


-(void) initWithTitle:(NSString*) title andValues:(NSArray*) values;

@end
