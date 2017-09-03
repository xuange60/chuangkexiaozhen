//
//  CustomButton.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/27.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomButton : UIControl

@property(nonatomic,strong)UILabel*lab1;
@property(nonatomic,strong)UILabel*lab2;

-(void)setContent:(NSString*)str   attributeStr:(NSString*)string;


@end
