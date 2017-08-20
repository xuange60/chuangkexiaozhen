//
//  DetailBaoXiaoVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/20.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "DetailBaoXiaoVC.h"

@interface DetailBaoXiaoVC ()

@end

@implementation DetailBaoXiaoVC
-(void)setArray:(NSArray*)ary
{
    _ary=ary;
}
- (void)viewDidLoad {
    [super viewDidLoad];
  
    _luyan.text=_ary[0];
    _leibie.text=_ary[1];
    _mingxi.text=_ary[2];
    _jine.text=_ary[3];
    _shenpi.text=_ary[4];
    _shenqingren.text=_ary[5];
}










@end
