//
//  FuHusChengZhangGuanLi.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/2.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "FuHusChengZhangGuanLi.h"

@implementation FuHusChengZhangGuanLi

/*
销售合同管理
7.7.1 销售合同查询
请求 get http://116.228.176.34:9002/chuangke-serve/market/sale/search?start=0&length=1000
响应：
[{"id":"59807c6880ab5e6790d536bf","pactName"
    :"32112","partnerLevel":"一级合作方","partnerPrice":2000.0,"benefitPrice":1.2321312E7,"tenantName":"云创智能科
    技有限公司"},{"id":"594b6f3a075910c2d60d08e6","pactName":"******","partnerLevel":"一级合作方","partnerPrice":5
    .0,"benefitPrice":1.0,"tenantName":"云创智能科技有限公司"}]
*/
-(void)XiaoShouHeTongQuery
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/market/sale/search?start=0&length=1000"];
    
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
            if (self.delegate && [self.delegate respondsToSelector:@selector(queryAllFileUp:)]) {
                [self.delegate  queryAllFileUp :result];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}




/*
7.7.2 销售合同添加
请求 post http://116.228.176.34:9002/chuangke-serve/market/sale/save
到账凭证 arrivalResourceIds	59809b8c80ab5e6790d536d1,59809b9080ab5e6790d536d2
效益凭证 benefitResourceIds	59809b8880ab5e6790d536d0
销售合同名称 pactName	销售合同1
合作方级别 partnerLevel	58c7c4364c1ac54a5ee9d6cf
合作金额 partnerPrice	10
社会效益级别 saleBenefit	594b2a07d8937c61240af528
金额级别 saleMoney	58c7c7324c1a83778c59df76
社会效益 societyBenefit	100

partnerLevel
<option value="58c7c4364c1ac54a5ee9d6cf">一级合作方</option>
<option value="58c7c4364c1ac54a5ee9d6d0">二级合作方</option>
<option value="58c7c4364c1ac54a5ee9d6d1">三级合作方</option>

saleMoney
<option value="58c7c7324c1a83778c59df76">1万</option>
<option value="58c7c7324c1a83778c59df77">10万</option>
<option value="58c7c7324c1a83778c59df78">50万</option>
<option value="58c7c7324c1a83778c59df79">100万</option>
<option value="58c7c7324c1a83778c59df7a">200万</option>
<option value="58c7c7324c1a83778c59df7b">500万</option>
<option value="58c7c7324c1a83778c59df7c">1000万</option>
<option value="58c7c7324c1a83778c59df7d">10000万</option>

saleBenefit
<option value="594b2a07d8937c61240af528">100元级别</option>
<option value="594b2a93d8937c61240af52a">1000元级别</option>
<option value="594b2aa0d8937c61240af52c">10000元级别</option>
<option value="594b2b0ad8937c61240af52e">100000元级别</option>

响应
{"actionid":"","result":1,"errorcode":"","desc":"","obj":null,"objid":null,"action":null,"recordsTotal"
    :0,"recordsFiltered":0,"totalPages":0}
*/


