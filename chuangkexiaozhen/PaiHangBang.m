//
//  PaiHangBang.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/5.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "PaiHangBang.h"

@implementation PaiHangBang


/*
 13.1 综合能力排行
 请求 get http://116.228.176.34:9002/chuangke-serve/tenantscore/search?start=0&length=1000&lable=colligateAbility
 响应 [{"id":"5937757d075910c2d60d07bf","name"
 :"云创智能科技有限公司","score":49556,"description":"初创团队","materialType":null},{"id":"58e5eab219eb64c4e63875f3"
 ,"name":"上海匠睿智能科技有限公司","score":1877,"description":"小微企业","materialType":null}]
 */

-(void)ZongHeNengLiQuery
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/tenantscore/search?start=0&length=1000&lable=colligateAbility"];
    
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
            if (self.delegate && [self.delegate respondsToSelector:@selector(loadNetworkFinished:)]) {
                [self.delegate  loadNetworkFinished :result];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

/*
 13.2 综合能力排行得分详情
 请求 get http://116.228.176.34:9002/chuangke-serve/tenantscore/detail/search?start=0&length=1000&tenantId=5937757d075910c2d60d07bd&lable=colligateAbility
 响应 [{"id":"5938f00e075910c2d60d07ea","name"
 :"纳税","score":4,"description":null,"materialType":null},{"id":"5937e2ee075910c2d60d07c9","name":"***
 *****","score":1,"description":null,"materialType":null},{"id":"5937de76075910c2d60d07c7","name":"上海
 市创新创业大赛","score":14,"description":null,"materialType":null},{"id":"5937757d075910c2d60d07c0","name":"
 评审打分","score":0,"description":null,"materialType":null}]
 /tenantscore/detail/search?start=0&length=1000&lable=colligateAbility&tenantId=
 */
-(void)ZongHeNengLiDetailQuery:(NSString*)ids
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@%@",baseurl,@"/tenantscore/detail/search?start=0&length=1000&lable=colligateAbility&tenantId=",ids];
    
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
            if (self.delegate && [self.delegate respondsToSelector:@selector(loadNetworkFinished:)]) {
                [self.delegate  loadNetworkFinished :result];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}



/*
 13.3 日活跃度排名查询
 http://116.228.176.34:9002/chuangke-serve/tenantscore/search?start=0&length=1000&lable=dayAbility
 响应：[{"id":"58e5eab219eb64c4e63875f3","name"
 :"上海匠睿智能科技有限公司","score":16,"description":"小微企业","materialType":null},{"id":"5937757d075910c2d60d07bf"
 ,"name":"云创智能科技有限公司","score":14,"description":"初创团队","materialType":null}]
 */
-(void)RiHuoYueQuery
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/tenantscore/search?start=0&length=1000&lable=dayAbility"];
    
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
            if (self.delegate && [self.delegate respondsToSelector:@selector(loadNetworkFinished:)]) {
                [self.delegate  loadNetworkFinished :result];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}



/*
 13.4 日活跃度得分详情
 http://116.228.176.34:9002/chuangke-serve/tenantscore/detail/search?start=0&length=1000&tenantId=58e5eab219eb64c4e63875f1&lable=dayAbility
 [{"id":"5952174307591472f0d1d053","name"
 :"上海第二工业大学","score":4,"description":null,"materialType":"产学研管理(横向)"},{"id":"59103d8511c7338ca3bea97d"
 ,"name":"2017-04-27考勤","score":-5,"description":null,"materialType":null},{"id":"59030cd111c73966cecf010d"
 ,"name":"2017-04-27考勤","score":-5,"description":null,"materialType":null}]
 */
-(void)RiHuoYueDelatiQuery:(NSString*)ids
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@%@",baseurl,@"/tenantscore/detail/search?start=0&length=1000&lable=dayAbility&tenantId=",ids];
    
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
            if (self.delegate && [self.delegate respondsToSelector:@selector(loadNetworkFinished:)]) {
                [self.delegate  loadNetworkFinished :result];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


/*
 13.5 科技创新能力排行
 http://116.228.176.34:9002/chuangke-serve/tenantscore/search?start=0&length=1000&lable=scienceAbility
 [{"id":"58e5eab219eb64c4e63875f3","name"
 :"上海匠睿智能科技有限公司","score":6,"description":"小微企业","materialType":null},{"id":"593618a1075910c2d60d0786"
 ,"name":"上海云创智能科技有限公司","score":1,"description":"初创团队","materialType":null}]
 */
-(void)KeJiChuangXinQuery
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/tenantscore/search?start=0&length=1000&lable=scienceAbility"];
    
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
            if (self.delegate && [self.delegate respondsToSelector:@selector(loadNetworkFinished:)]) {
                [self.delegate  loadNetworkFinished :result];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


/*
 13.6 科技创新能力评分详情
 http://116.228.176.34:9002/chuangke-serve/tenantscore/detail/search?start=0&length=1000&lable=scienceAbility&tenantId=58e5eab219eb64c4e63875f1
 [{"id":"58fd7cc319eb8cbffbb87ba2","name"
 :"匠睿DP-SMART身份识别和特征分析智能内容切换展示软件","score":1,"description":null,"materialType":null},{"id":"58fd7cb719eb8cbffbb87ba1"
 ,"name":"匠睿智能灌溉水肥植保一体化综合管理软件","score":1,"description":null,"materialType":null}]
 */
-(void)KeJiChuangXinDetailQuery:(NSString*)ids
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@%@",baseurl,@"/tenantscore/detail/search?start=0&length=1000&lable=scienceAbility&tenantId=",ids];
    
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
            if (self.delegate && [self.delegate respondsToSelector:@selector(loadNetworkFinished:)]) {
                [self.delegate  loadNetworkFinished :result];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

/*
 13.7 市场业务能力排行
 http://116.228.176.34:9002/chuangke-serve/tenantscore/search?start=0&length=1000&lable=marketAbility
 [{"id":"596b8e1f80ab5e6790d4f062","name"
 :"测试公司3","score":0,"description":"加速企业","materialType":null},{"id":"596b8e6980ab5e6790d4f066","name"
 :"测试公司3","score":0,"description":"加速企业","materialType":null}]
 */
-(void)ShiChangPaiHangQuery
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/tenantscore/search?start=0&length=1000&lable=marketAbility"];
    
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
            if (self.delegate && [self.delegate respondsToSelector:@selector(loadNetworkFinished:)]) {
                [self.delegate  loadNetworkFinished :result];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


/*
 13.8 市场业务能力评分详情
 http://116.228.176.34:9002/chuangke-serve/tenantscore/detail/search?start=0&length=1000&lable=marketAbility&tenantId=58e5eab219eb64c4e63875f1
 [{"id":"58fff6e011c7bb9f6129aab9","name"
 :"金山景区税管局","score":4,"description":null,"materialType":"纳税管理"},{"id":"58ff0db111c7ad65b6b58605","name"
 :"金山区景峰税局","score":1,"description":null,"materialType":null}]
 */
-(void)ShiChangPaiHangDetailQuery:(NSString*)ids
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@%@",baseurl,@"/tenantscore/detail/search?start=0&length=1000&lable=marketAbility&tenantId=",ids];
    
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
            if (self.delegate && [self.delegate respondsToSelector:@selector(loadNetworkFinished:)]) {
                [self.delegate  loadNetworkFinished :result];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}



/*
 13.9 行政运营能力排行
 http://116.228.176.34:9002/chuangke-serve/tenantscore/search?start=0&length=1000&lable=manageAbility
 [{"id":"5937757d075910c2d60d07bf","name"
 :"云创智能科技有限公司","score":50037,"description":"初创团队","materialType":null},{"id":"58e5eab219eb64c4e63875f3"
 ,"name":"上海匠睿智能科技有限公司","score":90,"description":"小微企业","materialType":null}]
 */
-(void)XingZhengYunYingQuery
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/tenantscore/search?start=0&length=1000&lable=manageAbility"];
    
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
            if (self.delegate && [self.delegate respondsToSelector:@selector(loadNetworkFinished:)]) {
                [self.delegate  loadNetworkFinished :result];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}



/*
 13.10 行政运营能力评分详情
 http://116.228.176.34:9002/chuangke-serve/tenantscore/detail/search?start=0&length=1000&lable=manageAbility&tenantId=58e5eab219eb64c4e63875f1
 [{"id":"58ff1c5411c70428580fdd56","name"
 :"back","score":4,"description":null,"materialType":"高技能人才"},{"id":"58ff016f19eb8cbffbb87bd3","name"
 :null,"score":1,"description":null,"materialType":null}]
 */
-(void)XingZhengYunYingDetailQuery:(NSString*)ids
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@%@",baseurl,@"/tenantscore/detail/search?start=0&length=1000&lable=manageAbility&tenantId=",ids];
    
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
            if (self.delegate && [self.delegate respondsToSelector:@selector(loadNetworkFinished:)]) {
                [self.delegate  loadNetworkFinished :result];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}










@end
