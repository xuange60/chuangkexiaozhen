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
+(int) registerGetCode:(NSString*)mobile;
//注册
+(int) registerWithCode:(NSString*)checkcode name:(NSString*)name mobile:(NSString*)mobile email:(NSString*)email pwd:(NSString*)pwd type:(NSString*)type;

//4.用手机号码重置密码
//检查手机号和用户名是否一致
-(void) checkName:(NSString*)name mobile:(NSString*)mobile;
//重置时获取验证码
+(int) resetGetCode:(NSString*)mobile;
//重置密码
+(int) resetPwdWithCode:(NSString*)checkcode name:(NSString*)name mobile:(NSString*)mobile pwd:(NSString*)pwd;



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
+(NSString*) shitiRuZhuFileup:(NSData*) filedata withType:(NSString*)type;



//5.3 实体入驻申请提交
//参数为字典： businessline=电子信息 companyname=测试机构 contact=小明 contacttype=18576672852
// description=初创团队
// resourceids=597a213880ab5e6790d51fde,597a214a80ab5e6790d51fdf
+(int) shiTiRuZhuSubmitWithParam:(NSDictionary*)param;





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

//5.6 初始申请时上传的文档删除
-(void) chushishenqingFileDownload:(NSString*)resourceid;

@end
