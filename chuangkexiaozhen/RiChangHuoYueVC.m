//
//  RiChangGuanLiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/30.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "RiChangHuoYueVC.h"

//#import "BussinessApi.h"
#import "BiSaiGuanLiVC.h"
#import "ChanXueYanGuanLiVC.h"
#import "ActiveGuanLiVC.h"
@interface RiChangHuoYueVC ()

@end

@implementation RiChangHuoYueVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title=@"日常活跃度考核";
    
}
- (IBAction)btn1Clicked:(id)sender forEvent:(UIEvent *)event {

    UIStoryboard*board=[UIStoryboard storyboardWithName:@"RiChangHuoYue" bundle:nil];
    BiSaiGuanLiVC*vc=[board instantiateViewControllerWithIdentifier:@"BiSaiGuanLiVC"];
    [vc ReceiveShuJu];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)btn2Clicked:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"RiChangHuoYue" bundle:nil];
    ChanXueYanGuanLiVC*vc=[board instantiateViewControllerWithIdentifier:@"ChanXueYanGuanLiVC"];
    [vc ReceiveShuJu];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)btn3Clicked:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"RiChangHuoYue" bundle:nil];
    ActiveGuanLiVC*vc=[board instantiateViewControllerWithIdentifier:@"ActiveGuanLiVC"];
//    [vc ReceiveShuJu];
    [self.navigationController pushViewController:vc animated:YES];
    
}









@end
