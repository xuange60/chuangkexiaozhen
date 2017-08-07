//
//  AddActiveVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/1.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "AddActiveVC.h"
#import "ComboViewController.h"
@interface AddActiveVC ()

@end

@implementation AddActiveVC



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"添加活动";
    _mArray=[NSMutableArray array];//保存展示数据
    _Mstr=[NSMutableString string];//用于图片id连接
    
    _photosIDS=[NSString string];
    
    _api=[[BussinessApi alloc]init];
    _api.delegate=self;
    
}


- (IBAction)ActiveLevelClick:(id)sender {
    
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"省市级活动",@"区县级活动",@"园区镇街道活动", nil];
    [vc setDatas:array withBtn:sender];
    vc.navigationItem.title=@"活动级别";
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)shangChuanClick:(id)sender {
    
    ImgeUpViewController* imgup=[[ImgeUpViewController alloc] initView];
    [imgup setNotifyName:@"ADDACTIVEFileUp" AndTitle:@"文档上传"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getfile:) name:@"ADDACTIVEFileUp" object:nil];
    [self.navigationController pushViewController:imgup animated:YES];
    
}
-(void)getfile:(id)data
{
    if(data!=nil){
        NSNotification* tmp=(NSNotification*)data;
        _photosIDS=(NSString*)tmp.object;
    }
    
}


- (IBAction)TiJiaoClick:(id)sender {
    
    /*
     7.3.2 活动添加
     请求 post http://116.228.176.34:9002/chuangke-serve/activity/save
     参数：
     活动级别 activityLevel	5879d979a5a121dff6b57a5f
     活动名称 name	展会活动
     参与人数 participant	2
     resourceIds	597d501c80ab5e6790d52d18,597d504b80ab5e6790d52d19
     主办单位 sponsor	深圳市真服
     响应：
        
     */
    

    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
    
    [dic  setObject:_activeName.text forKey:@"name"];
    [dic setObject:_renShu.text forKey:@"participant"];
    [dic setObject:_danWei.text forKey:@"sponsor"];
    [dic setObject:_activeLevelBtn.currentTitle forKey:@"activityLevel"];
    [dic setObject:_photosIDS forKey:@"resourceIds"];
    
    [_api huoDongSubmitNew:dic];

}

//提交添加数据的代理

-(void)addData:(id)data
{
    NSNumber*num=data;
    int result=[num intValue];
    if (result==1)
    {
        [self.navigationController popViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ADDACTIVESCUUESS" object:nil];
    }
}


@end
