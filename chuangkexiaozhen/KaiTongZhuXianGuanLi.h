//
//  KaiTongZhuXianGuanLi.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/10.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BussinessApi.h"
@interface KaiTongZhuXianGuanLi : NSObject

@property(nonatomic,assign)id <BussinessApiDelegate> delegate;



/*
 2.11.1 开通主线管理 查询
 http://116.228.176.34:9002/chuangke-serve/mainline/search?start=0&length=10000
 [{"id":"597dc20280ab5e6790d52d7f","reportedBodys"
 :20,"leaseArea":45,"floor":3,"bearing":"无特殊需求","water":"无特殊需求","electricity":"无特殊需求","communications"
 :"开通电信","parkingLot":"3","repastBodies":3,"businessNeeds":"提供注册帮助","legalNeeds":"提供法务帮助","printNeeds"
 :"需要打印","applyNetAlone":"否","applyNetShare":"是","reformDecoration":"否","companyStatus":"创业团队，工商未注册","companyName"
 :"ceshigongsi","uniNumber":"","tenantInit":"uninit"},{"id":"597d812f80ab5e6790d52d4e","reportedBodys"
 :4,"leaseArea":20,"floor":1,"bearing":"无特殊需求","water":"无特殊需求","electricity":"无特殊需求","communications"
 :"开通电信","parkingLot":"4","repastBodies":4,"businessNeeds":"提供注册帮助","legalNeeds":"提供法务帮助","printNeeds"
 :"需要","applyNetAlone":"否","applyNetShare":"是","reformDecoration":"否","companyStatus":"创业团队，工商未注册","companyName"
 :"测试公司zhangxuan3","uniNumber":"","tenantInit":"inited"}]
 */
-(void)KaiTongZhuXianQuery;

/*
 2.11.2 开通主线管理删除
 http://116.228.176.34:9002/chuangke-serve/mainline/delete?id=58faea0119eb8cbffbb87b4a
 */

-(void)KaiTongZhuXianDelete:(NSString*)ids;












@end
