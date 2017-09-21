//
//  liugeCommonVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/21.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "liugeCommonVC.h"

@interface liugeCommonVC ()

@end

@implementation liugeCommonVC

-(void)setStr:(NSString*)str array:(NSArray*)ary shujuAry:(NSArray*)array
{
    _strTitle=str;
    _ary=ary;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _yunying=[[TuanDuiYunYing alloc]init];
    _yunying.delegate=self;
    
    if([_isadmin isEqualToString:@"Y"]){
        [_yunying queryDataAdmin:_strTitle];
    }else{
        [_yunying queryData:_strTitle];
    }

    self.navigationItem.title=_strTitle;
    
    UIImage *rightButtonIcon = [[UIImage imageNamed:@"add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *RightBarItem = [[UIBarButtonItem alloc] initWithImage:rightButtonIcon
                                                                     style:UIBarButtonItemStylePlain target:self action:@selector(RightBarItemClick:)];
       [self.navigationItem setRightBarButtonItem:RightBarItem];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveInfomation) name:@"COMMONVCADDSUCCESS" object:nil];
}


//左边添加比赛事件
-(void)RightBarItemClick:(UIBarButtonItem*)item
{
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"TuanDuiYunYing" bundle:nil];
    AddCommonVC*vc=[board instantiateViewControllerWithIdentifier:@"AddCommonVC"];
    vc.strTitle=_strTitle;
    [self.navigationController pushViewController:vc animated:YES];

}
-(void)receiveInfomation
{
    [_yunying queryData:_strTitle];
}