-(void)XiaoShouHeTongSubmit:(NSDictionary*)param
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    [parameters addEntriesFromDictionary:param];
    NSDictionary* types=[NSDictionary dictionaryWithObjectsAndKeys:@"58c7c4364c1ac54a5ee9d6cf",@"一级合作方",@"58c7c4364c1ac54a5ee9d6d0",@"二级合作方",@"58c7c4364c1ac54a5ee9d6d1",@"三级合作方", nil];
    NSString* value=[parameters objectForKey:@"partnerLevel"];
    [parameters setObject: [types objectForKey:value] forKey:@"partnerLevel"];
    
    NSDictionary* types1=[NSDictionary dictionaryWithObjectsAndKeys:@"58c7c7324c1a83778c59df76",@"1万",@"58c7c7324c1a83778c59df77",@"10万",@"58c7c7324c1a83778c59df78",@"50万",@"58c7c7324c1a83778c59df79",@"100万",@"58c7c7324c1a83778c59df7a",@"200万",@"58c7c7324c1a83778c59df7b",@"500万",@"58c7c7324c1a83778c59df7c",@"1000万",@"58c7c7324c1a83778c59df7d",@"10000万", nil];
    NSString* value1=[parameters objectForKey:@"saleMoney"];
    [parameters setObject: [types1 objectForKey:value1] forKey:@"saleMoney"];
    
    NSDictionary* types2=[NSDictionary dictionaryWithObjectsAndKeys:@"594b2a07d8937c61240af528",@"100元级别",@"594b2a93d8937c61240af52a",@"1000元级别",@"594b2aa0d8937c61240af52c",@"10000元级别",@"594b2b0ad8937c61240af52e",@"100000元级别", nil];
    NSString* value2=[parameters objectForKey:@"saleBenefit"];
    [parameters setObject: [types2 objectForKey:value2] forKey:@"saleBenefit"];
    
    
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/market/sale/save"];
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
            if (self.delegate && [self.delegate respondsToSelector:@selector(addData:)]) {
                [self.delegate addData:[NSNumber numberWithInt:result]];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}





/*
7.7.3 销售合同删除
请求 get http://116.228.176.34:9002/chuangke-serve/market/sale/deleteAll?ids=59809c7880ab5e6790d536d4
参数为销售合同id
响应 {"actionid":"","result":1,"errorcode":"","desc":"","obj":null,"objid":null,"action":null,"recordsTotal"
    :0,"recordsFiltered":0,"totalPages":0}
*/
-(void)XiaoShouHeTongDelete:(NSString *)ids
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@?ids=%@",baseurl,@"/market/sale/deleteAll",ids];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            NSLog(@"%d",result);
            //result: 1,删除成功 不等于1,失败
            if (self.delegate && [self.delegate respondsToSelector:@selector(deleteData:)]) {
                [self.delegate deleteData:[NSNumber numberWithInt:result]];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}




/*
7.7.4 销售合同文件查询
请求 get http://116.228.176.34:9002/chuangke-serve/resource/downlist/search?id=59809b9480ab5e6790d536d3&typeIndex=11
响应 [{"id":"59809b8880ab5e6790d536d0","name"
    :"warn.jpg","path":"cash/busiplan/20170801/1501629448000.jpg","date":"2017-08-01"},{"id":"59809b8c80ab5e6790d536d1"
        ,"name":"warn(1).jpg","path":"cash/busiplan/20170801/1501629452000.jpg","date":"2017-08-01"},{"id":"59809b9080ab5e6790d536d2"
            ,"name":"warn.jpg","path":"cash/busiplan/20170801/1501629456000.jpg","date":"2017-08-01"}]
*/

