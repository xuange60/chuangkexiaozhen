//
//  AddChanXueYanVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/1.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "AddChanXueYanVC.h"
#import "BussinessApi.h"
#import "ComboViewController.h"

@interface AddChanXueYanVC ()

@end

@implementation AddChanXueYanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"添加产学研";
    _mArray=[NSMutableArray array];//保存展示数据
    _Mstr=[NSMutableString string];//用于图片id连接
    
    _photosIDS=[NSString string];
}


- (IBAction)jiGouLevelClick:(id)sender {
    
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"合作机构一级",@"合作机构二级",@"合作机构三级", nil];
    [vc setDatas:array withBtn:sender];
    vc.navigationItem.title=@"比赛级别";
    [self.navigationController pushViewController:vc animated:YES];
}



- (IBAction)moneyLevelClick:(id)sender {
    
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"1万元以下",@"10万元",@"100万元", nil];
    [vc setDatas:array withBtn:sender];
    vc.navigationItem.title=@"合作金额级别";
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (IBAction)PingZhengBtnClick:(id)sender {
    
    ImgeUpViewController* imgup=[[ImgeUpViewController alloc] initView];
    [imgup setNotifyName:@"ADDCHANXUEYANFileUp" AndTitle:@"文档上传"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getfile:) name:@"ADDCHANXUEYANFileUp" object:nil];
    [self.navigationController pushViewController:imgup animated:YES];
    
}
-(void)getfile:(id)data
{
    if(data!=nil){
        NSNotification* tmp=(NSNotification*)data;
        _photosIDS=(NSString*)tmp.object;
    }
    
}

    
    
    
    
- (IBAction)CommitBtnClick:(id)sender {
    
    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
    
    //7.2.2 添加产学研项目
    /*
     首先要上传文件；
     提交数据时，请求地址 post http://116.228.176.34:9002/chuangke-serve/cooperatorunitInfo/save
     参数：
     文件id resourceIds
     合作机构名称 name
     合作金额级别 moneyLevel
     合作金额 money
     机构级别 level
     合作效果 effect
     合作机构级别有：
     <option value="5879d94ea5a121dff6b57a5d">合作机构一级</option>
     <option value="58be68b9cfdfdf03086a8833">合作机构三级</option>
     <option value="58c7c57bce7229367c55853e">合作机构二级</option>
     
     合作金额级别有：
     <option value="58be6e1a769052b56d66e91e">1万元以下</option>
     <option value="58be6e54769052b56d66e91f">10万元</option>
     <option value="58be6e72cfdfdf03086a8835">100万元</option>
     */

        [dic  setObject:_name.text forKey:@"name"];
        [dic setObject:_effct.text forKey:@"effect"];
        [dic setObject:_money.text forKey:@"money"];
        [dic setObject:_moneyLevel.currentTitle forKey:@"moneyLevel"];
        [dic setObject:_jiGouLevel.currentTitle forKey:@"level"];
        [dic setObject:_photosIDS forKey:@"resourceIds"];
    
        [self chanXueYanSubmit:dic];

}
    
-(void)chanXueYanSubmit:(NSDictionary*)param
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    [parameters addEntriesFromDictionary:param];
    NSDictionary* levels=[NSDictionary dictionaryWithObjectsAndKeys:@"5879d94ea5a121dff6b57a5d",@"合作机构一级",@"58be68b9cfdfdf03086a8833",@"合作机构三级",@"58c7c57bce7229367c55853e",@"合作机构二级", nil];
    NSString* value=[parameters objectForKey:@"level"];
    [parameters setObject: [levels objectForKey:value] forKey:@"level"];
    
    NSDictionary* moneyLevels=[NSDictionary dictionaryWithObjectsAndKeys:@"58be6e1a769052b56d66e91e",@"1万元以下",@"58be6e54769052b56d66e91f",@"10万元",@"58be6e72cfdfdf03086a8835",@"100万元", nil];
    NSString* value2=[parameters objectForKey:@"moneyLevel"];
    [parameters setObject: [moneyLevels objectForKey:value2] forKey:@"moneyLevel"];
    
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/cooperatorunitInfo/save"];
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            NSLog(@"%d",result);
            //result: 1,提交成功 不等于1,提交
            
            if (result==1)
            {
                
                [self.navigationController popViewControllerAnimated:YES];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"ADDCHANYEXUESCUUESS" object:nil];
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}







@end
