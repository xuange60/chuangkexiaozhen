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
//6个
- (IBAction)btn1Clicked:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"TuanDuiYunYing" bundle:nil];
    liugeCommonVC*vc=[board instantiateViewControllerWithIdentifier:@"liugeCommonVC"];
    [vc setStr:@"高学历人才" array:@[@"人员姓名",@"毕业学校",@"学校级别",@"学位级别",@"提交时间",@"所属公司"] shujuAry:nil];
    [self.navigationController pushViewController:vc animated:YES];
}


//4个
- (IBAction)btn2Clicked:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"TuanDuiYunYing" bundle:nil];
    liugeCommonVC*vc=[board instantiateViewControllerWithIdentifier:@"liugeCommonVC"];
    NSArray*ary=@[@"人员姓名",@"具体名称",@"提交时间",@"所属公司",@"",@""];
    [vc setStr:@"高技能人才" array:ary shujuAry:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
//8个
- (IBAction)btn3Clicked:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"TuanDuiYunYing" bundle:nil];
    RenYuanJieGouVC*vc=[board instantiateViewControllerWithIdentifier:@"RenYuanJieGouVC"];
    vc.isadmin=_isadmin;
    [self.navigationController pushViewController:vc animated:YES];
}
//4个
- (IBAction)btn4Clicked:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"TuanDuiYunYing" bundle:nil];
    liugeCommonVC*vc=[board instantiateViewControllerWithIdentifier:@"liugeCommonVC"];
    NSArray*ary=@[@"短期发展目标",@"中期发展目标",@"长期发展目标",@"所属公司",@"",@""];
    [vc setStr:@"规划目标" array:ary shujuAry:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)btn5Clicked:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"TuanDuiYunYing" bundle:nil];
    liugeCommonVC*vc=[board instantiateViewControllerWithIdentifier:@"liugeCommonVC"];
    NSArray*ary=@[@"制度文件类别",@"制度文件名称",@"创建时间",@"所属公司",@"",@""];
    [vc setStr:@"规模制度" array:ary shujuAry:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)btn6Clicked:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"TuanDuiYunYing" bundle:nil];
    liugeCommonVC*vc=[board instantiateViewControllerWithIdentifier:@"liugeCommonVC"];
    NSArray*ary=@[@"投资金额(万)",@"投资轮别",@"投资机构",@"所属公司",@"",@""];
    [vc setStr:@"投融资情况" array:ary shujuAry:nil];
    [self.navigationController pushViewController:vc animated:YES];
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
