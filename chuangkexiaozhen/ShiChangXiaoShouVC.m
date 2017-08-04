//
//  ShiChangXiaoShouVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/4.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "ShiChangXiaoShouVC.h"
#import "HeTongGuanLiVC.h"
#import "NaShuiGuanLiVC.h"
#import "ZhanYouLuGuanLiVC.h"
@interface ShiChangXiaoShouVC ()

@end

@implementation ShiChangXiaoShouVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"市场销售考核";
    
}
- (IBAction)btn1Clicked:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"ShiChangXiaoShou" bundle:nil];
    HeTongGuanLiVC*vc=[board instantiateViewControllerWithIdentifier:@"HeTongGuanLiVC"];
    //    [vc ReceiveShuJu];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)btn2Clicked:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"ShiChangXiaoShou" bundle:nil];
    NaShuiGuanLiVC*vc=[board instantiateViewControllerWithIdentifier:@"NaShuiGuanLiVC"];
    //    [vc ReceiveShuJu];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)btn3Clicked:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"ShiChangXiaoShou" bundle:nil];
    ZhanYouLuGuanLiVC*vc=[board instantiateViewControllerWithIdentifier:@"ZhanYouLuGuanLiVC"];
    //    [vc ReceiveShuJu];
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
