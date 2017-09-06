//
//  JiaFenCaiLiaoShenHe.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/12.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "JiaFenCaiLiaoShenHe.h"

@implementation JiaFenCaiLiaoShenHe


//0 孵化成长管理->日常活跃度管理->比赛管理查询 管理员查询
/*
 响应 	响应数据为array；如下格式
 [{"id":"5937dbe5075910c2d60d07c6","name"
 :"上海市创新创业大赛","competeLevel":"省部级比赛","prizeAwarded":"一等奖","hornerName":"********","orgnizationUnit":""
 ,"date":"2017-06-07 10:56:37","ownerCompetition":"是","score":14,"company":"云创智能科技有限公司"}]
 */
-(void)biSaiGuanLiQueryWithAdmin
{
    NSMutableArray* ary=[NSMutableArray array];
    [self biSaiGuanLiQueryWithAdmin:ary];
    
}

-(void)biSaiGuanLiQueryWithAdmin:(NSMutableArray*)ary
{
    int start=(int)[ary count];
    NSString* baseurl=[[NSUserDefaults standardUserDefaults]objectForKey:@"baseurl"];
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@%d",baseurl,@"/competition/search?length=50&role=admin&start=",start];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            NSArray* result=[jsondata objectForKey:@"obj"];
            NSLog(@"%@",result);
            if(result==nil || [result count]<10){
                //result: 保存查询到的结果
                if([result count]>0){
                    [ary addObjectsFromArray:result];
                }
                if (self.delegate && [self.delegate respondsToSelector:@selector(loadNetworkFinished:)]) {
                    [self.delegate  loadNetworkFinished :ary];
                }
            }else{
                [ary addObjectsFromArray:result];
                [self biSaiGuanLiQueryWithAdmin:ary];
            }
        }else{
            if (self.delegate && [self.delegate respondsToSelector:@selector(loadNetworkFinished:)]) {
                [self.delegate  loadNetworkFinished :ary];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadNetworkFinished:)]) {
            [self.delegate  loadNetworkFinished :ary];
        }
    }];
}





//1 孵化成长管理->日常活跃度管理->查询比赛管理是否通过审核
//http://116.228.176.34:9002/chuangke-serve/competition/detail?id=598eaa0722637b17beb30f4b
-(void)biSaiGuanLiShenHeQuery:(NSString*)ids
{
    NSString* baseurl=[[NSUserDefaults standardUserDefaults]objectForKey:@"baseurl"];
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@%@",baseurl,@"/competition/detail?id=",ids];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        if([contenttype containsString:@"html"]){//返回json格式数据
            TFHpple* doc=[[TFHpple alloc]initWithHTMLData:responseObject];
            NSArray* arrays=[doc searchWithXPathQuery:@"//input"];
            NSMutableDictionary* dic=[[NSMutableDictionary alloc] init];
            for (TFHppleElement *ele in arrays) {
                NSString * idstr=[ele objectForKey:@"name"];
                NSString* value=[ele objectForKey:@"value"];
                if(idstr!=nil && value!=nil ){
                    [dic setObject:value forKey:idstr];
                }
            }
            //result: 保存查询到的结果
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(afternetwork1:)]) {
                [self.delegate afternetwork1:dic];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


/*2孵化成长管理->日常活跃度管理->比赛管理审核
http://116.228.176.34:9002/chuangke-serve/competition/status
 请求参数：
 competeLevel 国家级比赛
 hornerName 111
 id 598eaa0722637b17beb30f4b
 memo
 name admin3
 orgnizationUnit 111
 prizeAwarded 一等奖
 score 18
 status fail
 statusRead	审核中
 */
-(void)biSaiGuanLiSubmit:(NSDictionary*)param
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    [parameters addEntriesFromDictionary:param];
    NSDictionary* competeLevels=[NSDictionary dictionaryWithObjectsAndKeys:@"58c7c2114c1a48b6fd96506a",@"国家级比赛",@"58c7c2114c1a48b6fd96506b",@"省部级比赛",@"58c7c2114c1a48b6fd96506c",@"区县级比赛",@"58c7c2114c1a48b6fd96506d",@"一般比赛", nil];
    NSString* value=[parameters objectForKey:@"competeLevel"];
    [parameters setObject: [competeLevels objectForKey:value] forKey:@"competeLevel"];
    
    NSDictionary* prizeAwardeds=[NSDictionary dictionaryWithObjectsAndKeys:@"58c7c3c44c1ae760f68a1013",@"一等奖",@"58c7c3c44c1ae760f68a1014",@"二等奖",@"58c7c3c44c1ae760f68a1015",@"三等奖", nil];
    NSString* value2=[parameters objectForKey:@"prizeAwarded"];
    [parameters setObject: [prizeAwardeds objectForKey:value2] forKey:@"prizeAwarded"];
    
    NSDictionary* statuss=[NSDictionary dictionaryWithObjectsAndKeys:@"success",@"审核通过",@"fail",@"审核不通过", nil];
    NSString* value3=[parameters objectForKey:@"status"];
    [parameters setObject: [statuss objectForKey:value3] forKey:@"status"];
    
    NSString* baseurl=[[NSUserDefaults standardUserDefaults]objectForKey:@"baseurl"];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/competition/status"];
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        int result=0;
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
             result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            NSLog(@"%d",result);
            //result: 1,提交成功 不等于1,提交
            
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(afternetwork2:)]) {
            [self.delegate afternetwork2:[NSNumber numberWithInt:result]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        if (self.delegate && [self.delegate respondsToSelector:@selector(afternetwork2:)]) {
            [self.delegate afternetwork2:[NSNumber numberWithInt:0]];
        }
    }];
    
}








