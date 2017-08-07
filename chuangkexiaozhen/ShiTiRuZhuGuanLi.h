//
//  ShiTiRuZhuGuanLi.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/8.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BussinessApi.h"
@interface ShiTiRuZhuGuanLi : NSObject

@property(nonatomic,assign)id <BussinessApiDelegate> delegate;



/*
 2.1 实体入驻管理查询
 请求 get  http://116.228.176.34:9002/chuangke-serve/apply/search?typeNumber=1&start=0&length=10000
 响应 [{"id":"597db10980ab5e6790d52d67","contact"
 :"小灰灰","contactType":"18554353465","companyName":"新时代","applyDate":"2017-07-30","applyStatus":"未处理","businessLine"
 :"互联网和移动互联网","coopCategories":null,"branchName":null,"desc":null,"applyintype":null,"totalScore":0.0
 ,"inplace":"已报道","description":"加速企业"},{"id":"597dbedb80ab5e6790d52d78","contact":"xiaogao1","contactType"
 :"18576672852","companyName":"craggily","applyDate":"2017-07-30","applyStatus":"通过","businessLine":"
 新材料","coopCategories":null,"branchName":null,"desc":null,"applyintype":null,"totalScore":400.0,"inplace"
 :"未报道","description":"加速企业"}
 
 
 申请状态有：未处理，处理中，通过，失败
 当申请状态为：未处理或处理中时，可以编辑、添加答辩、审批通过，审批不通过，删除，下载文档
 */
-(void)ShiTiRuZhuGuanLiQuery;

/*
 2.2 审批不通过
 请求 get http://116.228.176.34:9002/chuangke-serve/apply/ifagree?ifagree=2&applyId=597db10980ab5e6790d52d67
 */
-(void)ShiTiRuZhuGuanLiJuJue:(NSString*)ids;


/*
 2.3 撤销审批不通过
 get http://116.228.176.34:9002/chuangke-serve/apply/retreat?id=597db10980ab5e6790d52d67
 */
-(void)ShiTiRuZhuGuanLiJuJueCancle:(NSString*)ids;

/*
 2.4.1 提交答辩
 post http://116.228.176.34:9002/chuangke-serve/applytreat/save
 参数
 评审专家id userIds
 答辩时间 defenceDateStr
 答辩地点 addr
 */
-(void)TiJiaoDaBianShenQing:(NSDictionary*)param;

/*
 2.4.2 获取评审专家列表
 get http://116.228.176.34:9002/chuangke-serve/user/getselect?code=evaluationexpert
 [{"id":"5875a60bee19799d1cc83824","name"
 :"王俊","loginName":"admin"},{"id":"58e5c52c19eb26b288dc9753","name":"顾一琳","loginName":"guyilin"},{"id"
 :"58e7316c19eb5e6b9401247e","name":"王博雅","loginName":"wangboya"}]
 */
-(void)DaBianZhuanJiaQuery;

/*
 2.5 审批通过
 http://116.228.176.34:9002/chuangke-serve/apply/ifagree?ifagree=1&applyId=597db10980ab5e6790d52d67
 */
-(void)ShiTiRuZhuGuanLiTongGuo:(NSString*)ids;

/*
 2.6 删除请求
 http://116.228.176.34:9002/chuangke-serve/apply/delete?id=597c00cd80ab5e6790d52891
 */
-(void)ShiTiRuZhuDelete:(NSString*)ids;

 
 /*
 2.7 修改请求
 查询请求内容 http://116.228.176.34:9002/chuangke-serve/reviewinfo/list/?applytreatid=597c4d0280ab5e6790d528a2
 提交修改后的请求 http://116.228.176.34:9002/chuangke-serve/apply/update/apply
 参数：businessLine	电子信息
 companyName	克里斯蒂
 contact	浮动浮动
 contactType	354657648611
 description	初创团队
 id	597af69d80ab5e6790d5243d
 */

-(void) ShiTiRuZhuQuery:(NSString*)ids;

-(void) ShiTiRuZhuModify:(NSDictionary*)param;


/*
 2.8 请求相关文档查询及下载
 http://116.228.176.34:9002/chuangke-serve/resource/downlist/search?id=597d796680ab5e6790d52d33&typeIndex=26&start=0&length=10000
 */
//typeIndex=26 请求与以前一样





@end
