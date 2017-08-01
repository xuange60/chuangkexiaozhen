//
//  BussinessApi.h
//  TestDemo
//
//  Created by zhangxuan on 17/7/23.
//  Copyright © 2017年 zhangxuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"
#import "GDataXMLNode.h"
#import "TFHpple.h"
#import "TFHppleElement.h"
#import "XPathQuery.h"
#import "AFHTTPSessionManager.h"


@protocol BussinessApiDelegate<NSObject>

@optional
- (void)loadNetworkFinished:(id)data;//网络数据加载完成

-(void)deleteData:(id)data;

-(void)addData:(id)data;

@end


@interface BussinessApi : NSObject
@property(nonatomic)int num;
@property(nonatomic,assign)id <BussinessApiDelegate> delegate;



//1.用户登录
-(void) loginWithName:(NSString*) name andPwd:(NSString*) pwd;

//2.用户退出
-(void)logout;

//3.用户注册
//检查用户名
-(void) checkName:(NSString*)name;
//检查手机号
-(void) checkMobile:(NSString*)mobile;
//获取验证码
-(void) registerGetCode:(NSString*)mobile;
//注册
-(void) registerWithCode:(NSString*)checkcode name:(NSString*)name mobile:(NSString*)mobile email:(NSString*)email pwd:(NSString*)pwd type:(NSString*)type;

//4.用手机号码重置密码
//检查手机号和用户名是否一致
-(void) checkName:(NSString*)name mobile:(NSString*)mobile;
//重置时获取验证码
-(void) resetGetCode:(NSString*)mobile;
//重置密码
-(void) resetPwdWithCode:(NSString*)checkcode name:(NSString*)name mobile:(NSString*)mobile pwd:(NSString*)pwd;



//5.初始申请
//5.1 实体入驻查询
//如果用户未提交过申请，不可以查到申请记录；用户层申请过申请，可以查到已提交的数据
/*如查询到记录时，返回字典数据可能为：
 {"resourceIds" : "","contact" : "张玄","companyName" : "测试机构","description" : "初创团队","contactType" : "18576672852","applyStatus" : "通过","businessline" : "电子信息"}
 */
-(void) shiTiRuZhuQuery;

//5.2 实体入驻时文件上传
//参数 NSData类型的文件数据,文件类型如jpg，png等
//文件上传成功时返回ResourceId
-(void) shitiRuZhuFileup:(NSData*) filedata withType:(NSString*)type;

-(void) shitiRuZhuFileup:(NSData*) filedata withType:(NSString*)type withResult:(NSMutableString*) string;

//5.3 实体入驻申请提交
//参数为字典： businessline=电子信息 companyname=测试机构 contact=小明 contacttype=18576672852
// description=初创团队
// resourceids=597a213880ab5e6790d51fde,597a214a80ab5e6790d51fdf
-(void) shiTiRuZhuSubmitWithParam:(NSDictionary*)param;





//5.4 虚拟入驻申请
// 参数为字典：branchname=测试虚拟入驻  contact=小明  contacttype=18576672852  coopcategories=展示推介机会,投融资需求,信息技术需求
//desc=测试备注
-(void) xuniRuZhuSubmitWithParam:(NSDictionary*)param;

//5.5 初始申请时上传的所有文件查询
/*返回值为数组，其中id为文件id
 [{"id":"5974ccc080ab5e6790d50e90","name"
 :"fuwiimg.jpg","path":"gaogaihui/busiplan/20170723/1500855616000.jpg","date":"2017-07-23"},{"id":"597a0a0280ab5e6790d51fd9"
 ,"name":"Snip20170703_1.png","path":"gaogaihui/busiplan/20170727/1501198978000.png","date":"2017-07-27"
 }]
 */
-(void) chushishenqingFileQuery;


//5.6 初始申请时上传的文档删除   管理员用户可以删除，普通用户不可以删除； 此功能在web端有bug
//参数为 文档的资源id；
-(void) chushishenqingFileDelete:(NSString*)resourceid;