//7.2.1 产学研管理查询 管理员查询
/*
 响应 [{"id":"5938cb27075910c2d60d07dd","name"
 :"111","money":3000.0,"effect":"","date":"2017-06-08 03:57:27","company":"云创智能科技有限公司"},{"id":"5938cb08075910c2d60d07db"
 ,"name":"*****","money":2.0,"effect":"","date":"2017-06-08 03:56:56","company":"云创智能科技有限公司"}]
 */
-(void)chanXueYanQueryWithAdmin
{
    NSMutableArray* ary=[NSMutableArray array];
    [self chanXueYanQueryWithAdmin:ary];
    
}

-(void)chanXueYanQueryWithAdmin:(NSMutableArray*)ary
{
    int start=(int)[ary count];
    NSString* baseurl=[[NSUserDefaults standardUserDefaults]objectForKey:@"baseurl"];
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@%d",baseurl,@"/cooperatorunitInfo/search?length=50&role=admin&start=",start];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            NSArray* result=[jsondata objectForKey:@"obj"];
            NSLog(@"%@",result);
            if(result==nil || [result count]<10){
                //result: 保存查询到的结果
                if([result count]>0){
                    [ary addObjectsFromArray:result];
                }
                if (self.delegate && [self.delegate respondsToSelector:@selector(loadNetworkFinished:)]) {
                    [self.delegate  loadNetworkFinished :ary];
                }
            }else{
                [ary addObjectsFromArray:result];
                [self chanXueYanQueryWithAdmin:ary];
            }
        }else{
            if (self.delegate && [self.delegate respondsToSelector:@selector(loadNetworkFinished:)]) {
                [self.delegate  loadNetworkFinished :ary];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadNetworkFinished:)]) {
            [self.delegate  loadNetworkFinished :ary];
        }
    }];
}


//1 孵化成长管理->日常活跃度管理->查询比赛管理是否通过审核
//http://116.228.176.34:9002/chuangke-serve/cooperatorunitInfo/detail?id=598ef60c22637b17beb30f50
-(void)chanXueYanShenHeQuery:(NSString*)ids
{
    NSString* baseurl=[[NSUserDefaults standardUserDefaults]objectForKey:@"baseurl"];
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@%@",baseurl,@"/cooperatorunitInfo/detail?id=",ids];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        if([contenttype containsString:@"html"]){//返回json格式数据
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
            //result: 保存查询到的结果
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(afternetwork1:)]) {
                [self.delegate afternetwork1:dic];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}