-(void)loadNetworkFinished:(id)data
{
    _array=(NSArray*)data;
    [_tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*str=@"liugeCommonCell";
    liugeCommonCell*cell=[tableView dequeueReusableCellWithIdentifier:str];
    
    cell.lab1.text=[_ary objectAtIndex:0];
    cell.lab2.text=[_ary objectAtIndex:1];
    cell.lab3.text=[_ary objectAtIndex:2];
    cell.lab4.text=[_ary objectAtIndex:3];
    cell.lab5.text=[_ary objectAtIndex:4];
    cell.lab6.text=[_ary objectAtIndex:5];

    NSDictionary*dic=[_array objectAtIndex:indexPath.row];
    
    if ([_strTitle isEqualToString:@"高学历人才"]) {
        cell.lab7.text=[dic objectNotNullForKey:@"name"];
        cell.lab8.text=[dic objectNotNullForKey:@"graduateSchool"];
        cell.lab9.text=[dic objectNotNullForKey:@"schoolLevel"];
        cell.lab10.text=[dic objectNotNullForKey:@"degreeLevel"];
        cell.lab11.text=[dic objectNotNullForKey:@"date"];
        cell.lab12.text=[dic objectNotNullForKey:@"company"];
    }
    
    if ([_strTitle isEqualToString:@"社保缴纳"]) {
        cell.lab7.text= [dic objectNotNullForKey:@"employeeNumber"];
        cell.lab8.text= [dic objectNotNullForKey:@"insureNumber"];
        cell.lab9.text=[dic objectNotNullForKey:@"companyAccount"];
        cell.lab10.text=[dic objectNotNullForKey:@"newEmployeeNames"];
        cell.lab11.text=[dic objectNotNullForKey:@"idCards"];
        cell.lab12.text=[dic objectNotNullForKey:@"company"];
    }
    
    if ([_strTitle isEqualToString:@"社会责任履行"]) {
        cell.lab7.text= [dic objectNotNullForKey:@"name"];
        cell.lab8.text=[dic objectNotNullForKey:@"type"];
        cell.lab9.text= [dic objectNotNullForKey:@"employeeNumber"];
        cell.lab10.text=[dic objectNotNullForKey:@"date"];
        cell.lab11.text=[dic objectNotNullForKey:@"company"];
        cell.lab12.hidden=YES;
    }
    
    
    if ([_strTitle isEqualToString:@"税务正规化"]) {
        cell.lab7.text= [dic objectNotNullForKey:@"taxNo"];
        cell.lab8.text=[dic objectNotNullForKey:@"accountName"];
        cell.lab9.text= [dic objectNotNullForKey:@"accountIdentityUS"];
        cell.lab10.text=[dic objectNotNullForKey:@"date"];
        cell.lab11.text=[dic objectNotNullForKey:@"company"];
        cell.lab12.hidden=YES;
    }

    if ([_strTitle isEqualToString:@"员工福利"]) {
        cell.lab7.text=[dic objectNotNullForKey:@"name"];
        cell.lab8.text=[dic objectNotNullForKey:@"totalBenefitMoney"];
        cell.lab9.text=[dic objectNotNullForKey:@"benefitPercent"];
        cell.lab10.text=[dic objectNotNullForKey:@"benefitPerson"];
        cell.lab11.text=[dic objectNotNullForKey:@"company"];
        cell.lab12.hidden=YES;
    }
    
    
    if ([_strTitle isEqualToString:@"高技能人才"]) {
        cell.lab7.text=[dic objectNotNullForKey:@"name"];
        cell.lab8.text=[dic objectNotNullForKey:@"jobTitle"];
        cell.lab9.text=[dic objectNotNullForKey:@"date"];
        cell.lab10.text=[dic objectNotNullForKey:@"company"];
        cell.lab11.hidden=YES;
        cell.lab12.hidden=YES;
    }
    if ([_strTitle isEqualToString:@"规划目标"]) {
        cell.lab7.text=[dic objectNotNullForKey:@"shortTermGoal"];
        cell.lab8.text=[dic objectNotNullForKey:@"mediumTermGoal"];
        cell.lab9.text=[dic objectNotNullForKey:@"longTermGoal"];
        cell.lab10.text=[dic objectNotNullForKey:@"company"];
        cell.lab11.hidden=YES;
        cell.lab12.hidden=YES;
    }
    if ([_strTitle isEqualToString:@"规模制度"]) {
        cell.lab7.text=[dic objectNotNullForKey:@"bylawsFileType"];
        cell.lab8.text=[dic objectNotNullForKey:@"bylawsFileName"];
        cell.lab9.text=[dic objectNotNullForKey:@"date"];
        cell.lab10.text=[dic objectNotNullForKey:@"company"];
        cell.lab11.hidden=YES;
        cell.lab12.hidden=YES;
    }
    if ([_strTitle isEqualToString:@"投融资情况"]) {
        cell.lab7.text=[dic objectNotNullForKey:@"investmentAmount"];
        cell.lab8.text=[dic objectNotNullForKey:@"investmentWheel"];
        cell.lab9.text=[dic objectNotNullForKey:@"investmentInstitutions"];
        cell.lab10.text=[dic objectNotNullForKey:@"company"];
        cell.lab11.hidden=YES;
        cell.lab12.hidden=YES;
    }

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}


- (IBAction)deteleBtnClicked:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches=[event allTouches];
    UITouch*touch=[touches anyObject];
    CGPoint point=[touch locationInView:_tableView];
    NSIndexPath*path=[_tableView indexPathForRowAtPoint:point];
    NSDictionary*dic=[_array objectAtIndex:path.row];
    NSString*strID=[dic objectForKey:@"id"];
    
    UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:nil message:@"请确认是否删除？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*action1=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction*action2=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [_yunying deleteData:strID withType:_strTitle];
    }];
    
    [alertCon addAction:action1];
    [alertCon addAction:action2];
    
    [self presentViewController:alertCon animated:YES completion:nil];
    
}

-(void)afternetwork2:(id)data
{
    [self tiShiKuangDisplay:deleteStr viewController:self];
    [_yunying queryData:_strTitle];
}


