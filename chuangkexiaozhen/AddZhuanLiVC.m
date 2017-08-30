//
//  AddZhuanLiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/3.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "AddZhuanLiVC.h"

@interface AddZhuanLiVC ()

@end

@implementation AddZhuanLiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"添加专利知识";
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

- (IBAction)leiBieBtnClick:(id)sender {
    
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"软件著作权",@"集成电路布图设计",@"商标",@"实用新型专利",@"发明专利",@"文学著作权", nil];
    [vc setDatas:array withBtn:sender];
    vc.navigationItem.title=@"类型";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)shangChuanClick:(id)sender {
    ImgeUpViewController* imgup=[[ImgeUpViewController alloc] initView];
    [imgup setNotifyName:@"ADDZHUANLIFileUp" AndTitle:@"文档上传"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getfile:) name:@"ADDZHUANLIFileUp" object:nil];
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
     7.4.2 专业知识产权新增
     请求 post  http://116.228.176.34:9002/chuangke-serve/knowledge/save
     参数
     产权编码 code	123131312
     知识名称 name	test
     文件 	 resourceIds	597d60d680ab5e6790d52d21,597d60d980ab5e6790d52d22
     知识类型 type	58be754fcfdfdf03086a8837
     <option value="58be754fcfdfdf03086a8837">软件著作权</option>
     <option value="58be756fcfdfdf03086a8839">集成电路布图设计</option>
     <option value="58be7588cfdfdf03086a883b">商标</option>
     <option value="58be75a9cfdfdf03086a883d">实用新型专利</option>
     <option value="58be75c8cfdfdf03086a883f">发明专利</option>
     <option value="58be75e3cfdfdf03086a8841">文学著作权</option>
     */    
    
    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
    
    [dic  setNotNullStrObject:_name.text forKey:@"name"];
    [dic setNotNullStrObject:_biMa.text forKey:@"code"];
    [dic setNotNullStrObject:_leiBieBtn.currentTitle forKey:@"type"];
    [dic setNotNullStrObject:_photosIDS forKey:@"resourceIds"];
    
    [_api zhuanYeZhiShiSubmit:dic];
    
}

//提交添加数据的代理

-(void)addData:(id)data
{
    NSLog(@"%s",__func__);
    NSNumber*num=data;
    int result=[num intValue];
    if (result==1)
    {
        [self.navigationController popViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ADDZHUANLISCUUESS" object:nil];
    }
    
    NSLog(@"%s",__func__);
}

@end
