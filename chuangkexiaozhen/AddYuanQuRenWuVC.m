//
//  AddYuanQuRenWuVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/14.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "AddYuanQuRenWuVC.h"

@interface AddYuanQuRenWuVC ()

@end

@implementation AddYuanQuRenWuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"添加通告";
    self.rightbutton=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(tijiaoBtnClick:)];
    self.rightbutton.tintColor=[UIColor whiteColor];
    self.rightbutton.enabled=NO;
    self.navigationItem.rightBarButtonItem=self.rightbutton;
    _tongGao=[[YuanQuRenWuTongGao alloc]init];
    _tongGao.delegate=self;
    
    [_tongGao YuanQuRenWuParamQuery];
    
    
    //添加任务通告前，查询到任务通告参数
    /*
     users =     {
     "" = 596ffd0480ab5e6790d501a2;
     ceshi = 5981e17b80ab5e6790d53b59;
     ceshi121 = 598356e380ab5e6790d5401e;
     ceshi201701a = 59849a3280ab5e6790d54495;
     ceshigongsi = 598495bc80ab5e6790d54493;
     }
     */
    
}

-(void)afternetwork6:(id)data
{
    _dic=(NSDictionary*)data;
    
}

- (IBAction)typeBtnClick:(id)sender {
    
    NSDictionary*dic=_dic[@"category"];
    NSArray*ary=[dic allKeys];
    DuoXuanVC*vc=[[DuoXuanVC alloc]init];
    [vc setArray:ary btn:(UIButton*)sender];
    [vc setDanXuan];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)chengduBtnClick:(id)sender {
    
    NSDictionary*dic=_dic[@"levels"];
    NSArray*ary=[dic allKeys];
    
//    UIStoryboard*board=[UIStoryboard storyboardWithName:@"ZiYuanPeiZhi" bundle:nil];
//    DuoXuanVC*vc=[board instantiateViewControllerWithIdentifier:@"DuoXuanVC"];
    
    DuoXuanVC*vc=[[DuoXuanVC alloc]init];
    [vc setArray:ary btn:(UIButton*)sender];
    [vc setDanXuan];
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)personBtnClick:(id)sender {
    
    NSDictionary*dic=_dic[@"users"];
    NSArray*ary=[dic allKeys];
    
     DuoXuanVC*vc=[[DuoXuanVC alloc]init];
    [vc setArray:ary btn:(UIButton*)sender];
    [vc setDanXuan];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)shangchuanBtnClick:(id)sender {
    
    ImgeUpViewController* imgup=[[ImgeUpViewController alloc] initView];
    [imgup setNotifyName:@"ADDYUANQURENWUVCFileUp" AndTitle:@"文档上传"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getfile:) name:@"ADDYUANQURENWUVCFileUp" object:nil];
    [self.navigationController pushViewController:imgup animated:YES];
}

-(void)getfile:(id)data
{
    if(data!=nil){
        NSNotification* tmp=(NSNotification*)data;
        
       _photoIds=(NSString*)tmp.object;
    }
    
}

- (IBAction)dateBtnClick:(id)sender {
    
    UIDatePicker*picker=[[UIDatePicker alloc]initWithFrame:CGRectMake(60, 400, 300, 200)];
    picker.backgroundColor=[UIColor whiteColor];
    picker.datePickerMode=UIDatePickerModeDate;
    picker.minimumDate=[NSDate dateWithTimeIntervalSince1970:0];
    picker.maximumDate=[NSDate date];
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文
    picker.locale = locale;
    
    [self.view addSubview:picker];
    [picker addTarget:self action:@selector(pickerStart:) forControlEvents:UIControlEventValueChanged];
}
-(void)pickerStart:(UIDatePicker*)picker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:MM:ss"];
    NSString*time= [dateFormatter stringFromDate:picker.date];
    [_date setTitle:time forState:UIControlStateNormal];
    [picker removeFromSuperview];

}


- (IBAction)tijiaoBtnClick:(id)sender {
    
    /*
     添加任务通告
     参数：
     通告类型 category 整理内务
     通告内容 content xxxx
     截止时间 enddate 2017-08-14 14:38:31
     file
     紧急程度 levels 紧急
     通告主题 name ceshi
     文件id resourceIds 598ff39922637b17beb31415
     涉及人员 users 597d807680ab5e6790d52d45 users 597db39c80ab5e6790d52d6a
     workId
     */
    
    
    NSDictionary*dicC=_dic[@"users"];
   
    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
    [dic setNotNullStrObject:_zhuTi.text forKey:@"name"];
     [dic setNotNullStrObject:_typeBtn.currentTitle forKey:@"category"];
     [dic setNotNullStrObject:_chengDuBtn.currentTitle forKey:@"levels"];
    NSArray*ary=[_personBtn.currentTitle componentsSeparatedByString:@","];
    
    NSMutableArray*array=[NSMutableArray array];
    
    for (NSString*ss in ary)
    {
        NSString*value=[dicC objectNotNullForKey:ss];
        [array addObject:value];
    }
    
     [dic setNotNullObject:array forKey:@"users"];
     [dic setNotNullStrObject:_content.text forKey:@"content"];
     [dic setNotNullStrObject:_photoIds forKey:@"resourceIds"];

    [_tongGao YuanQuRenWuAdd:dic];
}

-(void)afternetwork5:(id)data
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ADDTONGGAOSCUUESS" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}




@end
