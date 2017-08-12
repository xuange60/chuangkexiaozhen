//
//  JiaFenCaiLiaoShenHe.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/12.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BussinessApi.h"
@interface JiaFenCaiLiaoShenHe : NSObject

@property(nonatomic,assign)id <BussinessApiDelegate> delegate;


//0 孵化成长管理->日常活跃度管理->比赛管理查询 管理员查询
/*
 响应 	响应数据为array；如下格式
 [{"id":"5937dbe5075910c2d60d07c6","name"
 :"上海市创新创业大赛","competeLevel":"省部级比赛","prizeAwarded":"一等奖","hornerName":"********","orgnizationUnit":""
 ,"date":"2017-06-07 10:56:37","ownerCompetition":"是","score":14,"company":"云创智能科技有限公司"}]
 */
-(void)biSaiGuanLiQueryWithAdmin;

//1 孵化成长管理->日常活跃度管理->查询比赛管理是否通过审核
//http://116.228.176.34:9002/chuangke-serve/competition/detail?id=598eaa0722637b17beb30f4b
-(void)biSaiGuanLiShenHeQuery:(NSString*)ids;


/*2孵化成长管理->日常活跃度管理->比赛管理审核
 http://116.228.176.34:9002/chuangke-serve/competition/status
 请求参数：
 competeLevel 国家级比赛
 hornerName 111
 id 598eaa0722637b17beb30f4b
 memo
 name admin3
 orgnizationUnit 111
 prizeAwarded 一等奖
 score 18
 status fail
 statusRead	审核中
 */
-(void)biSaiGuanLiSubmit:(NSDictionary*)param;




//7.2.1 产学研管理查询 管理员查询
/*
 响应 [{"id":"5938cb27075910c2d60d07dd","name"
 :"111","money":3000.0,"effect":"","date":"2017-06-08 03:57:27","company":"云创智能科技有限公司"},{"id":"5938cb08075910c2d60d07db"
 ,"name":"*****","money":2.0,"effect":"","date":"2017-06-08 03:56:56","company":"云创智能科技有限公司"}]
 */
-(void) chanXueYanQueryWithAdmin;



//1 孵化成长管理->日常活跃度管理->查询比赛管理是否通过审核
//http://116.228.176.34:9002/chuangke-serve/cooperatorunitInfo/detail?id=598ef60c22637b17beb30f50
-(void)chanXueYanShenHeQuery:(NSString*)ids;

//审批提交
-(void)chanXueYanSubmit:(NSDictionary*)param;


-(void)jiaFenCaiLiaoQuerywithAdmin:(NSString*)type;

-(void)jiaFenCaiLiaoShenHeQuery:(NSString*)ids withType:(NSString*)type;


-(void) jiaFenCaiLiaoShenHeSubmit:(NSDictionary*)param withType:(NSString*) type;

@end
