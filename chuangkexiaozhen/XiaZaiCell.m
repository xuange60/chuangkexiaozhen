//
//  XiaZaiCell.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/30.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "XiaZaiCell.h"

@implementation XiaZaiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setCellShuJu:(NSArray*)array
{
    _textName.text=[array objectAtIndex:0];
    _textDate.text=[array objectAtIndex:1];
    
}















- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