//7.2.2 添加产学研项目
/*
 首先要上传文件；
	提交数据时，请求地址 post http://116.228.176.34:9002/chuangke-serve/cooperatorunitInfo/save
	参数：
 effect 111
 id 598ef60c22637b17beb30f50
 level 合作机构一级
 memo
 money 300.0
 moneyLevel 1万元以下
 name ceshi2
 resourceIds
 scoreRead 1
 status success
 statusRead	审核中
 合作机构级别有：
 <option value="5879d94ea5a121dff6b57a5d">合作机构一级</option>
 <option value="58be68b9cfdfdf03086a8833">合作机构三级</option>
 <option value="58c7c57bce7229367c55853e">合作机构二级</option>
	
 合作金额级别有：
 <option value="58be6e1a769052b56d66e91e">1万元以下</option>
 <option value="58be6e54769052b56d66e91f">10万元</option>
 <option value="58be6e72cfdfdf03086a8835">100万元</option>
 */
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
    
    NSDictionary* statuss=[NSDictionary dictionaryWithObjectsAndKeys:@"success",@"审核通过",@"fail",@"审核不通过", nil];
    NSString* value3=[parameters objectForKey:@"status"];
    [parameters setObject: [statuss objectForKey:value3] forKey:@"status"];
    
    
    NSString* baseurl=[[NSUserDefaults standardUserDefaults]objectForKey:@"baseurl"];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/cooperatorunitInfo/status"];
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        int result=0;
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
             result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            NSLog(@"%d",result);
            //result: 1,提交成功 不等于1,提交

        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(afternetwork2:)]) {
            [self.delegate afternetwork2:[NSNumber numberWithInt:result]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        if (self.delegate && [self.delegate respondsToSelector:@selector(afternetwork2:)]) {
            [self.delegate afternetwork2:[NSNumber numberWithInt:0]];
        }
    }];
    
}





/*
 7.3.1 活动查询
 请求：get http://116.228.176.34:9002/chuangke-serve/activity/search?start=0&length=1000
 响应： [{"id":"5938cd4b075910c2d60d07de","name"
 :"******","activityLevel":"省市级活动","sponsor":"科创小镇","participant":3,"ownerActivity":"否","company":"云创
 智能科技有限公司","date":"2017-06-08 04:06:35"}]
 */
-(void)jiaFenCaiLiaoQuerywithAdmin:(NSString*)type
{
    NSMutableArray* ary=[NSMutableArray array];
    [self jiaFenCaiLiaoQuerywithAdmin:ary andType:type];
    
}

-(void)jiaFenCaiLiaoQuerywithAdmin:(NSMutableArray*)ary andType:(NSString*) type;
{
    int start=(int)[ary count];
    NSString* baseurl=[[NSUserDefaults standardUserDefaults]objectForKey:@"baseurl"];
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@/%@%@%d",baseurl,type,@"/search?length=50&role=admin&start=",start];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            NSArray* result=[jsondata objectForKey:@"obj"];
            NSLog(@"%@",result);
            if(result==nil || [result count]<10){
                //result: 保存查询到的结果
                if([result count]>0){
                    [ary addObjectsFromArray:result];
                }
                if (self.delegate && [self.delegate respondsToSelector:@selector(loadNetworkFinished:)]) {
                    [self.delegate  loadNetworkFinished :ary];
                }
            }else{
                [ary addObjectsFromArray:result];
                [self jiaFenCaiLiaoQuerywithAdmin:ary andType:type];
            }
        }else{
            if (self.delegate && [self.delegate respondsToSelector:@selector(loadNetworkFinished:)]) {
                [self.delegate  loadNetworkFinished :ary];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadNetworkFinished:)]) {
            [self.delegate  loadNetworkFinished :ary];
        }
    }];
}



-(void)jiaFenCaiLiaoShenHeQuery:(NSString*)ids withType:(NSString*)type
{
    NSString* baseurl=[[NSUserDefaults standardUserDefaults]objectForKey:@"baseurl"];
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@/%@%@%@",baseurl,type,@"/detail?id=",ids];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        if([contenttype containsString:@"html"]){//返回json格式数据
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
            //result: 保存查询到的结果
            
            [self.delegate afternetwork1:dic];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


-(void) jiaFenCaiLiaoShenHeSubmit:(NSDictionary*)param withType:(NSString*) type
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    [parameters addEntriesFromDictionary:param];
    NSDictionary* statuss=[NSDictionary dictionaryWithObjectsAndKeys:@"success",@"审核通过",@"fail",@"审核不通过", nil];
    NSString* value3=[parameters objectForKey:@"status"];
    [parameters setObject: [statuss objectForKey:value3] forKey:@"status"];
    
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    NSString* url=[NSString stringWithFormat:@"%@/%@%@",baseurl,type,@"/status"];
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        int result=0;
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
             result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            NSLog(@"%d",result);
            //result: 1,提交成功 不等于1,提交
            

        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(afternetwork2:)]) {
            [self.delegate afternetwork2:[NSNumber numberWithInt:result]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        if (self.delegate && [self.delegate respondsToSelector:@selector(afternetwork2:)]) {
            [self.delegate afternetwork2:[NSNumber numberWithInt:0]];
        }
    }];
    
}








@end
