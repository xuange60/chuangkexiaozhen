//
//  DetailShenSuVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/12.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "DetailShenSuVC.h"

@interface DetailShenSuVC ()

@end

@implementation DetailShenSuVC
-(void)setShuJu:(NSString*)str   infoAry:(NSArray*)ary
{
    _ary=[NSArray arrayWithArray:ary];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [_typeB setTitle:[_ary objectAtIndex:0] forState:UIControlStateNormal];
    
    _contentTV.text=[_ary objectAtIndex:1];
    _reasonTV.text=[_ary objectAtIndex:2];
    
    
    
}

@end
