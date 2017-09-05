//
//  GenZongFuWu.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/5.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BussinessApi.h"
#import "CommNetWork.h"
@interface GenZongFuWu : CommNetWork

//@property(nonatomic,assign)id <BussinessApiDelegate> delegate;

/*
 12.1 跟踪服务管理查询
 请求 get http://116.228.176.34:9002/chuangke-serve/track/search?start=0&length=1000
 响应 [{"id":"598539a980ab5e6790d5491b","title"
 :"111","content":"11111","createDate":"2017-08-05"}]
 */

-(void)GenZongFuWuQuery;

/*
 12.2 跟踪服务管理添加
 请求 post http://116.228.176.34:9002/chuangke-serve/track/save
 参数：
 内容 content	12121212
 标题 title	ceshi
 响应：{"actionid":"","result":1,"errorcode":"","desc":"","obj":null,"objid":null,"action":null,"recordsTotal"
 :0,"recordsFiltered":0,"totalPages":0}
 */

-(void)GenZongFuWuSubmit:(NSDictionary*)param;

/*
 12.3 跟踪服务删除
 请求 get  http://116.228.176.34:9002/chuangke-serve/track/delete?id=598539a980ab5e6790d5491b
 响应 {"actionid":"","result":1,"errorcode":"","desc":"","obj":null,"objid":null,"action":null,"recordsTotal"
 :0,"recordsFiltered":0,"totalPages":0}
 */

-(void)GenZongFuWuDelete:(NSString*)ids;


@end
