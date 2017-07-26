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
//5.1 实体入驻
-(void) shiTiRuZhuQuery;
//5.2 实体入驻申请提交
-(void) shiTiRuZhuSubmit;





@end
