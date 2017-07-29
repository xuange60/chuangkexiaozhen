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


@interface BussinessApi : NSObject

@property(nonatomic)int num;


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






@end
