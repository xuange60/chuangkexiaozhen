//
//  ChengGuoGenZong.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/20.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "ChengGuoGenZong.h"

@implementation ChengGuoGenZong


/*
 2.19.1 成果跟踪查询
 [{
 createDate = "2017-08-20 10:07:00";
 id = 59995f44a92b0b6e2c92fb6d;
 name = 1111;
 }]
 http://116.228.176.34:9002/chuangke-serve/report/search?start=0&length=1000
 */

-(void)ChengGuoGenZongQuery
{
    [super querylistWithRole:@"" andRelativeUrl:@"/report/search"];
}

/*
 2.19.2 成果跟踪添加时参数查询
 http://116.228.176.34:9002/chuangke-serve/report/add
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
-(void)ChengGuoGenZongParamQuery
{
    [super queryParamMapwithRelativeUrl:@"/report/add"];
}

/*
 2.19.3 成果跟踪提交
 http://116.228.176.34:9002/chuangke-serve/report/save
 name	1111
 resourceIds
 roadshows	58e7554611c7b2939aa7a0f9
 */
-(void)ChengGuoGenZongAdd:(NSDictionary*)param
{
    [super addWithData:param andRelativeUrl:@"/report/save"];
}

/*
 2.19.4 相关文档下载
 typeIndex	4
 */

/*
 2.19.5 成果删除
 http://116.228.176.34:9002/chuangke-serve/report/batchdelete?ids=594a0d29075910c2d60d08c9
 */
-(void)ChengGuoGenZongDelete:(NSString*)ids
{
    [super deleteWithId:ids andRelativeUrl:@"/report/batchdelete"];
}






@end
