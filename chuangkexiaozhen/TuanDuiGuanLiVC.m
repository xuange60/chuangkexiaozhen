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
    
    
    _yunying=[[TuanDuiYunYing alloc]init];
    _yunying.delegate=self;
    
}

-(void)loadNetworkFinished:(id)data
{
    _array=(NSArray*)data;
    
}

- (IBAction)btn1Clicked:(id)sender forEvent:(UIEvent *)event {
    
    [_yunying queryData:@"高学历人才"];
    
    NSMutableArray*mAry=[NSMutableArray array];//waiceng
//    for (NSDictionary *dic in _array)
//    {
//        NSMutableArray*ary=[NSMutableArray array];//neiceng
//        
//            [ary addObject:dic[@"name"]];
//            [ary addObject:dic[@"graduateSchool"]];
//            [ary addObject:dic[@"schoolLevel"]];
//            [ary addObject:dic[@"degreeLevel"]];
//            [ary addObject:dic[@"date"]];
//            [ary addObject:dic[@"company"]];
//            [ary addObject:dic[@"id"]];
//        [mAry addObject:ary];
//    }
    
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"TuanDuiYunYing" bundle:nil];
    liugeCommonVC*vc=[board instantiateViewControllerWithIdentifier:@"liugeCommonVC"];
    [vc setStr:@"高学历人才" array:@[@"人员姓名",@"毕业学校",@"学校级别",@"学位级别",@"提交时间",@"所属公司"] shujuAry:mAry];
    
    [self.navigationController pushViewController:vc animated:YES];
}



- (IBAction)btn2Clicked:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"TuanDuiYunYing" bundle:nil];
    
}
- (IBAction)btn3Clicked:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"TuanDuiYunYing" bundle:nil];
    RenYuanJieGouVC*vc=[board instantiateViewControllerWithIdentifier:@"RenYuanJieGouVC"];
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

//6个
- (IBAction)btn7Clicked:(id)sender forEvent:(UIEvent *)event {
    
    
    
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"TuanDuiYunYing" bundle:nil];
    liugeCommonVC*vc=[board instantiateViewControllerWithIdentifier:@"liugeCommonVC"];
    [vc setStr:@"社保缴纳" array:@[@"职工人数",@"投保人数",@"公司账号",@"新增人员名称",@"身份证号",@"所属公司"] shujuAry:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
}

//5个
- (IBAction)btn8Clicked:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"TuanDuiYunYing" bundle:nil];
    liugeCommonVC*vc=[board instantiateViewControllerWithIdentifier:@"liugeCommonVC"];
    [vc setStr:@"社会责任履行" array:@[@"履行名称",@"类别",@"参与人数",@"创建时间",@"所属公司",@""] shujuAry:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)btn9Clicked:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"TuanDuiYunYing" bundle:nil];
    liugeCommonVC*vc=[board instantiateViewControllerWithIdentifier:@"liugeCommonVC"];
    [vc setStr:@"税务正规化" array:@[@"税号",@"会计名",@"会计身份US",@"创建时间",@"所属公司",@""] shujuAry:nil];
    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)btn10Clicked:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"TuanDuiYunYing" bundle:nil];
    liugeCommonVC*vc=[board instantiateViewControllerWithIdentifier:@"liugeCommonVC"];
    [vc setStr:@"员工福利" array:@[@"福利名称",@"福利总金额(元)",@"福利占比收入(%)",@"福利人数",@"所属公司",@""] shujuAry:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
}



@end
