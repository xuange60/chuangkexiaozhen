//
//  QianDaoTongJi.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/15.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "CommNetWork.h"

@interface QianDaoTongJi : CommNetWork

/**
 1.查询签到统计列表

 http://116.228.176.34:9002/chuangke-serve/sign/search
 
 响应：
 [{"id":"5949ec5f075910c2d60d08c7","actualNum"
 :30,"shouldNum":40,"percent":"75.00%","remark":"","roadshowName":"123"}]
 
 路演活动：roadshowName
 实到人数: actualNum
 应到人数 shouldNum
 出勤率 percent
 备注 remark
 */
-(void)QianDaoTongJiQuery;

/**
 2.签到统计删除
 http://116.228.176.34:9002/chuangke-serve/sign/batchdelete?ids=5949ec5f075910c2d60d08c7
 参数：记录id
 */
-(void)QianDaoTongJiDelete:(NSString*)ids;

/**
 3.签到统计附件下载  typeIndex=2
 */


/**
 4.签到统计前查询所有的活动路演参数 在单选列表中使用
 返回数据为字典， 字典取到数据仍是字典
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
-(void)QianDaoTongJiQueryParam;


/**
 5.添加签到统计数据
 http://116.228.176.34:9002/chuangke-serve/sign/save
 参数： 注意选择路演活动后，需要进行参数转换
实到人数 actualNum 30
文档id otherResourceIds 5991d4e0a92b0b6e2c92dfdd
出席率 percent 75.00%
备注 remark xxx
路演活动 roadshows 593620bc075910c2d60d079a
应到人数 shouldNum 40
签到文档 signResourceIds 5991d4d8a92b0b6e2c92dfdc
 */
-(void)QianDaoTongJiAdd:(NSDictionary*) dic;



@end
