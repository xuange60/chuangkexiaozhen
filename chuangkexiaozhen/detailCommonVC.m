//
//  detailCommonVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/21.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "detailCommonVC.h"

@interface detailCommonVC ()

@end

@implementation detailCommonVC
-(void)shuJu:(NSArray*)ary   array:(NSArray*)array
{
    _ary=ary;
    _array=array;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    
     _lab1.text=_ary[0];
     _lab2.text=_ary[1];
     _lab3.text=_ary[2];
     _lab4.text=_ary[3];
//     _lab5.text=_ary[4];
//     _lab6.text=_ary[5];
//     _lab7.text=_ary[6];

    

}


@end
