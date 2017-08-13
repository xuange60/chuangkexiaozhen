//
//  AddBiSaiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/31.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "AddBiSaiVC.h"
#import "ComboViewController.h"
#import "BussinessApi.h"
@interface AddBiSaiVC ()

@end

@implementation AddBiSaiVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title=@"添加比赛";
     _mArray=[NSMutableArray array];//保存展示数据
     _Mstr=[NSMutableString string];//用于图片id连接
    _photosIDS=[NSString string];
    
    _api=[[BussinessApi alloc]init];
    _api.delegate=self;
}

// 比赛级别选择的事件处理
- (IBAction)BiSaiLevelCkicl:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"国家级比赛",@"省部级比赛",@"区县级比赛",@"一般比赛", nil];
    [vc setDatas:array withBtn:sender];
    vc.navigationItem.title=@"比赛级别";
    [self.navigationController pushViewController:vc animated:YES];

}

//获奖名次选择的事件处理
- (IBAction)MingCiCkick:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"一等奖",@"二等奖",@"三等奖", nil];
    [vc setDatas:array withBtn:sender];
    vc.navigationItem.title=@"获奖名次";
    [self.navigationController pushViewController:vc animated:YES];
    
}

//是否本园区组织
- (IBAction)ShiFouYuanQuZuZhiCiCkick:(id)sender forEvent:(UIEvent *)event {
    
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"是",@"否", nil];
    [vc setDatas:array withBtn:sender];
    vc.navigationItem.title=@"是否本园区组织";
    [self.navigationController pushViewController:vc animated:YES];
    
}

//上传图片的事件处理
- (IBAction)shangChuanClick:(id)sender {

    ImgeUpViewController* imgup=[[ImgeUpViewController alloc] initView];
    [imgup setNotifyName:@"ADDBISAIFileUp" AndTitle:@"文档上传"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getfile:) name:@"ADDBISAIFileUp" object:nil];
    [self.navigationController pushViewController:imgup animated:YES];


}
-(void)getfile:(id)data
{
    if(data!=nil){
        NSNotification* tmp=(NSNotification*)data;
        _photosIDS=(NSString*)tmp.object;
    }
    
}


- (IBAction)commitedClick:(id)sender {
    
    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
    
    //7.1.2孵化成长管理->日常活跃度管理->比赛管理添加
    /*
     请求参数：
     比赛级别 competeLevel
     荣誉名称 hornerName
     比赛名称 name
     组织单位 orgnizationUnit
     是否本园区组织 ownerCompetition
     获奖名次 prizeAwarded
     上传图片的资源id resourceIds
     */

    
    [dic  setObject:_bisaiName.text forKey:@"name"];
    [dic setObject:_rongyuName.text forKey:@"hornerName"];
    [dic setObject:_zuzhijigouName.text forKey:@"orgnizationUnit"];
    [dic setObject:_ownerCompetition.currentTitle forKey:@"ownerCompetition"];
    [dic setObject:_CompleteLevelBtn.currentTitle forKey:@"competeLevel"];
    [dic setObject:_prizeAwardsBtn.currentTitle forKey:@"prizeAwarded"];
    [dic setObject:_photosIDS forKey:@"resourceIds"];
    
    [_api biSaiGuanLiSubmit:dic];
    
   
}

-(void)addData:(id)data
{
    NSNumber *num=(NSNumber*)data;
    int result=[num intValue];
    if (result==1) {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ADDBISAISUCCESS" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
        
    }
}









@end
