//
//  keJiChuanXinGuanLiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/3.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "keJiChuanXinGuanLiVC.h"
#import "ZhuanLiGuanLiVC.h"
#import "XiangMuGuanLiVC.h"
#import "JiangLiGuanLiVC.h"

@interface keJiChuanXinGuanLiVC ()

@end

@implementation keJiChuanXinGuanLiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"科技创新成熟度考核";
    
}
- (IBAction)btn1Clicked:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"KeJiChuanXin" bundle:nil];
    ZhuanLiGuanLiVC*vc=[board instantiateViewControllerWithIdentifier:@"ZhuanLiGuanLiVC"];
//    [vc ReceiveShuJu];
        vc.isadmin=_isadmin;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)btn2Clicked:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"KeJiChuanXin" bundle:nil];
    XiangMuGuanLiVC*vc=[board instantiateViewControllerWithIdentifier:@"XiangMuGuanLiVC"];
//    [vc ReceiveShuJu];
        vc.isadmin=_isadmin;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)btn3Clicked:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"KeJiChuanXin" bundle:nil];
    JiangLiGuanLiVC*vc=[board instantiateViewControllerWithIdentifier:@"JiangLiGuanLiVC"];
    //    [vc ReceiveShuJu];
        vc.isadmin=_isadmin;
    [self.navigationController pushViewController:vc animated:YES];
    
}




@end
