//
//  TuanDuiGuanLiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/5.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "TuanDuiGuanLiVC.h"

@interface TuanDuiGuanLiVC ()

@end

@implementation TuanDuiGuanLiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"团队成熟度考核";
    if([_isadmin isEqualToString:@"Y"]){
        self.navigationItem.title=@"行政运营材料审核";
    }
    
}
- (IBAction)btn1Clicked:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"TuanDuiYunYing" bundle:nil];
    
}

- (IBAction)btn2Clicked:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"TuanDuiYunYing" bundle:nil];
    
}
- (IBAction)btn3Clicked:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"TuanDuiYunYing" bundle:nil];
    RenYuanJieGouVC*vc=[board instantiateViewControllerWithIdentifier:@"RenYuanJieGouVC"];
    //    [vc ReceiveShuJu];
    vc.isadmin=_isadmin;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)btn4Clicked:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"TuanDuiYunYing" bundle:nil];
    
}

- (IBAction)btn5Clicked:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"TuanDuiYunYing" bundle:nil];
    
}

- (IBAction)btn6Clicked:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"TuanDuiYunYing" bundle:nil];
    
}

- (IBAction)btn7Clicked:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"TuanDuiYunYing" bundle:nil];
    
}

- (IBAction)btn8Clicked:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"TuanDuiYunYing" bundle:nil];
    
}

- (IBAction)btn9Clicked:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"TuanDuiYunYing" bundle:nil];
    
}

- (IBAction)btn10Clicked:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"TuanDuiYunYing" bundle:nil];
    
}



@end
