//
//  XiaZaiCell.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/30.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XiaZaiCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *textName;


@property (strong, nonatomic) IBOutlet UILabel *textDate;

-(void)setCellShuJu:(NSArray*)array;

@end
