//
//  AddCommonVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/21.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "AddCommonVC.h"

@interface AddCommonVC ()

@end

@implementation AddCommonVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _yunying=[[TuanDuiYunYing alloc]init];
    _yunying.delegate=self;
    
    [_yunying queryParam:_strTitle];
    
    if ([_strTitle isEqualToString:@"高学历人才"])
    {
        _lab1.text=@"人员名称";
        _lab2.text=@"毕业学校";
        _lab3.hidden=YES;
        _lab4.hidden=YES;
        _lab5.hidden=YES;
        _textF3.hidden=YES;
        _textF4.hidden=YES;
        _textF5.hidden=YES;
        _lab6.text=@"学校级别";
        _lab7.text=@"学位级别";
    }else if ([_strTitle isEqualToString:@"社保缴纳"]){
        _lab1.text=@"职工人数:";
        _lab2.text=@"投保人数";
        _lab3.text=@"公司账号";
        _lab4.text=@"新增人员名称";
        _lab5.text=@"身份证号码";
        
        _lab6.hidden=YES;
        _lab7.hidden=YES;
        _btn1.hidden=YES;
        _btn2.hidden=YES;
        _btn11.hidden=YES;
        _btn12.hidden=YES;
        
    }else if ([_strTitle isEqualToString:@"社会责任履行"]){
        _lab1.text=@"履行名称";
        _lab2.text=@"参与人数";
        
        _lab3.hidden=YES;
        _textF3.hidden=YES;
        _lab4.hidden=YES;
        _textF4.hidden=YES;
        _lab5.hidden=YES;
        _textF5.hidden=YES;
        
        _lab6.text=@"类别";
        _lab7.hidden=YES;
        _btn2.hidden=YES;
        _btn12.hidden=YES;
    }else if ([_strTitle isEqualToString:@"税务正规化"]){
        _lab1.text=@"税号";
        _lab2.text=@"会计名";
        _lab3.text=@"身份证号";
        
        _lab4.hidden=YES;
        _textF4.hidden=YES;
        _lab5.hidden=YES;
        _textF5.hidden=YES;
        _lab6.hidden=YES;
        _lab7.hidden=YES;
        
        _btn1.hidden=YES;
        _btn11.hidden=YES;
        _btn2.hidden=YES;
        _btn12.hidden=YES;
        
        _fujian.hidden=YES;
        _chuanBtn.hidden=YES;
    }else if ([_strTitle isEqualToString:@"员工福利"]){
        _lab1.text=@"福利名称";
        _lab2.text=@"福利总金额";
        _lab3.text=@"福利占比收入";
        _lab4.text=@"福利人数";
       
        _lab5.hidden=YES;
        _textF5.hidden=YES;
        _lab6.hidden=YES;
        _lab7.hidden=YES;
        
        _btn1.hidden=YES;
        _btn11.hidden=YES;
        _btn2.hidden=YES;
        _btn12.hidden=YES;
    }else if ([_strTitle isEqualToString:@"高技能人才"]){
        _lab1.text=@"人员姓名";
        _lab2.text=@"职称";
        
        _lab3.hidden=YES;
        _textF3.hidden=YES;
        _lab4.hidden=YES;
        _textF4.hidden=YES;
        _lab5.hidden=YES;
        _textF5.hidden=YES;
        
        _lab6.text=@"职称级别";
        
        _lab7.hidden=YES;
        _btn2.hidden=YES;
        _btn12.hidden=YES;
    }else if ([_strTitle isEqualToString:@"规划目标"]){
        _lab1.text=@"短期发展目标";
        _lab2.text=@"中期发展目标";
        _lab3.text=@"长期发展目标";
        
        _lab4.hidden=YES;
        _textF4.hidden=YES;
        _lab5.hidden=YES;
        _textF5.hidden=YES;
        
        _lab6.hidden=YES;
        _btn1.hidden=YES;
        _btn11.hidden=YES;
        _lab7.hidden=YES;
        _btn2.hidden=YES;
        _btn12.hidden=YES;
    }else if ([_strTitle isEqualToString:@"规模制度"]){
        _lab1.text=@"制度文件名称";
        
        _lab2.hidden=YES;
        _textF2.hidden=YES;
        _lab3.hidden=YES;
        _textF3.hidden=YES;
        _lab4.hidden=YES;
        _textF4.hidden=YES;
        _lab5.hidden=YES;
        _textF5.hidden=YES;
        
        _lab6.text=@"制度文件类别";
        _lab7.hidden=YES;
        _btn2.hidden=YES;
        _btn12.hidden=YES;
    }else if ([_strTitle isEqualToString:@"投融资情况"]){
        _lab1.text=@"投资金额";
        
        _lab2.text=@"投资机构(前三)";
        _lab3.hidden=YES;
        _lab4.hidden=YES;
        
        _lab5.hidden=YES;
        _textF5.hidden=YES;
        
        _lab6.text=@"投资轮别";
        _lab7.hidden=YES;
        _btn2.hidden=YES;
        _btn12.hidden=YES;
    }

    self.navigationItem.title=@"添加";
    self.rightbutton=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(tijiao:)];
    self.rightbutton.tintColor=[UIColor whiteColor];
    self.rightbutton.enabled=NO;
    self.navigationItem.rightBarButtonItem=self.rightbutton;

    [self receiveCurrentViewController:self];
}

