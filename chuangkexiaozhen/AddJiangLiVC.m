//
//  AddJiangLiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/3.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "AddJiangLiVC.h"
#import "ComboViewController.h"
#import "ImgeUpViewController.h"
@interface AddJiangLiVC ()

@end

@implementation AddJiangLiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"添加奖励管理";
    self.rightbutton=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(TiJiaoClick:)];
    self.rightbutton.tintColor=[UIColor whiteColor];
    self.rightbutton.enabled=NO;
    self.navigationItem.rightBarButtonItem=self.rightbutton;
    
    _mArray=[NSMutableArray array];//保存展示数据
    _Mstr=[NSMutableString string];//用于图片id连接
    
    _photosIDS=[NSString string];
    
    _api=[[BussinessApi alloc]init];
    _api.delegate=self;
    [self paramsQuery:@"/award/add"];
    [self receiveCurrentViewController:self];
}

- (IBAction)levelBtnClick:(id)sender {
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"一级奖励",@"二级奖励",@"三级奖励",nil];
    [vc setDatas:array withBtn:sender];
    vc.navigationItem.title=@"奖励级别";
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (IBAction)shangChuanClick:(id)sender {
    ImgeUpViewController* imgup=[[ImgeUpViewController alloc] initView];
    [imgup setNotifyName:@"ADDJIANGLIFileUp" AndTitle:@"文档上传"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getfile:) name:@"ADDJIANGLIFileUp" object:nil];
    [self.navigationController pushViewController:imgup animated:YES];
}

-(void)getfile:(id)data
{
    if(data!=nil){
        NSNotification* tmp=(NSNotification*)data;
        
        self.photosIDS=(NSString*)tmp.object;
    }
    
}


- (IBAction)TiJiaoClick:(id)sender {
    
    /*
     7.6.2 奖励管理提交
     请求 post http://116.228.176.34:9002/chuangke-serve/award/save
     参数
     名称 name	羽毛球奖
     级别 awardLevel	58c7c7094c1a775d6de79f72
     单位 awardunit	体委
     编码 code	131231
     文件id  resourceIds	597d6fcb80ab5e6790d52d2a,597d6fcf80ab5e6790d52d2b
     <option value="58c7c7094c1a775d6de79f72">一级奖励</option>
     <option value="58c7c7094c1a775d6de79f73">二级奖励</option>
     <option value="58c7c7094c1a775d6de79f74">三级奖励</option>
     */
    
    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
    
    [dic  setNotNullStrObject:_name.text forKey:@"name"];
    [dic setNotNullStrObject:_biMa.text forKey:@"code"];
    
    [dic setNotNullStrObject:[(NSDictionary*)[self.tmpparams objectForKey:@"awardLevel"] objectNotNullForKey:_levelBtn.currentTitle] forKey:@"awardLevel"];
    [dic setNotNullStrObject:_danWei.text forKey:@"awardunit"];
    
    [dic setNotNullStrObject:_photosIDS forKey:@"resourceIds"];
    
    [_api jiangLiSubmit:dic];
    
}

//提交添加数据的代理

-(void)addData:(id)data
{
    NSNumber*num=data;
    int result=[num intValue];
    if (result==1)
    {
        [self tiShiKuangDisplay:submitStr viewController:self];
        [self.navigationController popViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ADDJIANGLISCUUESS" object:nil];
    }
}

@end
