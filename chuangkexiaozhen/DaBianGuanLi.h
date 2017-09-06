//
//  DaBianGuanLi.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/8.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BussinessApi.h"
#import "CommNetWork.h"
@interface DaBianGuanLi : CommNetWork

//@property(nonatomic,assign)id <BussinessApiDelegate> delegate;

/*
1.1 答辩管理查询
请求 get  http://116.228.176.34:9002/chuangke-serve/applytreat/search?start=0&length=10000
响应： [{"id":"58e5c76a19eb26b288dc975b","companyName"
    :"上海匠睿智能科技有限公司","defenceDate":"2017-04-06","addr":"科创小镇1楼会议室","usernames":"王俊","isspcial":1,"iftreated"
    :"true"},{"id":"58f5884519eb8cbffbb87a9e","companyName":"清基(上海）农业发展有限公司","defenceDate":"2017-04-18","addr"
        :"一楼小会议室","usernames":"王俊","isspcial":1,"iftreated":"true"}]
 "iftreated":"true" 表示已经打分
   "iftreated":"false" 表示未打分
*/
-(void)DaBianGuanLiQuery;

/*
1.2 答辩管理删除
请求 http://116.228.176.34:9002/chuangke-serve/applytreat/batchdelete?ids=58feffdc19eb8cbffbb87bcc
参数 ids为答辩管理记录id
*/
-(void)DaBianDelete:(NSString*)ids;





/*
 1.3 打分及文件上传
 请求 post http://116.228.176.34:9002/chuangke-serve/reviewinfo/save
 请求参数
 是否允许接入 agreeApplyin	true
 答辩记录id  applyTreatId	597dbefb80ab5e6790d52d79
 附件 resourceIds	 598887e222637b17beb2f87a,598887e622637b17beb2f87b
 reasons	与园区方向切合度
 reasons	项目创新性和独特性
 reasons	项目团队运营能力
 reasons	项目市场业务能力
 reasons	项目产品技术研发能力
 scores	80
 scores	80
 scores	80
 scores	80
 scores	80
 */
-(void)DaBianPingFenAdd:(NSDictionary*)param;

@end
