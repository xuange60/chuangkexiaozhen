//
//  RiChangGuanLiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/30.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "RiChangHuoYueVC.h"
#import "BussinessApi.h"
@interface RiChangHuoYueVC ()

@end

@implementation RiChangHuoYueVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title=@"日常活跃度考核";
    
}
- (IBAction)btn1Clicked:(id)sender forEvent:(UIEvent *)event {
    
    [self biSaiGuanLiQuery];
    
}

//7.1.1孵化成长管理->日常活跃度管理->比赛管理查询
/*
 响应 	响应数据为array；如下格式
 [{"id":"5937dbe5075910c2d60d07c6","name"
 :"上海市创新创业大赛","competeLevel":"省部级比赛","prizeAwarded":"一等奖","hornerName":"********","orgnizationUnit":""
 ,"date":"2017-06-07 10:56:37","ownerCompetition":"是","score":14,"company":"云创智能科技有限公司"}]
 */
-(void)biSaiGuanLiQuery
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/competition/search?start=0&length=1000"];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            NSArray* result=[jsondata objectForKey:@"obj"];
            NSLog(@"%@",result);
            //result: 保存查询到的结果
            
        
            
            
            
            
            
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}






- (IBAction)btn2Clicked:(id)sender forEvent:(UIEvent *)event {
}
- (IBAction)btn3Clicked:(id)sender forEvent:(UIEvent *)event {
}









@end