//5.7 初始申请时上传的文档下载
-(void) chushishenqingFileDownload:(NSString*)resourceid;






//6.报道入驻
//6.1开通主线查询
//查询成功数据保存在字典中；字典中没有数据，代表未申请过，可以提交申请；字典中有数据，显示数据即可，不可以提交数据
-(void)kaiTongZhuXianQuery;

//6.2开通主线申请
/*参数：
 公司名称 	companyname
 统一号	uninumber
 入驻人数  reportedbodies
 租赁面积 leasearea
 楼层 floor
 通信要求 communications
 汽车车位 parkingLot
 就餐人数 repastbodies
 工商要求 businessneeds
 法务要求 legalneeds
 文印要求 printneeds
 企业状况 companystatus
 */
-(void)kaiTongZhuXian:(NSDictionary*)param;



//6.3我的资源配置
/*
 参数：
 办公位个数 numberOfOffice
 对应资产编号 ofoCodes
 办公桌椅 numberOftc
 对应资产编号 TcCodes
 办公设备 numberOfoe
 对应资产编号 OeCodes
 文印账号 printAccount
 文印密码 printPassword
 门禁卡数量 numberOfegc
 对应资产编号 EgcCodes
 车位数量 numberOfpl
 对应资产编号 PlCodes
 姓名 name
 联系方式 concatType
 其他备注 desc
 */
-(void)woDeZiYuanPeizhiQuery;

//6.4申诉申请查询
-(void)shenSuShenQingQuery;
//6.5申诉申请提交
-(void)shenSuShenQingSubmit:(NSDictionary*)param;
//6.6申诉请求删除
-(void)shenSuShenQingDelete:(NSString*)ids;




//7.孵化成长管理

//7.1  比赛管理
//7.1.1孵化成长管理->日常活跃度管理->比赛管理查询
/*
 响应 	响应数据为array；如下格式
 [{"id":"5937dbe5075910c2d60d07c6","name"
 :"上海市创新创业大赛","competeLevel":"省部级比赛","prizeAwarded":"一等奖","hornerName":"********","orgnizationUnit":""
 ,"date":"2017-06-07 10:56:37","ownerCompetition":"是","score":14,"company":"云创智能科技有限公司"}]
 */
-(void)biSaiGuanLiQuery;

//7.1.2孵化成长管理->日常活跃度管理->比赛管理添加
/*
 请求参数：
 比赛级别 competeLevel
 荣誉名称 hornerName
 比赛名称 name
 组织单位 orgnizationUnit
 是否本园区组织 ownerCompetition
 获奖名次 prizeAwarded
 上传图片的资源id resourceIds
 */
-(void)biSaiGuanLiSubmit:(NSDictionary*)param;


//7.1.3孵化成长管理->日常活跃度管理->比赛管理删除
//请求参数为：比赛id
-(void)biSaiGuanLiDelete:(NSString*)ids;


//7.1.3 孵化成长管理->日常活跃度管理->查询已上传的图片
//请求参数为：比赛id
-(void)biSaiGuanLiQueryFile:(NSString*)ids;

//7.1.4 孵化成长管理->日常活跃度管理->已上传的文档删除
//参数为 文档的资源id； entityId比赛id
-(void) biSaiGuanLiFileDelete:(NSString*)resourceid withEntityId:(NSString*) entityId;







//7.2 产学研管理
//7.2.1 产学研管理查询
/*
响应 [{"id":"5938cb27075910c2d60d07dd","name"
    :"111","money":3000.0,"effect":"","date":"2017-06-08 03:57:27","company":"云创智能科技有限公司"},{"id":"5938cb08075910c2d60d07db"
        ,"name":"*****","money":2.0,"effect":"","date":"2017-06-08 03:56:56","company":"云创智能科技有限公司"}]
*/
-(void) chanXueYanQuery;


