//
//  XingZhengShenHeVC.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/22.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "XingZhengShenHeVC.h"

@interface XingZhengShenHeVC ()

@end

@implementation XingZhengShenHeVC


-(void)shuJu:(NSArray*)ary   array:(NSArray*)array
{
    _ary=ary;
    _array=array;
    _lab1.text=_ary[0];
    _lab2.text=_ary[1];
    _lab3.text=_ary[2];
    _lab4.text=_ary[3];
    _lab5.text=_ary[4];
    _lab6.text=_ary[5];
    
    
    if (_array.count==6) {
        _lab11.text=_array[0];
        _lab12.text=_array[1];
        _lab13.text=_array[2];
        _lab14.text=_array[3];
        _lab15.text=_array[4];
        _lab16.text=_array[5];
    }else if (_array.count==5){
        _lab11.text=_array[0];
        _lab12.text=_array[1];
        _lab13.text=_array[2];
        _lab14.text=_array[3];
        _lab15.text=_array[4];
        _lab16.hidden=YES;
    }else if (_array.count==4){
        _lab11.text=_array[0];
        _lab12.text=_array[1];
        _lab13.text=_array[2];
        _lab14.text=_array[3];
        _lab15.hidden=YES;
        _lab16.hidden=YES;
    }else if (_array.count==3){
        _lab11.text=_array[0];
        _lab12.text=_array[1];
        _lab13.text=_array[2];
        _lab14.hidden=YES;
        _lab15.hidden=YES;
        _lab16.hidden=YES;
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"审核";
    _tuanduiyunying=[[TuanDuiYunYing alloc] init];
    _tuanduiyunying.delegate=self;
    [self query];
    

}


- (IBAction)approvecomboclick:(id)sender {
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"审核通过",@"审核不通过", nil];
    [vc setDatas:array withBtn:sender];
    vc.navigationItem.title=@"审核";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)approvesubmitclick:(id)sender {
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    [dic setDictionary:_data];
    [dic setNotNullStrObject: _approvecombo.currentTitle forKey:@"status"];
    [dic setNotNullStrObject: @"" forKey:@"memo"];
    //modify
    [_tuanduiyunying shenpiData:dic withType:_strTitle];
}


-(void) afternetwork7:(id)data
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)query
{
    [_tuanduiyunying queryDetail:_strid withType:_strTitle];
}




