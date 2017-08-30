//
//  AddXiangMuVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/3.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "AddXiangMuVC.h"
#import "ComboViewController.h"
@interface AddXiangMuVC ()

@end

@implementation AddXiangMuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"添加项目管理";
    self.rightbutton=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(TiJiaoClick:)];
    self.rightbutton.tintColor=[UIColor whiteColor];
    self.rightbutton.enabled=NO;
    self.navigationItem.rightBarButtonItem=self.rightbutton;
    
    _mArray=[NSMutableArray array];//保存展示数据
    _Mstr=[NSMutableString string];//用于图片id连接
    
    _photosIDS=[NSString string];
    
    _api=[[BussinessApi alloc]init];
    _api.delegate=self;
    
}

- (IBAction)levelBtnClick:(id)sender {
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"国家级",@"省部级",@"区县级",@"一般",nil];
    [vc setDatas:array withBtn:sender];
    vc.navigationItem.title=@"级别";
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (IBAction)shangChuanClick:(id)sender {
    ImgeUpViewController* imgup=[[ImgeUpViewController alloc] initView];
    [imgup setNotifyName:@"ADDXIANGMUFileUp" AndTitle:@"文档上传"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getfile:) name:@"ADDXIANGMUFileUp" object:nil];
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
     7.5.2 项目提交
     请求 post http://116.228.176.34:9002/chuangke-serve/project/save
     参数：项目编码 code	1231231231
     项目单位 competentunit	12123
     项目名称 name	test1
     项目级别 projectLevel	58c7c6c24c1a3bea9c268d9d
     项目文件 resourceIds	597d6d7280ab5e6790d52d26,597d6d7480ab5e6790d52d27
     <option value="58c7c6c24c1a3bea9c268d9d">国家级</option>
     <option value="58c7c6c24c1a3bea9c268d9e">省部级</option>
     <option value="58c7c6c24c1a3bea9c268d9f">区县级</option>
     <option value="58c7c6c24c1a3bea9c268da0">一般</option>
     */
    
    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
    
    [dic  setNotNullStrObject:_name.text forKey:@"name"];
    [dic setNotNullStrObject:_biMa.text forKey:@"code"];
    [dic setNotNullStrObject:_levelBtn.currentTitle forKey:@"projectLevel"];
    [dic setNotNullStrObject:_danWei.text forKey:@"competentunit"];
    
    [dic setNotNullStrObject:_photosIDS forKey:@"resourceIds"];
    
    [_api xiangMuSubmit:dic];
    
}

//提交添加数据的代理

-(void)addData:(id)data
{
    NSNumber*num=data;
    int result=[num intValue];
    if (result==1)
    {
        [self.navigationController popViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ADDXIANGMUSCUUESS" object:nil];
    }
}

@end
