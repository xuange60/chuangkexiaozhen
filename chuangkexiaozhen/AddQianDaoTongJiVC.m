//
//  AddQianDaoTongJiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/15.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "AddQianDaoTongJiVC.h"

@interface AddQianDaoTongJiVC ()

@end

@implementation AddQianDaoTongJiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _num1=[_shidaoNum.text intValue];
    _num2=1;
    
    self.navigationItem.title=@"添加签到";
    self.rightbutton=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(tijiao:)];
    self.rightbutton.tintColor=[UIColor whiteColor];
    self.rightbutton.enabled=NO;
    self.navigationItem.rightBarButtonItem=self.rightbutton;
    
    _qiandao=[[QianDaoTongJi alloc]init];
    _qiandao.delegate=self;
    
    [_qiandao QianDaoTongJiQueryParam];
}

-(void)afternetwork6:(id)data
{
    
    _dicM=(NSMutableDictionary*)data;

}

- (IBAction)huodongBtnClick:(id)sender {
    
    /**
     4.签到统计前查询所有的活动路演参数 在单选列表中使用
     返回数据为字典， 字典取到数据仍是字典
     {
     "roadshows" : {
     "123422" : "58e7555e11c7b2939aa7a0fa",
     "*********" : "5949ea52075910c2d60d08c6",
     "农创路演" : "593620bc075910c2d60d079a",
     "32" : "594b916c11c75eb6d41272f8",
     "扫除" : "594b8ffe11c740f6a57510b2",
     "123" : "58e7554611c7b2939aa7a0f9",
     "33" : "594b93eb11c7cca4e070230a",
     "12" : "58e75a0c11c7b2939aa7a0fb",
     "44" : "594b974611c7350a7bdac16e",
     "项目研讨会" : "596b820b80ab5e6790d4f05a",
     "122" : "58e75a4111c7b2939aa7a0fc",
     "三三枫会" : "595217ad07591472f0d1d054",
     "ff" : "594b924f11c79f358ae29fa2",
     "1234" : "594b6b9d075910c2d60d08e4",
     "ss" : "594b90c911c7dae9a86fb4b4"
     }
     }
     */

    NSDictionary*dic=[_dicM objectForKey:@"roadshows"];
    NSArray*ary=[dic allKeys];
    
    DuoXuanVC*vc=[[DuoXuanVC alloc]init];
    [vc setArray:ary btn:(UIButton*)sender];
    [vc setDanXuan];
    [vc setTitlestr:@"路演活动名称"];
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (IBAction)jiaBtn1Click:(id)sender {
    
    _num1++;
    _shidaoNum.text=[NSString stringWithFormat:@"%d",_num1];
     _bilv.text=[NSString stringWithFormat:@"%d%%",_num1/_num2];
}

- (IBAction)jianBtn1Click:(id)sender {
    _num1--;
    if (_num1<0) {
        _num1=0;
    }
    _shidaoNum.text=[NSString stringWithFormat:@"%d",_num1];
     _bilv.text=[NSString stringWithFormat:@"%d%%",_num1/_num2];
    
}

- (IBAction)jia2BtnClick:(id)sender {
    
    _num2++;
    _yingdaoNum.text=[NSString stringWithFormat:@"%d",_num2];
     _bilv.text=[NSString stringWithFormat:@"%.2d%%",_num1/_num2];
}

- (IBAction)jian2BtnClick:(id)sender {
    
    _num2--;
    if (_num2<1) {
        _num2=1;
    }
    _yingdaoNum.text=[NSString stringWithFormat:@"%d",_num2];
    
    CGFloat ff=_num1/_num2;
    
    
    _bilv.text=[NSString stringWithFormat:@"%.2f%%",ff];
    
}

- (IBAction)shangchuan1Click:(id)sender {
    
    ImgeUpViewController* imgup=[[ImgeUpViewController alloc] initView];
    [imgup setNotifyName:@"ADDQIANDAODANFileUp" AndTitle:@"文档上传"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getfile:) name:@"ADDQIANDAODANFileUp" object:nil];
    [self.navigationController pushViewController:imgup animated:YES];
}

-(void)getfile:(id)data
{
    if(data!=nil){
        NSNotification* tmp=(NSNotification*)data;
        
        _photoIds=(NSString*)tmp.object;
    }
    
}

- (IBAction)shangchuan2click:(id)sender {
    
    
}
- (IBAction)tijiao:(id)sender {
    /**
     5.添加签到统计数据
     http://116.228.176.34:9002/chuangke-serve/sign/save
     参数： 注意选择路演活动后，需要进行参数转换
     实到人数 actualNum 30
     文档id otherResourceIds 5991d4e0a92b0b6e2c92dfdd
     出席率 percent 75.00%
     备注 remark xxx
     路演活动 roadshows 593620bc075910c2d60d079a
     应到人数 shouldNum 40
     签到文档 signResourceIds 5991d4d8a92b0b6e2c92dfdc
     */

    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
    [dic setNotNullStrObject:_shidaoNum.text forKey:@"actualNum"];
    [dic setNotNullStrObject:_yingdaoNum.text forKey:@"shouldNum"];
    [dic setNotNullStrObject:_bilv.text forKey:@"percent"];
    [dic setNotNullStrObject:_beizhu.text forKey:@"remark"];
    [dic setNotNullStrObject:_photoIds forKey:@"signResourceIds"];

    [_dicM objectForKey:@"roadshows"];
    
    NSString *ss=[NSString string];
    
    [_dicM enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if ([key isEqualToString:_huodongBtn.currentTitle]) {
          __block ss=(NSString*)obj;
        }
    }];
    
    [dic setNotNullStrObject:ss forKey:@"signResourceIds"];
    
    
    [_qiandao QianDaoTongJiAdd:dic];
}
-(void)afternetwork4:(id)data
{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ADDQIANDAOSUCCESS" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"%s",__func__);
}




@end
