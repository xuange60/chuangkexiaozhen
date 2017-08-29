//
//  MarkScoreVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/8.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "MarkScoreVC.h"
#import "ImgeUpViewController.h"
@interface MarkScoreVC ()

@end

@implementation MarkScoreVC
-(void)setShuJu:(NSString*)strId
{
    _strID=[NSString stringWithString:strId];
}

- (void)viewDidLoad {
    self.navigationItem.title=@"添加打分详情";
    self.rightbutton=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(TiJiao:)];
    self.rightbutton.tintColor=[UIColor whiteColor];
    self.rightbutton.enabled=NO;
    self.navigationItem.rightBarButtonItem=self.rightbutton;
    
    [super viewDidLoad];
    
    [self receiveCurrentViewController:self];
    _dabian=[[DaBianGuanLi alloc]init];
    _dabian.delegate=self;
    
    _photosIDS=[NSString string];

}


- (IBAction)selectBtnClick:(id)sender {
    
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"是",@"否", nil];
    [vc setDatas:array withBtn:sender];
    vc.navigationItem.title=@"是否同意入驻";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)FileUpFuJian:(id)sender {
    
    ImgeUpViewController* imgup=[[ImgeUpViewController alloc] initView];
    [imgup setNotifyName:@"ADDFUJIANFileUp" AndTitle:@"文档上传"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getfile:) name:@"ADDFUJIANFileUp" object:nil];
    [self.navigationController pushViewController:imgup animated:YES];
    
    
}
-(void)getfile:(id)data
{
    if(data!=nil){
        NSNotification* tmp=(NSNotification*)data;
        _photosIDS=(NSString*)tmp.object;
    }
}

- (IBAction)TiJiao:(id)sender {
    
    
    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
    
    /*
     1.3 打分及文件上传
     请求 post http://116.228.176.34:9002/chuangke-serve/reviewinfo/save
     请求参数
     是否允许接入 agreeApplyin	true
     答辩记录id  applyTreatId	597dbefb80ab5e6790d52d79
     附件 resourceIds	598887e222637b17beb2f87a,598887e622637b17beb2f87b
     reasons	与园区方向切合度
     reasons	项目创新性和独特性
     reasons	项目团队运营能力
     reasons	项目市场业务能力
     reasons	项目产品技术研发能力
     scores	80
     scores	80
     scores	80
     scores	80
     scores	80
     */
   
    NSArray*aryScore=[NSArray arrayWithObjects:_textF1.text,_textF2.text,_textF3.text,_textF4.text,_textF5.text ,nil];
    NSArray*aryName=[NSArray arrayWithObjects:@"与园区方向切合度",@"项目创新性和独特性",@"项目团队运营能力",@"项目市场业务能力",@"项目产品技术研发能力", nil];
   
   
     [dic setNotNullObject:aryScore forKey:@"scores"];
     [dic setNotNullObject:aryName forKey:@"reasons"];
    NSString* temp=_btn.currentTitle;
    NSString* agreeApplyin=nil;
    if([temp isEqualToString:@"是"]){
        agreeApplyin=@"true";
    }else{
        agreeApplyin=@"false";
    }
     [dic setNotNullStrObject: agreeApplyin forKey:@"agreeApplyin"];
     [dic setNotNullStrObject:_strID forKey:@"applyTreatId"];
     [dic setNotNullStrObject:_photosIDS forKey:@"resourceIds"];
    [_dabian DaBianPingFenAdd:dic];
    
    
}

-(void)addData:(id)data
{
    NSNumber *num=(NSNumber*)data;
    int result=[num intValue];
    if (result==1)
    {
        [self tiShiKuangDisplay:submitStr viewController:self];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ADDDABIANSUCCESS" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
}











@end