-(void)afternetwork6:(id)data
{
    _dic=(NSMutableDictionary*)data;
}

- (IBAction)shangchuan:(id)sender {
    ImgeUpViewController* imgup=[[ImgeUpViewController alloc] initView];
    [imgup setNotifyName:@"ADDCOMMONFileUp" AndTitle:@"文档上传"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getfile:) name:@"ADDCOMMONFileUp" object:nil];
    [self.navigationController pushViewController:imgup animated:YES];
}

-(void)getfile:(id)data
{
    if(data!=nil){
        NSNotification* tmp=(NSNotification*)data;
        self.photosIDS=(NSString*)tmp.object;
    }
    
}

- (IBAction)btn1Click:(id)sender {
    
    if ([_strTitle isEqualToString:@"高学历人才"])
    {
    NSDictionary*dic=_dic[@"schoolLevel"];
    NSArray*keyAry=[dic allKeys];
    DuoXuanVC*vc=[[DuoXuanVC alloc]init];
    [vc setDanXuan];
    [vc setArray:keyAry btn:(UIButton*)sender];
    [self.navigationController pushViewController:vc animated:YES];
    }else if ([_strTitle isEqualToString:@"社会责任履行"]){
        NSArray*ary=@[@"公益活动",@"慈善募捐",@"培训",@"其他"];
        DuoXuanVC*vc=[[DuoXuanVC alloc]init];
        [vc setDanXuan];
        [vc setArray:ary btn:(UIButton*)sender];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([_strTitle isEqualToString:@"高技能人才"]){
        NSDictionary*dic=_dic[@"jobTitleLevel"];
        NSArray*ary=[dic allKeys];
        DuoXuanVC*vc=[[DuoXuanVC alloc]init];
        [vc setDanXuan];
        [vc setArray:ary btn:(UIButton*)sender];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([_strTitle isEqualToString:@"规模制度"]){
        NSDictionary*dic=_dic[@"bylawsFileType"];
        NSArray*ary=[dic allKeys];
        DuoXuanVC*vc=[[DuoXuanVC alloc]init];
        [vc setDanXuan];
        [vc setArray:ary btn:(UIButton*)sender];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([_strTitle isEqualToString:@"投融资情况"]){
        NSDictionary*dic=_dic[@"investmentWheel"];
        NSArray*ary=[dic allKeys];
        DuoXuanVC*vc=[[DuoXuanVC alloc]init];
        [vc setDanXuan];
        [vc setArray:ary btn:(UIButton*)sender];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (IBAction)btn2Click:(id)sender {
    
    if ([_strTitle isEqualToString:@"高学历人才"])
    {
    NSDictionary*dic=_dic[@"degreeLevel"];
    NSArray*keyAry=[dic allKeys];
    DuoXuanVC*vc=[[DuoXuanVC alloc]init];
    [vc setDanXuan];
    [vc setArray:keyAry btn:(UIButton*)sender];
    [self.navigationController pushViewController:vc animated:YES];
    }
}

- (IBAction)tijiao:(id)sender {
    
    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
    if ([_strTitle isEqualToString:@"高学历人才"])
    {
     [dic setNotNullObject:_textF1.text forKey:@"name"];
     [dic setNotNullObject:_textF2.text forKey:@"graduateSchool"];
     [dic setNotNullObject:_photosIDS  forKey:@"resourceIds"];
     NSString*str1=[_dic[@"schoolLevel"] objectForKey:_btn1.currentTitle];
     NSString*str2=[_dic[@"degreeLevel"] objectForKey:_btn2.currentTitle];
     [dic setNotNullObject:str1 forKey:@"schoolLevel"];
     [dic setNotNullObject:str2 forKey:@"degreeLevel"];
    }else if ([_strTitle isEqualToString:@"社保缴纳"]){
//        typeIndex	16
//        
//        添加时参数
//        公司账号 companyAccount	xxx
//        职工人数 employeeNumber	2
//        身份证号 idCards	121342142112
//        投保人数 insureNumber	2
//        职工姓名 newEmployeeNames	小明
//        resourceIds	、
        [dic setNotNullStrObject:_textF1.text forKey:@"employeeNumber"];
        [dic setNotNullStrObject:_textF2.text forKey:@"insureNumber"];
        [dic setNotNullStrObject:_photosIDS  forKey:@"resourceIds"];
        [dic setNotNullStrObject:_textF3.text forKey:@"companyAccount"];
        [dic setNotNullStrObject:_textF4.text forKey:@"newEmployeeNames"];
        [dic setNotNullStrObject:_textF5.text forKey:@"idCards"];
    }else if ([_strTitle isEqualToString:@"社会责任履行"]){
//        添加时参数
//        参加人数 employeeNumber	2
//        活动名称 name	asdsa
//        resourceIds
//        活动类型 type	慈善募捐、
        
        [dic setNotNullStrObject:_textF1.text forKey:@"name"];
        [dic setNotNullStrObject:_textF2.text forKey:@"employeeNumber"];
        [dic setNotNullStrObject:_photosIDS  forKey:@"resourceIds"];
        [dic setNotNullStrObject:_btn1.currentTitle forKey:@"type"];
    } else if ([_strTitle isEqualToString:@"税务正规化"]){
//        添加时参数
//        会计证书 accountIdentityUS	23434523453
//        会计名 accountName	小红
//        resourceIds
//        税号 taxNo	24789237489ew
        [dic setNotNullStrObject:_textF1.text forKey:@"taxNo"];
        [dic setNotNullStrObject:_textF2.text forKey:@"accountName"];
        [dic setNotNullStrObject:_photosIDS  forKey:@"resourceIds"];
        [dic setNotNullStrObject:_textF3.text forKey:@"accountIdentityUS"];
    }else if ([_strTitle isEqualToString:@"员工福利"]){
//        添加时参数
//        福利占收入比 benefitPercent	50
//        福利人数 benefitPerson	3
//        福利名称 name	福利
//        resourceIds
//        福利金额 totalBenefitMoney	30000

        [dic setNotNullStrObject:_textF1.text forKey:@"name"];
        [dic setNotNullStrObject:_textF2.text forKey:@"totalBenefitMoney"];
        [dic setNotNullStrObject:_photosIDS  forKey:@"resourceIds"];
        [dic setNotNullStrObject:_textF3.text forKey:@"benefitPercent"];
        [dic setNotNullStrObject:_textF4.text forKey:@"benefitPerson"];
    }else if ([_strTitle isEqualToString:@"高技能人才"]){
//        添加时参数
//        职称 jobTitle	1级
//        职称级别 jobTitleLevel	58c7c83e4c1aca850999b3d8
//        人员姓名 name	小红
//        resourceIds
        [dic setNotNullStrObject:_textF1.text forKey:@"name"];
        [dic setNotNullStrObject:_textF2.text forKey:@"jobTitle"];
        [dic setNotNullStrObject:_photosIDS  forKey:@"resourceIds"];
        NSString*str=[_dic[@"jobTitleLevel"]objectForKey:_btn1.currentTitle];
        [dic setNotNullObject:str forKey:@"jobTitleLevel"];
    }else if ([_strTitle isEqualToString:@"规划目标"]){
//        添加时参数
//        longTermGoal	1000万
//        mediumTermGoal	100万
//        resourceIds
//        shortTermGoal	10万
        [dic setNotNullStrObject:_textF1.text forKey:@"shortTermGoal"];
        [dic setNotNullStrObject:_textF2.text forKey:@"mediumTermGoal"];
        [dic setNotNullStrObject:_photosIDS  forKey:@"resourceIds"];
        [dic setNotNullStrObject:_textF3.text forKey:@"longTermGoal"];
    }else if ([_strTitle isEqualToString:@"规模制度"]){
//        添加时参数
//        制度文件名称 bylawsFileName	工商证书
//        制度文件类别 bylawsFileType	工商
//        resourceIds

        [dic setNotNullStrObject:_textF1.text forKey:@"bylawsFileName"];
        [dic setNotNullStrObject:_btn1.currentTitle forKey:@"bylawsFileType"];
        [dic setNotNullStrObject:_photosIDS  forKey:@"resourceIds"];
    }else if ([_strTitle isEqualToString:@"投融资情况"]){
        
//        添加数据： 此时提交时investmentInstitutions需要传数组
//        注意 提交融资情况 http://116.228.176.34:9002/chuangke-serve/investmentandfinancing/save
//        投资金额 investmentAmount	300000
//        投资机构1 investmentInstitutions	111
//        投资机构2 investmentInstitutions	222
//        投资机构3 investmentInstitutions	333
//        投资轮次 investmentWheel	A
//        resourceIds

        [dic setNotNullStrObject:_textF1.text forKey:@"investmentAmount"];
        NSArray*ary=[NSArray arrayWithObjects:_textF2.text,_textF3.text,_textF4.text, nil];
        [dic setObject:ary forKey:@"investmentInstitutions"];
        [dic setNotNullStrObject:_btn1.currentTitle forKey:@"investmentWheel"];
        [dic setNotNullStrObject:_photosIDS  forKey:@"resourceIds"];
    }

    
    [_yunying addData:dic withType:_strTitle];
}

-(void)afternetwork4:(id)data
{
    [self tiShiKuangDisplay:submitStr viewController:self];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"COMMONVCADDSUCCESS" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}










@end
