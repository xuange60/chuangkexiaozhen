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
    NSString*str1=[@"文件名称："stringByAppendingString:[array objectAtIndex:0] ];
     NSString*str2=[@"上传日期：" stringByAppendingString:[array objectAtIndex:1]];
    
    _textName.text=str1;
    _textDate.text=str2;
    
}















- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
