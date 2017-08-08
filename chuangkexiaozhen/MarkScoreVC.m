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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dabian=[[DaBianGuanLi alloc]init];
    _dabian.delegate=self;
    
    _photosIDS=[NSString string];
    
    self.navigationItem.title=@"添加打分详情";
    
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
    
    
    NSDictionary*dic=@{};
    
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
    
    
//    [dic  setObject:_bisaiName.text forKey:@"name"];
//    [dic setObject:_rongyuName.text forKey:@"hornerName"];
//    [dic setObject:_zuzhijigouName.text forKey:@"orgnizationUnit"];
//    [dic setObject:_rongyuName forKey:@"ownerCompetition"];
//    [dic setObject:_CompleteLevelBtn.currentTitle forKey:@"competeLevel"];
//    [dic setObject:_prizeAwardsBtn.currentTitle forKey:@"prizeAwarded"];
//    [dic setObject:_photosIDS forKey:@"resourceIds"];
    

    [_dabian DaBianPingFenSubmit:dic];
    
    
}

-(void)addData:(id)data
{
    NSNumber *num=(NSNumber*)data;
    int result=[num intValue];
    if (result==1) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ADDDABIANSUCCESS" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}











@end