-(void)XiaoShouHeTongFileQuery:(NSString*)ids
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/resource/downlist/search"];
    NSLog(@"%@",url);
    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:ids,@"id",@"11",@"typeIndex", nil];
    
    [manager GET:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            NSArray* result=[jsondata objectForKey:@"obj"];
            NSLog(@"%@",result);
            //result: 保存查询到的结果
            if (self.delegate && [self.delegate respondsToSelector:@selector(queryAllFileUp:)]) {
                [self.delegate  queryAllFileUp :result];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}






/*
7.7.5 销售合同文件删除
请求 get http://116.228.176.34:9002/chuangke-serve/resource/delete?typeIndex=11&entityId=59809b9480ab5e6790d536d3&id=59809b8880ab5e6790d536d0
参数：id为文件id  entityId为销售合同id
响应：
{"actionid":"","result":1,"errorcode":null,"desc":"","obj":null,"objid":null,"action":null,"recordsTotal"
    :0,"recordsFiltered":0,"totalPages":0}
*/
-(void)XiaoShouHeTongFileDelete:(NSString*)resourceid withEntityId:(NSString*) entityId
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/resource/delete"];
    NSMutableDictionary* dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:resourceid,@"id",entityId,@"entityId",@"11",@"typeIndex", nil];
    [manager GET:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            
            
            NSLog(@"%d",result);
            //result: 1, 删除成功 不等于1,则删除失败
            if (self.delegate && [self.delegate respondsToSelector:@selector(DeleteDoubleParam:)])
            {
                [self.delegate DeleteDoubleParam:[NSNumber numberWithInt:result]];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}






/*
 纳税管理
 7.8.1 纳税管理查询
 请求 get http://116.228.176.34:9002/chuangke-serve/market/tax/search?start=0&length=1000
 响应： [{"id":"5938ee2e075910c2d60d07e7","dateType"
 :"纳税年度级别","taxPrice":4000.0,"taxType":"国税","taxResourceIds":[],"taxTarget":"金山区枫泾镇国税局","tenantName":"
 云创智能科技有限公司"}]
 */
-(void)NaShuiGuanLiQuery
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/market/sax/search?start=0&length=1000"];
    
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
            if (self.delegate && [self.delegate respondsToSelector:@selector(queryAllFileUp:)]) {
                [self.delegate  queryAllFileUp :result];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}




/*
 7.8.2 纳税管理添加
 请求 post    http://116.228.176.34:9002/chuangke-serve/market/tax/save
 参数：
 时间类别 dateType	纳税季度级别
 纳税金额级别 taxLevel	58c7c76a4c1aa99f4a904e8a
 纳税金额 taxPrice	100
 taxResourceIds	59809eeb80ab5e6790d536d7
 纳税对象 taxTarget	1111
 纳税类别 taxType	111
 
 taxLevel
 <option value="58c7c76a4c1aa99f4a904e8a">1000元级别</option>
 <option value="58c7c76a4c1aa99f4a904e8b">5000元级别</option>
 <option value="58c7c76a4c1aa99f4a904e8c">10000元级别</option>
 <option value="58c7c76a4c1aa99f4a904e8d">100000元级别</option>
 <option value="58c7c76a4c1aa99f4a904e8e">500000元级别</option>
 */
-(void)NaShuiGuanLiSubmit:(NSDictionary*)param
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    [parameters addEntriesFromDictionary:param];
    NSDictionary* types2=[NSDictionary dictionaryWithObjectsAndKeys:@"58c7c76a4c1aa99f4a904e8a",@"1000元级别",@"58c7c76a4c1aa99f4a904e8b",@"5000元级别",@"58c7c76a4c1aa99f4a904e8c",@"10000元级别",@"58c7c76a4c1aa99f4a904e8d",@"100000元级别",@"58c7c76a4c1aa99f4a904e8e",@"500000元级别", nil];
    NSString* value2=[parameters objectForKey:@"taxLevel"];
    [parameters setObject: [types2 objectForKey:value2] forKey:@"taxLevel"];
    
    
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/market/tax/save"];
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
            if (self.delegate && [self.delegate respondsToSelector:@selector(addData:)]) {
                [self.delegate addData:[NSNumber numberWithInt:result]];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}



/*
 7.8.3 纳税管理删除
 请求 get http://116.228.176.34:9002/chuangke-serve/market/tax/deleteAll?ids=59809ec380ab5e6790d536d6
 参数 纳税id
 */
-(void)NaShuiGuanLiDelete:(NSString*)ids
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@?ids=%@",baseurl,@"/market/tax/deleteAll",ids];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            NSLog(@"%d",result);
            //result: 1,删除成功 不等于1,失败
            if (self.delegate && [self.delegate respondsToSelector:@selector(deleteData:)]) {
                [self.delegate deleteData:[NSNumber numberWithInt:result]];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


/*
 7.8.4 纳税管理文件查询
 请求 get http://116.228.176.34:9002/chuangke-serve/resource/downlist/search?id=59809ef080ab5e6790d536d8&typeIndex=12
 [{"id":"59809eeb80ab5e6790d536d7","name"
 :"warn.jpg","path":"cash/busiplan/20170801/1501630315000.jpg","date":"2017-08-01"}]
 */
-(void)NaShuiGuanLiFileQuery:(NSString*)ids
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/resource/downlist/search"];
    NSLog(@"%@",url);
    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:ids,@"id",@"12",@"typeIndex", nil];
    
    [manager GET:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            NSArray* result=[jsondata objectForKey:@"obj"];
            NSLog(@"%@",result);
            //result: 保存查询到的结果
            if (self.delegate && [self.delegate respondsToSelector:@selector(queryAllFileUp:)]) {
                [self.delegate  queryAllFileUp :result];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


/*
 7.8.5 纳税管理文件删除
 请求 get http://116.228.176.34:9002/chuangke-serve/resource/delete?typeIndex=12&entityId=59809ef080ab5e6790d536d8&id=59809eeb80ab5e6790d536d7
 
 参数：id为文件id  entityId为销售合同id
 {"actionid":"","result":1,"errorcode":null,"desc":"","obj":null,"objid":null,"action":null,"recordsTotal"
 :0,"recordsFiltered":0,"totalPages":0}
 */
-(void)NaShuiGuanLiFileDelete:(NSString*)resourceid withEntityId:(NSString*) entityId
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/resource/delete"];
    NSMutableDictionary* dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:resourceid,@"id",entityId,@"entityId",@"12",@"typeIndex", nil];
    [manager GET:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            
            
            NSLog(@"%d",result);
            //result: 1, 删除成功 不等于1,则删除失败
            if (self.delegate && [self.delegate respondsToSelector:@selector(DeleteDoubleParam:)])
            {
                [self.delegate DeleteDoubleParam:[NSNumber numberWithInt:result]];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}






/*
 市场占有率
 7.9.1 市场占有率查询
 请求 get http://116.228.176.34:9002/chuangke-serve/market/market/search?start=0&length=1000
 响应 [{"id":"5938edcc075910c2d60d07e6","marketPercent"
 :"5.0%","marketDetail":"共享经济-单车出租","organizationName":"零点咨询","investigateResourceIds":[],"tenantName"
 :"云创智能科技有限公司"}]*/
-(void)ShiChangZhanYouQuery
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/market/market/search?start=0&length=1000"];
    
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
            if (self.delegate && [self.delegate respondsToSelector:@selector(queryAllFileUp:)]) {
                [self.delegate  queryAllFileUp :result];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}




/*
 7.9.2 市场占有率添加
 请求 post http://116.228.176.34:9002/chuangke-serve/market/market/save
 参数
 调查凭证 investigateResourceIds	5980a0f580ab5e6790d536d9,5980a0f980ab5e6790d536da
 细分市场 marketDetail	1111
 市场占有率 marketPercent	20
 调查机构 organizationName	1111
 市场占有率级别 percentLevel	58c7c79c4c1a0ef1bf3d5749
 
 percentLevel
 <option value="58c7c79c4c1a0ef1bf3d5749">占有率级别5%</option>
 <option value="58c7c79c4c1a0ef1bf3d574a">占有率级别20%</option>
 <option value="58c7c79c4c1a0ef1bf3d574b">占有率级别50%</option>
 <option value="58c7c79c4c1a0ef1bf3d574c">占有率级别80%</option>
 响应：{"actionid":"","result":1,"errorcode":"","desc":"","obj":null,"objid":null,"action":null,"recordsTotal"
 :0,"recordsFiltered":0,"totalPages":0}
 */
-(void)ShiChangZhanYouSubmit:(NSDictionary*)param
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    [parameters addEntriesFromDictionary:param];
    NSDictionary* types2=[NSDictionary dictionaryWithObjectsAndKeys:@"58c7c79c4c1a0ef1bf3d5749",@"占有率级别5%",@"58c7c79c4c1a0ef1bf3d574a",@"占有率级别20%",@"58c7c79c4c1a0ef1bf3d574b",@"占有率级别50%",@"58c7c79c4c1a0ef1bf3d574c",@"占有率级别80%", nil];
    NSString* value2=[parameters objectForKey:@"percentLevel"];
    [parameters setObject: [types2 objectForKey:value2] forKey:@"percentLevel"];
    
    
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/market/market/save"];
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
            if (self.delegate && [self.delegate respondsToSelector:@selector(addData:)]) {
                [self.delegate addData:[NSNumber numberWithInt:result]];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}



/*
 7.9.3 市场占有率删除
 请求 get http://116.228.176.34:9002/chuangke-serve/market/market/deleteAll?ids=5980a18a80ab5e6790d536dc
 参数 市场占有率参数id
 */
-(void)ShiChangZhanYouDelete:(NSString*)ids
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@?ids=%@",baseurl,@"/market/market/deleteAll",ids];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            NSLog(@"%d",result);
            //result: 1,删除成功 不等于1,失败
            if (self.delegate && [self.delegate respondsToSelector:@selector(deleteData:)]) {
                [self.delegate deleteData:[NSNumber numberWithInt:result]];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}





/*
 7.9.4 市场占有率文件查询
 请求 get http://116.228.176.34:9002/chuangke-serve/resource/downlist/search?id=5980a0fc80ab5e6790d536db&typeIndex=13
 参数 市场占有率id
 响应 [{"id":"5980a0f580ab5e6790d536d9","name"
 :"warn(1).jpg","path":"cash/busiplan/20170801/1501630837000.jpg","date":"2017-08-01"},{"id":"5980a0f980ab5e6790d536da"
 ,"name":"warn.jpg","path":"cash/busiplan/20170801/1501630841000.jpg","date":"2017-08-01"}]
 */
-(void)ShiChangZhanYouFileQuery:(NSString*)ids
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/resource/downlist/search"];
    NSLog(@"%@",url);
    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:ids,@"id",@"13",@"typeIndex", nil];
    
    [manager GET:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            NSArray* result=[jsondata objectForKey:@"obj"];
            NSLog(@"%@",result);
            //result: 保存查询到的结果
            if (self.delegate && [self.delegate respondsToSelector:@selector(queryAllFileUp:)]) {
                [self.delegate  queryAllFileUp :result];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}



/*
 7.9.5 市场占有率文件删除
 请求 get http://116.228.176.34:9002/chuangke-serve/resource/delete?typeIndex=13&entityId=5980a0fc80ab5e6790d536db&id=5980a0f580ab5e6790d536d9
 参数：id为文件id  entityId为记录id
 响应  {"actionid":"","result":1,"errorcode":null,"desc":"","obj":null,"objid":null,"action":null,"recordsTotal"
 :0,"recordsFiltered":0,"totalPages":0}
 */
-(void)ShiChangZhanYouFileDelete:(NSString*)resourceid withEntityId:(NSString*) entityId
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/resource/delete"];
    NSMutableDictionary* dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:resourceid,@"id",entityId,@"entityId",@"13",@"typeIndex", nil];
    [manager GET:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            
            
            NSLog(@"%d",result);
            //result: 1, 删除成功 不等于1,则删除失败
            if (self.delegate && [self.delegate respondsToSelector:@selector(DeleteDoubleParam:)])
            {
                [self.delegate DeleteDoubleParam:[NSNumber numberWithInt:result]];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}









/*
 7.10.1 人员结构查询
 请求 get http://116.228.176.34:9002/chuangke-serve/personaldistribution/search?start=0&length=1000
 响应 [{"id":"5938f21c075910c2d60d07ed","toltalPerson"
 :3,"marketPerson":1,"marketPersonPercent":"33.33%","techniquePerson":1,"techniquePersonPercent":"33.33
 %","operatePerson":1,"operatePersonPercent":"33.33%","company":"云创智能科技有限公司"}]*/

-(void)RenYuanJieGouQuery
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/personaldistribution/search?start=0&length=1000"];
    
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
            if (self.delegate && [self.delegate respondsToSelector:@selector(queryAllFileUp:)]) {
                [self.delegate  queryAllFileUp :result];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}




/*
 7.10.2 人员结构添加
 请求 post http://116.228.176.34:9002/chuangke-serve/personaldistribution/save
 市场人员数 marketPerson	1
 市场人员占比 marketPersonPercent	50.00
 运营人员数 operatePerson	2
 运营人员占比 operatePersonPercent	100.00
 resourceIds	5980a57580ab5e6790d536dd,5980a57880ab5e6790d536de
 技术人员数 techniquePerson	1
 技术人员占比 techniquePersonPercent	50.00
 总人数 toltalPerson	2
 响应：{"actionid":"","result":1,"errorcode":null,"desc":"","obj":null,"objid":null,"action":null,"recordsTotal"
 :0,"recordsFiltered":0,"totalPages":0}
 */

-(void)RenYuanJieGouSubmit:(NSDictionary*)param
{
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    [parameters addEntriesFromDictionary:param];
    
    
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/personaldistribution/save"];
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
            if (self.delegate && [self.delegate respondsToSelector:@selector(addData:)]) {
                [self.delegate addData:[NSNumber numberWithInt:result]];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}



/*
 7.10.3 人员结构删除
 请求 get http://116.228.176.34:9002/chuangke-serve/personaldistribution/batchdelete?ids=5938f21c075910c2d60d07ed
 参数为 记录id
 响应 {"actionid":"","result":1,"errorcode":"","desc":"","obj":null,"objid":null,"action":null,"recordsTotal"
 :0,"recordsFiltered":0,"totalPages":0}
 */
-(void)RenYuanJieGouDelete:(NSString*)ids
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@?ids=%@",baseurl,@"/personaldistribution/batchdelete",ids];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            NSLog(@"%d",result);
            //result: 1,删除成功 不等于1,失败
            if (self.delegate && [self.delegate respondsToSelector:@selector(deleteData:)]) {
                [self.delegate deleteData:[NSNumber numberWithInt:result]];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}



/*
 7.10.4 人员机构菜单上传的文件查询
 请求 get http://116.228.176.34:9002/chuangke-serve/resource/downlist/search?id=5980a57c80ab5e6790d536df&typeIndex=21
 响应 [{"id":"5980a57580ab5e6790d536dd","name"
 :"warn(1).jpg","path":"cash/busiplan/20170801/1501631989000.jpg","date":"2017-08-01"},{"id":"5980a57880ab5e6790d536de"
 ,"name":"warn.jpg","path":"cash/busiplan/20170801/1501631992000.jpg","date":"2017-08-01"}]
 */
-(void)RenYuanJieGouFileQuery:(NSString*)ids
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/resource/downlist/search"];
    NSLog(@"%@",url);
    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:ids,@"id",@"21",@"typeIndex", nil];
    
    [manager GET:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            NSArray* result=[jsondata objectForKey:@"obj"];
            NSLog(@"%@",result);
            //result: 保存查询到的结果
            if (self.delegate && [self.delegate respondsToSelector:@selector(queryAllFileUp:)]) {
                [self.delegate  queryAllFileUp :result];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


/*
 7.10.5 人员机构菜单上传的文件删除
 请求 get  http://116.228.176.34:9002/chuangke-serve/resource/delete?typeIndex=21&entityId=5980a57c80ab5e6790d536df&id=5980a57880ab5e6790d536de
 参数：id为文件id  entityId为记录id
 响应 {"actionid":"","result":1,"errorcode":null,"desc":"","obj":null,"objid":null,"action":null,"recordsTotal"
 :0,"recordsFiltered":0,"totalPages":0}
 */
-(void)RenYuanJieGouFileDelete:(NSString*)resourceid withEntityId:(NSString*) entityId
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/resource/delete"];
    NSMutableDictionary* dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:resourceid,@"id",entityId,@"entityId",@"21",@"typeIndex", nil];
    [manager GET:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            
            
            NSLog(@"%d",result);
            //result: 1, 删除成功 不等于1,则删除失败
            if (self.delegate && [self.delegate respondsToSelector:@selector(DeleteDoubleParam:)])
            {
                [self.delegate DeleteDoubleParam:[NSNumber numberWithInt:result]];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}












@end
