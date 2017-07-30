//
//  BiSaiGuanLiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/30.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BiSaiGuanLiVC.h"
#import "BiSaiCell.h"
#import "BussinessApi.h"
@interface BiSaiGuanLiVC ()

@end

@implementation BiSaiGuanLiVC

-(void)biSaiGuanLiQuery
{
    
    //7.1.1孵化成长管理->日常活跃度管理->比赛管理查询
    /*
     响应 	响应数据为array；如下格式
     [{"id":"5937dbe5075910c2d60d07c6","name"
     :"上海市创新创业大赛","competeLevel":"省部级比赛","prizeAwarded":"一等奖","hornerName":"********","orgnizationUnit":""
     ,"date":"2017-06-07 10:56:37","ownerCompetition":"是","score":14,"company":"云创智能科技有限公司"}]
     */

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
            
            
            _array=result;
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


-(void)ReceiveShuJu
{
    [self biSaiGuanLiQuery];

}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*str=@"BiSaiCell";
    BiSaiCell*cell=[tableView dequeueReusableCellWithIdentifier:str];
    
    if (!cell) {
        cell=[[BiSaiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    //7.1.1孵化成长管理->日常活跃度管理->比赛管理查询
    /*
     响应 	响应数据为array；如下格式
     [{"id":"5937dbe5075910c2d60d07c6","name"
     :"上海市创新创业大赛","competeLevel":"省部级比赛","prizeAwarded":"一等奖","hornerName":"********","orgnizationUnit":""
     ,"date":"2017-06-07 10:56:37","ownerCompetition":"是","score":14,"company":"云创智能科技有限公司"}]
     */

    
    NSDictionary*dic=[_array objectAtIndex:indexPath.row];
    
    cell.bisaiName.text= [dic objectForKey:@"name"];
    cell.bisaiLevel.text=[dic objectForKey:@"competeLevel"];
    cell.mingCi.text=[dic objectForKey:@"prizeAwarded"];
    cell.rongyuMingCheng.text=[dic objectForKey:@"hornerName"];
    cell.zuzhiDanWei.text=[dic objectForKey:@"orgnizationUnit"];
    cell.faqiDate.text=[dic objectForKey:@"date"];
    cell.benYuanQuzuzhi.text=[dic objectForKey:@"ownerCompetition"];
    cell.suoShuCompany.text=[dic objectForKey:@"company"];
   
    
    return cell;
}




- (IBAction)deleteBtnClicked:(id)sender forEvent:(UIEvent *)event {
    
    
    
}



- (IBAction)DownloadBtnClicked:(id)sender forEvent:(UIEvent *)event {
    
    
    
    
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
