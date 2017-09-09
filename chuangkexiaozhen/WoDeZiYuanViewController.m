//
//  WoDeZiYuanViewController.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/7/30.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "WoDeZiYuanViewController.h"
#import "BussinessApi.h"
#import "ComboViewController.h"
@interface WoDeZiYuanViewController ()

@end

@implementation WoDeZiYuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"我的资源配置";
    [self woDeZiYuanPeizhiQuery];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)btnclick:(id)sender {
    UIButton* btn=(UIButton*)sender;
    NSString* datas=btn.titleLabel.text;
    if(datas!=nil && datas.length>0 && [datas containsString:@","]){
        datas=[datas stringByReplacingOccurrencesOfString:@"[" withString:@""];
        datas=[datas stringByReplacingOccurrencesOfString:@"]" withString:@""];
        NSArray* array=[datas componentsSeparatedByString:@","];
        if([array count]>1){
            ComboViewController*vc=[[ComboViewController alloc] initView];
            [vc setDatas:array];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
    
    
}






//我的资源配置
-(void)woDeZiYuanPeizhiQuery
{
    NSString* baseurl=[[NSUserDefaults standardUserDefaults] objectForKey:@"baseurl"];
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/resourceallocation/owner"];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectNotNullForKey:@"Content-Type"];
        
        if([contenttype containsString:@"html"]){
            TFHpple* doc=[[TFHpple alloc]initWithHTMLData:responseObject];
            NSArray* arrays=[doc searchWithXPathQuery:@"//input"];
            NSMutableDictionary* dic=[[NSMutableDictionary alloc] init];
            for (TFHppleElement *ele in arrays) {
                NSString * idstr=[ele objectForKey:@"name"];
                NSString* value=[ele objectForKey:@"value"];
                if(idstr!=nil && value!=nil){
                    [dic setObject:value forKey:idstr];
                }
            }
            
            
            //查询到的我的资源配置信息
            _numberOfOffice.text=[dic objectNotNullForKey:@"numberOfOffice"];
            NSString* ofoCodesstr=[dic objectNotNullForKey:@"ofoCodes"];
            [_ofoCodes setTitle:ofoCodesstr forState:UIControlStateNormal];
            if(_numberOfOffice.text==nil || _numberOfOffice.text.length==0){
                if([ofoCodesstr containsString:@"["] && [ofoCodesstr containsString:@"]"]){
                    NSUInteger num= [[ofoCodesstr componentsSeparatedByString:@","] count];
                    _numberOfOffice.text=[NSString stringWithFormat:@"%lu",(unsigned long)num];
                }
            }
            
            
            _numberOftc.text=[dic objectNotNullForKey:@"numberOftc"];
            NSString* TcCodes=[dic objectNotNullForKey:@"TcCodes"];
            [_TcCodes setTitle:[dic objectForKey:@"TcCodes"] forState:UIControlStateNormal];
            if(_numberOftc.text==nil || _numberOftc.text.length==0){
                if([TcCodes containsString:@"["] && [TcCodes containsString:@"]"]){
                    NSUInteger num= [[TcCodes componentsSeparatedByString:@","] count];
                    _numberOftc.text=[NSString stringWithFormat:@"%lu",(unsigned long)num];
                }
            }
            
            
            _numberOfoe.text=[dic objectNotNullForKey:@"numberOfoe"];
            NSString* OeCodes=[dic objectNotNullForKey:@"OeCodes"];
            [_OeCodes setTitle:[dic objectForKey:@"OeCodes"] forState:UIControlStateNormal];
            if(_numberOfoe.text==nil || _numberOfoe.text.length==0){
                if([OeCodes containsString:@"["] && [OeCodes containsString:@"]"]){
                    NSUInteger num= [[OeCodes componentsSeparatedByString:@","] count];
                    _numberOfoe.text=[NSString stringWithFormat:@"%lu",(unsigned long)num];
                }
            }
            
            
            
            _numberOfegc.text=[dic objectNotNullForKey:@"numberOfegc"];
            NSString* EgcCodes=[dic objectNotNullForKey:@"EgcCodes"];
            [_EgcCodes setTitle:[dic objectForKey:@"EgcCodes"] forState:UIControlStateNormal];
            if(_numberOfegc.text==nil || _numberOfegc.text.length==0){
                if([EgcCodes containsString:@"["] && [EgcCodes containsString:@"]"]){
                    NSUInteger num= [[EgcCodes componentsSeparatedByString:@","] count];
                    _numberOfegc.text=[NSString stringWithFormat:@"%lu",(unsigned long)num];
                }
            }
            
            
            
            _numberOfpl.text=[dic objectNotNullForKey:@"numberOfpl"];
            NSString* PlCodes=[dic objectNotNullForKey:@"PlCodes"];
            [_PlCodes setTitle:[dic objectForKey:@"PlCodes"] forState:UIControlStateNormal];
            if(_numberOfpl.text==nil || _numberOfpl.text.length==0){
                if([PlCodes containsString:@"["] && [PlCodes containsString:@"]"]){
                    NSUInteger num= [[PlCodes componentsSeparatedByString:@","] count];
                    _numberOfpl.text=[NSString stringWithFormat:@"%lu",(unsigned long)num];
                }
            }
            
            
            
            _printAccount.text=[dic objectNotNullForKey:@"printAccount"];
            _printPassword.text=[dic objectNotNullForKey:@"printPassword"];
            _name.text=[dic objectNotNullForKey:@"name"];
            _concatType.text=[dic objectNotNullForKey:@"concatType"];
            
            

            NSLog(@"%@",dic); //打印查询到的数据
            
            //字典NSMutableDictionary* dic包含了查询到的数据
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


- (IBAction)shensu:(id)sender {
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"baodaoruzhu" bundle:nil];
    ShenSuViewController*vc=[board instantiateViewControllerWithIdentifier:@"ShenSuViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)hetong:(id)sender {
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"baodaoruzhu" bundle:nil];
    DianZiHeTongViewController*vc=[board instantiateViewControllerWithIdentifier:@"DianZiHeTongViewController"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary*dic=[defaults dictionaryForKey:@"chuangkexiaozhen.userinfo"];
    vc.ids=[dic objectNotNullForKey:@"companyId"];
    [self.navigationController pushViewController:vc animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