//7.2.2 添加产学研项目
/*
 首先要上传文件；
	提交数据时，请求地址 post http://116.228.176.34:9002/chuangke-serve/cooperatorunitInfo/save
	参数：
 文件id resourceIds
 合作机构名称 name
 合作金额级别 moneyLevel
 合作金额 money
 机构级别 level
 合作效果 effect
 合作机构级别有：
 <option value="5879d94ea5a121dff6b57a5d">合作机构一级</option>
 <option value="58be68b9cfdfdf03086a8833">合作机构三级</option>
 <option value="58c7c57bce7229367c55853e">合作机构二级</option>
	
 合作金额级别有：
 <option value="58be6e1a769052b56d66e91e">1万元以下</option>
 <option value="58be6e54769052b56d66e91f">10万元</option>
 <option value="58be6e72cfdfdf03086a8835">100万元</option>
 */
-(void)chanXueYanSubmit:(NSDictionary*)param;

/*
7.2.3 合作项目删除
请求 get  http://116.228.176.34:9002/chuangke-serve/cooperatorunitInfo/delete?id=5938cb08075910c2d60d07db
参数id为 合作项目id
*/
-(void)chanXueYanDelete:(NSString*)ids;


/*
7.2.4 已上传文件查询
请求 get
http://116.228.176.34:9002/chuangke-serve/resource/downlist/search?id=597cc95080ab5e6790d528c3&typeIndex=6
参数id为 合作项目id
[{"id":"597cc8ff80ab5e6790d528c1","name"
    :"warn(1).jpg","path":"cash/busiplan/20170729/1501378943000.jpg","date":"2017-07-29"},{"id":"597cc90c80ab5e6790d528c2"
        ,"name":"warn.jpg","path":"cash/busiplan/20170729/1501378956000.jpg","date":"2017-07-29"}]
*/
-(void)chanXueYanQueryFile:(NSString*)ids;



/*
7.2.5 删除已上传文件
请求 get http://116.228.176.34:9002/chuangke-serve/resource/delete?typeIndex=6&entityId=597cc95080ab5e6790d528c3&id=597cc8ff80ab5e6790d528c1
参数 entityid为合作项目id，id为文件id
*/
-(void) chanXueYanDelete:(NSString*)resourceid withEntityId:(NSString*) entityId;








/*
 7.3.1 活动查询
 请求：get http://116.228.176.34:9002/chuangke-serve/activity/search?start=0&length=1000
 响应： [{"id":"5938cd4b075910c2d60d07de","name"
 :"******","activityLevel":"省市级活动","sponsor":"科创小镇","participant":3,"ownerActivity":"否","company":"云创
 智能科技有限公司","date":"2017-06-08 04:06:35"}]
 */
-(void) huoDongQuery;
-(void) huoDongQueryNew;

/*
 7.3.2 活动添加
 请求 post http://116.228.176.34:9002/chuangke-serve/activity/save
 参数：
 活动级别 activityLevel	5879d979a5a121dff6b57a5f
 活动名称 name	展会活动
 参与人数 participant	2
 resourceIds	597d501c80ab5e6790d52d18,597d504b80ab5e6790d52d19
 主办单位 sponsor	深圳市真服
 响应：
 */
-(void) huoDongSubmit:(NSDictionary*)param;


/*
 7.3.3 活动删除
 请求 get http://116.228.176.34:9002/chuangke-serve/activity/delete?id=5938cd4b075910c2d60d07de
 参数 活动id
 */
-(void)huoDongDelete:(NSString*) ids;
-(void)huoDongDeleteNew:(NSString*)ids;


/*
 7.3.4 活动管理上传文件下载
 请求 get http://116.228.176.34:9002/chuangke-serve/resource/downlist/search?id=597d505080ab5e6790d52d1a&typeIndex=7
 响应 [{"id":"597d501c80ab5e6790d52d18","name"
 :"warn.jpg","path":"cash/busiplan/20170730/1501413532000.jpg","date":"2017-07-30"},{"id":"597d504b80ab5e6790d52d19"
 ,"name":"warn(1).jpg","path":"cash/busiplan/20170730/1501413579000.jpg","date":"2017-07-30"}]
 */
-(void)huoDongQueryFile:(NSString*)ids;



