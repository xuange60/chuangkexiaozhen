//
//  XuNiRuZhuGuanLi.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/10.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BussinessApi.h"
@interface XuNiRuZhuGuanLi : NSObject

@property(nonatomic,assign)id <BussinessApiDelegate> delegate;


/*
 2.10.1 虚拟入驻管理查询
 http://116.228.176.34:9002/chuangke-serve/apply/search?typeNumber=1&start=0&length=10000
 [{"id":"598880a622637b17beb2f877","contact"
 :"","contactType":"","companyName":null,"applyDate":"2017-08-07","applyStatus":"未处理","businessLine":null
 ,"coopCategories":"信息技术需求,制造加工及场地需求,农艺新品种需求","branchName":"","desc":"","applyintype":null,"totalScore"
 :0.0,"inplace":"未报道","description":null}
 
 查询到的状态为未处理时，可以修改，审批通过，审批不通过，删除
 查询到的状态为通过或失败时，可以修改，删除
 */
-(void)XuNiRuZhuGuanLiQuery;

/*
 2.10.2 虚拟入驻审核不通过
 
 http://116.228.176.34:9002/chuangke-serve/apply/ifagree?ifagree=2&applyId=598880a622637b17beb2f877
 
 {"actionid":"","result":1,"errorcode":"","desc":"","obj":null,"objid":null,"action":null,"recordsTotal"
 :0,"recordsFiltered":0,"totalPages":0}
 */
-(void)XuNiRuZhuGuanLiNo:(NSString*)ids;

/*
 2.10.3 虚拟入驻申请修改 --
 参数 post id:id,contact:contact,contacttype:contactType,branchname:branchName,coopcategories
 :coopcategoriesStr,desc:desc}
 http://116.228.176.34:9002/chuangke-serve/apply/update/resapply
 */
-(void)XuNiRuZhuGuanLiModify:(NSDictionary*)param;


/*
 2.10.4 虚拟入驻申请删除
 http://116.228.176.34:9002/chuangke-serve/apply/delete?id=598880a622637b17beb2f877
 */
-(void)XuNiRuZhuGuanLiDelete:(NSString*)ids;




/*
 2.10.5 虚拟入驻申请通过
 http://116.228.176.34:9002/chuangke-serve/apply/ifagree?ifagree=1&applyId=597a273180ab5e6790d51fe2
 */
-(void)XuNiRuZhuGuanLiYes:(NSString*)ids;











@end