- (IBAction)detailBtnClicked:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches=[event allTouches];
    UITouch*touch=[touches anyObject];
    CGPoint point=[touch locationInView:_tableView];
    NSIndexPath*path=[_tableView indexPathForRowAtPoint:point];
    NSDictionary*dic=[_array objectAtIndex:path.row];
    
    NSString*strID=[dic objectForKey:@"id"];
    if([_isadmin isEqualToString:@"Y"]){
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"jiafencailiaoshenhe" bundle:nil];
        XingZhengShenHeVC*vc=[board instantiateViewControllerWithIdentifier:@"XingZhengShenHeVC"];
        vc.strTitle=_strTitle;
        vc.strid=strID;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [_yunying queryDetail:strID withType:_strTitle];
    }

 }
-(void)afternetwork1:(id)data
{
    _dic=(NSDictionary*)data;
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"TuanDuiYunYing" bundle:nil];
    detailCommonVC*vc=[board instantiateViewControllerWithIdentifier:@"detailCommonVC"];
    
    
    if ([_strTitle isEqualToString:@"高学历人才"]) {
        NSArray*ary=@[@"人员姓名",@"毕业学校",@"学校级别",@"学位级别",@"状态",@""];
        NSArray*array=[NSArray arrayWithObjects:
                       [_dic objectNotNullForKey:@"name"],
                       [_dic objectNotNullForKey:@"graduateSchool"],
                       [_dic objectNotNullForKey:@"schoolLevel"],
                       [_dic objectNotNullForKey:@"degreeLevel"],
                       [_dic objectNotNullForKey:@"statusRead"],
                        nil];
         [vc shuJu:ary array:array];
    }else if ([_strTitle isEqualToString:@"高技能人才"]){
        NSArray*ary=@[@"人员姓名:",@"职称级别",@"职称",@"状态",@"",@""];
        NSArray*array=[NSArray arrayWithObjects:
                       [_dic objectNotNullForKey:@"name"],
                       [_dic objectNotNullForKey:@"jobTitleLevel"],
                       [_dic objectNotNullForKey:@"jobTitle"],
                       [_dic objectNotNullForKey:@"statusRead"],
                       nil];
        [vc shuJu:ary  array:array];
    }else if ([_strTitle isEqualToString:@"规划目标"]){
        NSArray*ary=@[@"短期发展目标",@"中期发展目标",@"长期发展目标",@"状态",@"",@""];
        NSArray*array=[NSArray arrayWithObjects:
                       [_dic objectNotNullForKey:@"shortTermGoal"],
                       [_dic objectNotNullForKey:@"mediumTermGoal"],
                       [_dic objectNotNullForKey:@"longTermGoal"],
                       [_dic objectNotNullForKey:@"statusRead"],
                       nil];
        [vc shuJu:ary  array:array];
    }else if ([_strTitle isEqualToString:@"规模制度"]){
        NSArray*ary=@[@"制度文件类别",@"制度文件名称",@"状态",@"",@"",@""];
        NSArray*array=[NSArray arrayWithObjects:
                       [_dic objectNotNullForKey:@"bylawsFileType"],
                       [_dic objectNotNullForKey:@"bylawsFileName"],
                       [_dic objectNotNullForKey:@"statusRead"],
                       nil];
        [vc shuJu:ary  array:array];
    }else if ([_strTitle isEqualToString:@"投融资情况"]){
        NSArray*ary=@[@"投资金额",@"投资轮别",@"投资机构(前三)",@"状态",@"",@""];
        NSArray*array=[NSArray arrayWithObjects:
                       [_dic objectNotNullForKey:@"investmentAmount"],
                       [_dic objectNotNullForKey:@"investmentWheel"],
                       [_dic objectNotNullForKey:@"investmentInstitutions"],
                       [_dic objectNotNullForKey:@"statusRead"],
                       nil];
        [vc shuJu:ary  array:array];
    }else if ([_strTitle isEqualToString:@"社保缴纳"]){
        NSArray*ary=@[@"职工人数",@"投保人数",@"公司账号",@"新增人员名称",@"身份证号码",@"状态"];
        NSArray*array=[NSArray arrayWithObjects:
                       [_dic objectNotNullForKey:@"employeeNumber"],
                       [_dic objectNotNullForKey:@"insureNumber"],
                       [_dic objectNotNullForKey:@"companyAccount"],
                       [_dic objectNotNullForKey:@"newEmployeeNames"],
                       [_dic objectNotNullForKey:@"idCards"],
                       [_dic objectNotNullForKey:@"statusRead"],
                       nil];
        [vc shuJu:ary  array:array];
    }else if ([_strTitle isEqualToString:@"社会责任履行"]){
        NSArray*ary=@[@"履行名称",@"类别",@"参与人数",@"状态",@"",@""];
        NSArray*array=[NSArray arrayWithObjects:
                       [_dic objectNotNullForKey:@"name"],
                       [_dic objectNotNullForKey:@"type"],
                       [_dic objectNotNullForKey:@"employeeNumber"],
                       [_dic objectNotNullForKey:@"statusRead"],
                       nil];
        [vc shuJu:ary  array:array];
    }else if ([_strTitle isEqualToString:@"税务正规化"]){
        NSArray*ary=@[@"税号",@"会计名",@"会计身份US",@"状态",@"",@""];
        NSArray*array=[NSArray arrayWithObjects:
                       [_dic objectNotNullForKey:@"taxNo"],
                       [_dic objectNotNullForKey:@"accountName"],
                       [_dic objectNotNullForKey:@"accountIdentityUS"],
                       [_dic objectNotNullForKey:@"statusRead"],
                       nil];
        [vc shuJu:ary  array:array];
    }else if ([_strTitle isEqualToString:@"员工福利"]){
        NSArray*ary=@[@"福利名称",@"福利总金额",@"福利占比收入",@"福利人数",@"状态",@""];
        NSArray*array=[NSArray arrayWithObjects:
                       [_dic objectNotNullForKey:@"name"],
                       [_dic objectNotNullForKey:@"totalBenefitMoney"],
                       [_dic objectNotNullForKey:@"benefitPercent"],
                       [_dic objectNotNullForKey:@"benefitPerson"],
                       [_dic objectNotNullForKey:@"statusRead"],
                       nil];
        [vc shuJu:ary  array:array];
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)downloadBtnClicked:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches=[event allTouches];
    UITouch*touch=[touches anyObject];
    CGPoint point=[touch locationInView:_tableView];
    NSIndexPath*path=[_tableView indexPathForRowAtPoint:point];
    NSDictionary*dic=[_array objectAtIndex:path.row];
    NSString*strID=[dic objectForKey:@"id"];
    
    if ([_strTitle isEqualToString:@"高学历人才"]) {
        FilelistViewController*vc=[[FilelistViewController alloc]initView:strID withType:@"18"];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([_strTitle isEqualToString:@"高技能人才"]){
        FilelistViewController*vc=[[FilelistViewController alloc]initView:strID withType:@"19"];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([_strTitle isEqualToString:@"人员结构"]){
        
    }else if ([_strTitle isEqualToString:@"规划目标"]){
        FilelistViewController*vc=[[FilelistViewController alloc]initView:strID withType:@"15"];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([_strTitle isEqualToString:@"规模制度"]){
        FilelistViewController*vc=[[FilelistViewController alloc]initView:strID withType:@"17"];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([_strTitle isEqualToString:@"投融资情况"]){
        FilelistViewController*vc=[[FilelistViewController alloc]initView:strID withType:@"20"];
        [self.navigationController pushViewController:vc animated:YES];

    }else if ([_strTitle isEqualToString:@"社保缴纳"]){
        FilelistViewController*vc=[[FilelistViewController alloc]initView:strID withType:@"16"];
        [self.navigationController pushViewController:vc animated:YES];

    }else if ([_strTitle isEqualToString:@"社会责任履行"]){
        FilelistViewController*vc=[[FilelistViewController alloc]initView:strID withType:@"22"];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([_strTitle isEqualToString:@"税务正规化"]){
        FilelistViewController*vc=[[FilelistViewController alloc]initView:strID withType:@"23"];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([_strTitle isEqualToString:@"员工福利"]){
        FilelistViewController*vc=[[FilelistViewController alloc]initView:strID withType:@"14"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}















@end
