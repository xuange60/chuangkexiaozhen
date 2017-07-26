//
//  CustomCell.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/20.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}




-(void)setShuJu:(NSArray *)array
{
    self.img1.image=[UIImage imageNamed:[array objectAtIndex:0]];
    self.lab1.text=[array objectAtIndex:1];
    self.lab2.text=[array objectAtIndex:2];
}











@end