/*
 7.3.5 活动管理文件删除
 请求 get http://116.228.176.34:9002/chuangke-serve/resource/delete?typeIndex=7&entityId=597d505080ab5e6790d52d1a&id=597d504b80ab5e6790d52d19
 参数 entityid为活动id，id为文件id
 */
-(void) huoDongDelete:(NSString*)resourceid withEntityId:(NSString*) entityId;



/*
7.4.1 专业知识产权查询
请求 get http://116.228.176.34:9002/chuangke-serve/knowledge/search?start=0&length=1000
响应 [{"id":"5937e243075910c2d60d07c8","name"
    :"********","code":"********","type":"软件著作权","date":"2017-06-07 19:23:47","company":"云创智能科技有限公司"}]
*/
-(void)zhuanYeZhiShiQuery;


 /*
7.4.2 专业知识产权新增
请求 post  http://116.228.176.34:9002/chuangke-serve/knowledge/save
参数
产权编码 code	123131312
知识名称 name	test
文件 	 resourceIds	597d60d680ab5e6790d52d21,597d60d980ab5e6790d52d22
知识类型 type	58be754fcfdfdf03086a8837
<option value="58be754fcfdfdf03086a8837">软件著作权</option>
<option value="58be756fcfdfdf03086a8839">集成电路布图设计</option>
<option value="58be7588cfdfdf03086a883b">商标</option>
<option value="58be75a9cfdfdf03086a883d">实用新型专利</option>
<option value="58be75c8cfdfdf03086a883f">发明专利</option>
<option value="58be75e3cfdfdf03086a8841">文学著作权</option>
*/
-(void)zhuanYeZhiShiSubmit:(NSDictionary*)param;



/*
7.4.3 专业知识产权删除
请求 get http://116.228.176.34:9002/chuangke-serve/knowledge/delete?id=597d616180ab5e6790d52d25
参数为 知识id
*/
-(void)zhuanYeZhiShiDelete:(NSString*)ids;


 /*
7.4.4 专业知识产权上传文件查询
请求 get  http://116.228.176.34:9002/chuangke-serve/resource/downlist/search?id=597d60ea80ab5e6790d52d23&typeIndex=8
响应 [{"id":"597d60d680ab5e6790d52d21","name"
    :"warn(1).jpg","path":"cash/busiplan/20170730/1501417814000.jpg","date":"2017-07-30"},{"id":"597d60d980ab5e6790d52d22"
        ,"name":"warn.jpg","path":"cash/busiplan/20170730/1501417817000.jpg","date":"2017-07-30"}]
*/
-(void)zhuanYeZhiShiFileQuery:(NSString*)ids;


 
 /*
7.4.5  专业知识产权文件删除
请求 get http://116.228.176.34:9002/chuangke-serve/resource/delete?typeIndex=8&entityId=597d60ea80ab5e6790d52d23&id=597d60d980ab5e6790d52d22
参数 entityid为知识产权d，id为文件id
*/
-(void) zhuanYeZhiShiFileDelete:(NSString*)resourceid withEntityId:(NSString*) entityId;


