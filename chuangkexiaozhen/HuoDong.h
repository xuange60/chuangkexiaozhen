//
//  HuoDong.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/5.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommNetWork.h"
#import "BussinessApi.h"
@interface HuoDong :CommNetWork

//@property(nonatomic,assign)id <BussinessApiDelegate> delegate;



/*
11.1 路演查询
请求 get http://116.228.176.34:9002/chuangke-serve/roadshow/search?start=0&length=1000
响应 [{"id":"596b820b80ab5e6790d4f05a","name"
    :"项目研讨会","time":"2017-07-17","theme":null,"address":"上海是","url":""},{"id":"595217ad07591472f0d1d054"
        ,"name":"三三枫会","time":"2017-06-28","theme":null,"address":"科创小镇","url":""},{"id":"594b974611c7350a7bdac16e"
            ,"name":"44","time":"2017-01-01","theme":null,"address":"44","url":""}]
*/

-(void)HuoDongLuYanQuery;


/*
11.2 路演详情查询
请求 get  http://116.228.176.34:9002/chuangke-serve/roadshow/detail?id=596b820b80ab5e6790d4f05a
响应需要根据html来解析
 {"name":"项目研讨会","address":"上海是","time":"2017-07-17","organizationList":"[上海市政府，上海]","content":"xxxxx","url":"","noticeList":["张玄2"]}
*/
-(void)HuoDongLuYanDetailQuery:(NSString*)ids;

/*
11.3 路演相关文档下载
请求 get http://116.228.176.34:9002/chuangke-serve/resource/downlist/search?id=596b820b80ab5e6790d4f05a&typeIndex=1&start=0&length=1000
*/

-(void) HuoDongParamQuery;

/*
 http://116.228.176.34:9002/chuangke-serve/roadshow/save
 
 address
 shenzhenshi
 content
 xxxxx
 name
 ceshihuodong
 noticeList
 593f4e08075910c2d60d084a
 noticeList
 5966cdcc80ab5e6790d4e34d
 organizationList
 shanghaishi,shenzhenshi
 resourceIds
 59b15cb5c0b706d51068b7d8
 time
 2017-09-10
 url
 www.baidu.com
 */
-(void)HuoDongLuYanAdd:(NSDictionary*)param;

//http://116.228.176.34:9002/chuangke-serve/roadshow/batchdelete?ids=594b974611c7350a7bdac16e
-(void)HuoDongLuYanDelete:(NSString*)ids;

@end
