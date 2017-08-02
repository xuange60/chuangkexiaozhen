//
//  YuanQuFuWuShenQing.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/2.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "BussinessApi.h"

@interface YuanQuFuWuShenQing : NSObject

@property(nonatomic)int num;
@property(nonatomic,assign)id <BussinessApiDelegate> delegate;

//园区服务申请相关网络操作




/*
 8.1园区服务申请查询
 请求 get http://116.228.176.34:9002/chuangke-serve/serveapply/search?start=0&length=1000
 响应 [{"id":"5981de4280ab5e6790d53b55","serveCategory"
 :"加工服务","content":"222","tenantTitle":"云创智能科技有限公司","tenantMemberName":null,"status":"未处理"},{"id":"5981de2a80ab5e6790d53b54"
 ,"serveCategory":"物业维修","content":"1111","tenantTitle":"云创智能科技有限公司","tenantMemberName":null,"status"
 :"未处理"}]
 */

 -(void)YuanQuFuWuQuery;

/*
 8.2 园区服务申请提交
 请求 post http://116.228.176.34:9002/chuangke-serve/serveapply/save
 参数：
 服务内容	content	111
 文件id		resourceIds	5981ded080ab5e6790d53b56,5981ded080ab5e6790d53b57
 服务类型	serveCategory	加工服务
 服务类型有：物业维修 加工服务 广告服务 会议会务 企业培训 工商服务 知识产权服务 人才公寓服务 补贴福利 联谊活动 人才招聘需求
 */
 -(void)YuanQuFuWuSubmit:(NSDictionary*)param;

/*
 8.3 园区服务申请删除
 请求 get http://116.228.176.34:9002/chuangke-serve/serveapply/delete?id=5981de2a80ab5e6790d53b54
 参数 id为服务申请记录id
 */

 -(void)YuanQuFuWuDelete:(NSString*)ids;


/*
 8.4 园区服务申请文件查询
 请求 get http://116.228.176.34:9002/chuangke-serve/resource/downlist/search?id=5981de2a80ab5e6790d53b54&typeIndex=35
 参数 id为服务申请记录id
 响应 [{"id":"5981de2880ab5e6790d53b53","name"
 :"warn(1).jpg","path":"cash/busiplan/20170802/1501712040000.jpg","date":"2017-08-02"}]
 */
 -(void)YuanQuFuWuFileQuery:(NSString*)ids;

/*
 8.5 服务申请删除
 请求 http://116.228.176.34:9002/chuangke-serve/resource/delete?typeIndex=35&entityId=5981de2a80ab5e6790d53b54&id=5981de2880ab5e6790d53b53
 参数：id为文件id  entityId为记录id
 响应 {"actionid":"","result":1,"errorcode":null,"desc":"","obj":null,"objid":null,"action":null,"recordsTotal"
 :0,"recordsFiltered":0,"totalPages":0}
 */
 -(void)YuanQuFuWuFileDelete:(NSString*)resourceid withEntityId:(NSString*) entityId;



/*
 -(void)NaShuiGuanLiQuery;
 
 -(void)NaShuiGuanLiSubmit:(NSDictionary*)param;
 
 -(void)NaShuiGuanLiDelete:(NSString*)ids;
 
 -(void)NaShuiGuanLiFileQuery:(NSString*)ids;
 
 
 -(void)NaShuiGuanLiFileDelete:(NSString*)resourceid withEntityId:(NSString*) entityId;
 */

@end
