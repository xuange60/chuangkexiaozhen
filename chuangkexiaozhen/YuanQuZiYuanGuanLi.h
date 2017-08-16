//
//  YuanQuZiYuanGuanLi.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/16.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "CommNetWork.h"

@interface YuanQuZiYuanGuanLi : CommNetWork


/*
 
 2.16.1 查询所有资源
 http://116.228.176.34:9002/chuangke-serve/parkresource/search?start=0&length=1000
 
 查询某项资源
 http://116.228.176.34:9002/chuangke-serve/parkresource/search?start=0&length=1000categorys=办公桌椅编号
 
 [{"id":"597d819080ab5e6790d52d58","name"
 :null,"category":"办公设备编号","code":"B5","content":""},{"id":"597d818980ab5e6790d52d57","name":null,"category"
 :"办公设备编号","code":"B4","content":""},{"id":"597d818280ab5e6790d52d56","name":null,"category":"办公设备编号"
 ,"code":"B3","content":""},{"id":"597d817b80ab5e6790d52d55","name":null,"category":"办公设备编号","code":"B2"
 ,"content":""}]
 
 
 查询资产编号类型
 http://116.228.176.34:9002/chuangke-serve/parkresource/list
 
 
 2.16.2 添加资产编号
 http://116.228.176.34:9002/chuangke-serve/parkresource/save
 category	办公桌椅编号
 code	1001
 content	xxx
 resourceIds
 
 2.16.3 修改资产编号
 http://116.228.176.34:9002/chuangke-serve/parkresource/save
 category	办公设备编号
 code	***
 content	*******2121
 id	594a15f6075910c2d60d08ca
 resourceIds
 
 
 2.16.4 删除资产编号
 http://116.228.176.34:9002/chuangke-serve/parkresource/batchdelete?ids=59361922075910c2d60d078a
 {"actionid":"","result":1,"errorcode":"","desc":"","obj":null,"objid":null,"action":null,"recordsTotal"
 :0,"recordsFiltered":0,"totalPages":0}
 
 
 */



-(void)YuanQuZiYuanQuery;

-(void)YuanQuZiYuanQueryWithCategory:(NSString*)category;


-(void)YuanQuZiYuanCategoryQuery;


-(void)YuanQuZiYuanAdd:(NSDictionary*)param;

-(void)YuanQuZiYuanModify:(NSDictionary*)param;

-(void)YuanQuZiYuanDelete:(NSString*)ids;




@end
