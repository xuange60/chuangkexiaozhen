//
//  FuHusChengZhangGuanLi.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/2.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BussinessApi.h"

@protocol FuHusChengZhangGuanLiDelegate <NSObject>

@optional
- (void)loadNetworkFinished:(id)data;//第一个界面 查询完成

-(void)deleteData:(id)data;//第一个界面 删除完成

-(void)addData:(id)data;   //第一个界面添加 完成

-(void)DeleteDoubleParam:(id)data;  //第二个界面 2个参数的 删除 完成

-(void)queryAllFileUp:(id)data;     //第二个界面的查询

-(void)XianShiPhoto:(id)data;       //第二个界面 下载 完成

-(void)selectPhotoFromKu:(id)data;  // 从图库选择照片上传完成 的回调



@end

@interface FuHusChengZhangGuanLi : NSObject

@property(nonatomic)int num;
@property(nonatomic,assign)id <FuHusChengZhangGuanLiDelegate> delegate;
//孵化成长管理相关网络操作
//孵化成长管理相关网络操作
//孵化成长管理相关网络操作
//孵化成长管理相关网络操作
//孵化成长管理相关网络操作

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
-(void)XiaoShouHeTongQuery;




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
-(void)XiaoShouHeTongSubmit:(NSDictionary*)param;


/*
 7.7.3 销售合同删除
 请求 get http://116.228.176.34:9002/chuangke-serve/market/sale/deleteAll?ids=59809c7880ab5e6790d536d4
 参数为销售合同id
 响应 {"actionid":"","result":1,"errorcode":"","desc":"","obj":null,"objid":null,"action":null,"recordsTotal"
 :0,"recordsFiltered":0,"totalPages":0}
 */
-(void)XiaoShouHeTongDelete:(NSString*)ids;

/*
 7.7.4 销售合同文件查询
 请求 get http://116.228.176.34:9002/chuangke-serve/resource/downlist/search?id=59809b9480ab5e6790d536d3&typeIndex=11
 响应 [{"id":"59809b8880ab5e6790d536d0","name"
 :"warn.jpg","path":"cash/busiplan/20170801/1501629448000.jpg","date":"2017-08-01"},{"id":"59809b8c80ab5e6790d536d1"
 ,"name":"warn(1).jpg","path":"cash/busiplan/20170801/1501629452000.jpg","date":"2017-08-01"},{"id":"59809b9080ab5e6790d536d2"
 ,"name":"warn.jpg","path":"cash/busiplan/20170801/1501629456000.jpg","date":"2017-08-01"}]
 */
-(void)XiaoShouHeTongFileQuery:(NSString*)ids;




/*
 7.7.5 销售合同文件删除
 请求 get http://116.228.176.34:9002/chuangke-serve/resource/delete?typeIndex=11&entityId=59809b9480ab5e6790d536d3&id=59809b8880ab5e6790d536d0
 参数：id为文件id  entityId为销售合同id
 响应：
 {"actionid":"","result":1,"errorcode":null,"desc":"","obj":null,"objid":null,"action":null,"recordsTotal"
 :0,"recordsFiltered":0,"totalPages":0}
 */
-(void)XiaoShouHeTongFileDelete:(NSString*)resourceid withEntityId:(NSString*) entityId;





/*
纳税管理
7.8.1 纳税管理查询
请求 get http://116.228.176.34:9002/chuangke-serve/market/tax/search?start=0&length=1000
响应： [{"id":"5938ee2e075910c2d60d07e7","dateType"
    :"纳税年度级别","taxPrice":4000.0,"taxType":"国税","taxResourceIds":[],"taxTarget":"金山区枫泾镇国税局","tenantName":"
    云创智能科技有限公司"}]
*/
-(void)NaShuiGuanLiQuery;


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
-(void)NaShuiGuanLiSubmit:(NSDictionary*)param;

/*
7.8.3 纳税管理删除
请求 get http://116.228.176.34:9002/chuangke-serve/market/tax/deleteAll?ids=59809ec380ab5e6790d536d6
参数 纳税id
*/
-(void)NaShuiGuanLiDelete:(NSString*)ids;

/*
7.8.4 纳税管理文件查询
请求 get http://116.228.176.34:9002/chuangke-serve/resource/downlist/search?id=59809ef080ab5e6790d536d8&typeIndex=12
[{"id":"59809eeb80ab5e6790d536d7","name"
    :"warn.jpg","path":"cash/busiplan/20170801/1501630315000.jpg","date":"2017-08-01"}]
*/
-(void)NaShuiGuanLiFileQuery:(NSString*)ids;

/*
7.8.5 纳税管理文件删除
请求 get http://116.228.176.34:9002/chuangke-serve/resource/delete?typeIndex=12&entityId=59809ef080ab5e6790d536d8&id=59809eeb80ab5e6790d536d7

参数：id为文件id  entityId为销售合同id
{"actionid":"","result":1,"errorcode":null,"desc":"","obj":null,"objid":null,"action":null,"recordsTotal"
    :0,"recordsFiltered":0,"totalPages":0}
*/
-(void)NaShuiGuanLiFileDelete:(NSString*)resourceid withEntityId:(NSString*) entityId;