-(void)afternetwork1:(id)data
{
    NSDictionary* _dic=(NSDictionary*)data;
    _data=_dic;
    NSString* score=[_dic objectNotNullForKey:@"score"];
    if(score==nil || [score length]<1){
        score=[_dic objectNotNullForKey:@"scoreRead"];
    }
    NSString* statusRead=[_dic objectNotNullForKey:@"statusRead"];
    if([statusRead isEqualToString:@"审核中"] ){
        [_approveview setHidden:NO];
    }

    if ([_strTitle isEqualToString:@"高学历人才"]) {
        NSArray*ary=@[@"人员姓名",@"毕业学校",@"学校级别",@"学位级别",@"状态",@"分数"];
        NSArray*array=[NSArray arrayWithObjects:
                       [_dic objectNotNullForKey:@"name"],
                       [_dic objectNotNullForKey:@"graduateSchool"],
                       [_dic objectNotNullForKey:@"schoolLevel"],
                       [_dic objectNotNullForKey:@"degreeLevel"],
                       [_dic objectNotNullForKey:@"statusRead"],
                       score,
                       nil];


        [self shuJu:ary array:array];
    }else if ([_strTitle isEqualToString:@"高技能人才"]){
        NSArray*ary=@[@"人员姓名:",@"职称级别",@"职称",@"状态",@"分数",@""];

        NSArray*array=[NSArray arrayWithObjects:
                       [_dic objectNotNullForKey:@"name"],
                       [_dic objectNotNullForKey:@"jobTitleLevel"],
                       [_dic objectNotNullForKey:@"jobTitle"],
                       [_dic objectNotNullForKey:@"statusRead"],
                       score,
                       nil];
        [self shuJu:ary  array:array];
    }else if ([_strTitle isEqualToString:@"规划目标"]){
        NSArray*ary=@[@"短期发展目标",@"中期发展目标",@"长期发展目标",@"状态",@"分数",@""];
        NSArray*array=[NSArray arrayWithObjects:
                       [_dic objectNotNullForKey:@"shortTermGoal"],
                       [_dic objectNotNullForKey:@"mediumTermGoal"],
                       [_dic objectNotNullForKey:@"longTermGoal"],
                       [_dic objectNotNullForKey:@"statusRead"],
                       score,
                       nil];
        [self shuJu:ary  array:array];
    }else if ([_strTitle isEqualToString:@"规模制度"]){
        NSArray*ary=@[@"制度文件类别",@"制度文件名称",@"状态",@"分数",@"",@""];
        NSArray*array=[NSArray arrayWithObjects:
                       [_dic objectNotNullForKey:@"bylawsFileType"],
                       [_dic objectNotNullForKey:@"bylawsFileName"],
                       [_dic objectNotNullForKey:@"statusRead"],
                       score,
                       nil];
        [self shuJu:ary  array:array];
    }else if ([_strTitle isEqualToString:@"投融资情况"]){
        NSArray*ary=@[@"投资金额",@"投资轮别",@"投资机构(前三)",@"状态",@"分数",@""];
        NSArray*array=[NSArray arrayWithObjects:
                       [_dic objectNotNullForKey:@"investmentAmount"],
                       [_dic objectNotNullForKey:@"investmentWheel"],
                       [_dic objectNotNullForKey:@"investmentInstitutions"],
                       [_dic objectNotNullForKey:@"statusRead"],
                       score,
                       nil];
        [self shuJu:ary  array:array];
    }else if ([_strTitle isEqualToString:@"社保缴纳"]){
        NSArray*ary=@[@"职工人数",@"公司账号",@"新增人员名称",@"身份证号码",@"状态",@"分数"];
        NSArray*array=[NSArray arrayWithObjects:
                       [_dic objectNotNullForKey:@"employeeNumber"],
                       [_dic objectNotNullForKey:@"companyAccount"],
                       [_dic objectNotNullForKey:@"newEmployeeNames"],
                       [_dic objectNotNullForKey:@"idCards"],
                       [_dic objectNotNullForKey:@"statusRead"],
                       score,
                       nil];
        [self shuJu:ary  array:array];
    }else if ([_strTitle isEqualToString:@"社会责任履行"]){
        NSArray*ary=@[@"履行名称",@"类别",@"参与人数",@"状态",@"分数",@""];
        NSArray*array=[NSArray arrayWithObjects:
                       [_dic objectNotNullForKey:@"name"],
                       [_dic objectNotNullForKey:@"type"],
                       [_dic objectNotNullForKey:@"employeeNumber"],
                       [_dic objectNotNullForKey:@"statusRead"],
                       score,
                       nil];
        [self shuJu:ary  array:array];
    }else if ([_strTitle isEqualToString:@"税务正规化"]){
        NSArray*ary=@[@"税号",@"会计名",@"会计身份US",@"状态",@"分数",@""];
        NSArray*array=[NSArray arrayWithObjects:
                       [_dic objectNotNullForKey:@"taxNo"],
                       [_dic objectNotNullForKey:@"accountName"],
                       [_dic objectNotNullForKey:@"accountIdentityUS"],
                       [_dic objectNotNullForKey:@"statusRead"],
                       score,
                       nil];
        [self shuJu:ary  array:array];
    }else if ([_strTitle isEqualToString:@"员工福利"]){
        NSArray*ary=@[@"福利名称",@"福利总金额",@"福利占比收入",@"福利人数",@"状态",@"分数"];
        NSArray*array=[NSArray arrayWithObjects:
                       [_dic objectNotNullForKey:@"name"],
                       [_dic objectNotNullForKey:@"totalBenefitMoney"],
                       [_dic objectNotNullForKey:@"benefitPercent"],
                       [_dic objectNotNullForKey:@"benefitPerson"],
                       [_dic objectNotNullForKey:@"statusRead"],
                       score,
                       nil];
        [self shuJu:ary  array:array];
    }
    

}

@end