/*
7.5.1 项目管理查询
请求 get http://116.228.176.34:9002/chuangke-serve/project/search?start=0&length=1000
响应 [{"id":"5938e5d9075910c2d60d07e1","name"
    :"******","projectLevel":"国家级","competentunit":"******","code":"******","company":"云创智能科技有限公司","date"
    :"2017-06-08 13:51:21"}]
*/
 -(void) xiangMuQuery;
 
 /*
7.5.2 项目提交
请求 post http://116.228.176.34:9002/chuangke-serve/project/save
参数：项目编码 code	1231231231
项目单位 competentunit	12123
项目名称 name	test1
项目级别 projectLevel	58c7c6c24c1a3bea9c268d9d
项目文件 resourceIds	597d6d7280ab5e6790d52d26,597d6d7480ab5e6790d52d27
<option value="58c7c6c24c1a3bea9c268d9d">国家级</option>
<option value="58c7c6c24c1a3bea9c268d9e">省部级</option>
<option value="58c7c6c24c1a3bea9c268d9f">区县级</option>
<option value="58c7c6c24c1a3bea9c268da0">一般</option>
*/
-(void) xiangMuSubmit:(NSDictionary*)param;


 
 /*
7.5.3 项目删除
请求 get http://116.228.176.34:9002/chuangke-serve/project/delete?id=597d6e1a80ab5e6790d52d29
参数 id为项目id
*/
-(void) xiangMuDelete:(NSString*)ids;
 
 
 /*
7.5.4 项目上传文件查询
请求 get http://116.228.176.34:9002/chuangke-serve/resource/downlist/search?id=597d6d7b80ab5e6790d52d28&typeIndex=9
参数为 项目id
响应 [{"id":"597d6d7280ab5e6790d52d26","name"
    :"warn(1).jpg","path":"cash/busiplan/20170730/1501421042000.jpg","date":"2017-07-30"},{"id":"597d6d7480ab5e6790d52d27"
        ,"name":"warn.jpg","path":"cash/busiplan/20170730/1501421044000.jpg","date":"2017-07-30"}]
*/
-(void) xiangMuFileQuery:(NSString*)ids;

 /*
7.5.5 项目上传的文件删除
请求 get  http://116.228.176.34:9002/chuangke-serve/resource/delete?typeIndex=9&entityId=597d6d7b80ab5e6790d52d28&id=597d6d7280ab5e6790d52d26
参数 entityid为项目id，id为文件id
*/
-(void) xiangMuFileDelete:(NSString*)resourceid withEntityId:(NSString*) entityId;





/*

7.6.1 奖励管理查询
请求 get http://116.228.176.34:9002/chuangke-serve/award/search?start=0&length=1000
响应 [{"id":"5938e5ec075910c2d60d07e2","name"
    :"******","awardLevel":"一级奖励","awardunit":"******","code":"******","date":"2017-06-08 13:51:40","company"
    :"云创智能科技有限公司"}]
*/
-(void)jiangLiQuery;
 
 
 /*
7.6.2 奖励管理提交
请求 post http://116.228.176.34:9002/chuangke-serve/award/save
参数
名称 name	羽毛球奖
级别 awardLevel	58c7c7094c1a775d6de79f72
单位 awardunit	体委
编码 code	131231
文件id  resourceIds	597d6fcb80ab5e6790d52d2a,597d6fcf80ab5e6790d52d2b
<option value="58c7c7094c1a775d6de79f72">一级奖励</option>
<option value="58c7c7094c1a775d6de79f73">二级奖励</option>
<option value="58c7c7094c1a775d6de79f74">三级奖励</option>
*/
-(void)jiangLiSubmit:(NSDictionary*)param;


 
 /*
7.6.3 奖励删除
请求 get http://116.228.176.34:9002/chuangke-serve/award/delete?id=597d708280ab5e6790d52d2d
参数 id为奖励id
*/
-(void)jiangLiDelete:(NSString*)ids;
 
 
 /*
7.6.4 奖励上传的文件查询
请求 get http://116.228.176.34:9002/chuangke-serve/resource/downlist/search?id=597d700b80ab5e6790d52d2c&typeIndex=10
参数id为奖励id
响应 为 [{"id":"597d6fcb80ab5e6790d52d2a","name"
    :"warn(1).jpg","path":"cash/busiplan/20170730/1501421643000.jpg","date":"2017-07-30"},{"id":"597d6fcf80ab5e6790d52d2b"
        ,"name":"warn.jpg","path":"cash/busiplan/20170730/1501421647000.jpg","date":"2017-07-30"}]
*/
-(void)jiangLiFileQuery:(NSString*)ids;

 /*
7.6.5 奖励上传的文件删除
请求 get http://116.228.176.34:9002/chuangke-serve/resource/delete?typeIndex=10&entityId=597d700b80ab5e6790d52d2c&id=597d6fcb80ab5e6790d52d2a
参数 entityid为奖励id，id为文件id
*/

-(void) jiangLiFileDelete:(NSString*)resourceid withEntityId:(NSString*) entityId;














@end