/*
市场占有率
7.9.1 市场占有率查询
请求 get http://116.228.176.34:9002/chuangke-serve/market/market/search?start=0&length=1000
响应 [{"id":"5938edcc075910c2d60d07e6","marketPercent"
    :"5.0%","marketDetail":"共享经济-单车出租","organizationName":"零点咨询","investigateResourceIds":[],"tenantName"
    :"云创智能科技有限公司"}]*/
 -(void)ShiChangZhanYouQuery;

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
-(void)ShiChangZhanYouSubmit:(NSDictionary*)param;

/*
7.9.3 市场占有率删除
请求 get http://116.228.176.34:9002/chuangke-serve/market/market/deleteAll?ids=5980a18a80ab5e6790d536dc
参数 市场占有率参数id
*/
-(void)ShiChangZhanYouDelete:(NSString*)ids;


/*
7.9.4 市场占有率文件查询
请求 get http://116.228.176.34:9002/chuangke-serve/resource/downlist/search?id=5980a0fc80ab5e6790d536db&typeIndex=13
参数 市场占有率id
响应 [{"id":"5980a0f580ab5e6790d536d9","name"
    :"warn(1).jpg","path":"cash/busiplan/20170801/1501630837000.jpg","date":"2017-08-01"},{"id":"5980a0f980ab5e6790d536da"
        ,"name":"warn.jpg","path":"cash/busiplan/20170801/1501630841000.jpg","date":"2017-08-01"}]
*/
-(void)ShiChangZhanYouFileQuery:(NSString*)ids;


/*
7.9.5 市场占有率文件删除
请求 get http://116.228.176.34:9002/chuangke-serve/resource/delete?typeIndex=13&entityId=5980a0fc80ab5e6790d536db&id=5980a0f580ab5e6790d536d9
参数：id为文件id  entityId为记录id
响应  {"actionid":"","result":1,"errorcode":null,"desc":"","obj":null,"objid":null,"action":null,"recordsTotal"
    :0,"recordsFiltered":0,"totalPages":0}
*/
-(void)ShiChangZhanYouFileDelete:(NSString*)resourceid withEntityId:(NSString*) entityId;






/*
7.10.1 人员结构查询
请求 get http://116.228.176.34:9002/chuangke-serve/personaldistribution/search?start=0&length=1000
响应 [{"id":"5938f21c075910c2d60d07ed","toltalPerson"
    :3,"marketPerson":1,"marketPersonPercent":"33.33%","techniquePerson":1,"techniquePersonPercent":"33.33
    %","operatePerson":1,"operatePersonPercent":"33.33%","company":"云创智能科技有限公司"}]*/

 -(void)RenYuanJieGouQuery;
    
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

-(void)RenYuanJieGouSubmit:(NSDictionary*)param;

/*
7.10.3 人员结构删除
请求 get http://116.228.176.34:9002/chuangke-serve/personaldistribution/batchdelete?ids=5938f21c075910c2d60d07ed
参数为 记录id
响应 {"actionid":"","result":1,"errorcode":"","desc":"","obj":null,"objid":null,"action":null,"recordsTotal"
    :0,"recordsFiltered":0,"totalPages":0}
*/
-(void)RenYuanJieGouDelete:(NSString*)ids;

/*
7.10.4 人员机构菜单上传的文件查询
请求 get http://116.228.176.34:9002/chuangke-serve/resource/downlist/search?id=5980a57c80ab5e6790d536df&typeIndex=21
响应 [{"id":"5980a57580ab5e6790d536dd","name"
    :"warn(1).jpg","path":"cash/busiplan/20170801/1501631989000.jpg","date":"2017-08-01"},{"id":"5980a57880ab5e6790d536de"
        ,"name":"warn.jpg","path":"cash/busiplan/20170801/1501631992000.jpg","date":"2017-08-01"}]
*/
-(void)RenYuanJieGouFileQuery:(NSString*)ids;


/*
7.10.5 人员机构菜单上传的文件删除
请求 get  http://116.228.176.34:9002/chuangke-serve/resource/delete?typeIndex=21&entityId=5980a57c80ab5e6790d536df&id=5980a57880ab5e6790d536de
参数：id为文件id  entityId为记录id
响应 {"actionid":"","result":1,"errorcode":null,"desc":"","obj":null,"objid":null,"action":null,"recordsTotal"
    :0,"recordsFiltered":0,"totalPages":0}
*/
-(void)RenYuanJieGouFileDelete:(NSString*)resourceid withEntityId:(NSString*) entityId;





















/*
 -(void)NaShuiGuanLiQuery;

-(void)NaShuiGuanLiSubmit:(NSDictionary*)param;

-(void)NaShuiGuanLiDelete:(NSString*)ids;

-(void)NaShuiGuanLiFileQuery:(NSString*)ids;


-(void)NaShuiGuanLiFileDelete:(NSString*)resourceid withEntityId:(NSString*) entityId;
 */



@end
