//
//  FuWuShenQingCell.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/2.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 相关属性关联单元格中的控件
 */
@interface FuWuShenQingCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *fuwutype;

@property (strong, nonatomic) IBOutlet UILabel *shenqinggongsi;

@property (strong, nonatomic) IBOutlet UILabel *fuwucontent;

@property (strong, nonatomic) IBOutlet UILabel *fuwustatus;



@end
