//
//  YuanGongGuanLi.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/2.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BussinessApi.h"

@interface YuanGongGuanLi : NSObject

@property(nonatomic,assign)id <BussinessApiDelegate> delegate;



/*
 9.1 员工列表查询
 请求 get http://116.228.176.34:9002/chuangke-serve/user/searchstaff?start=0&length=1000
 响应 [{"id":"5981e17b80ab5e6790d53b59","stopflag"
 :false,"loginName":"ceshi","sex":null,"phone":"18511111111","email":"","addr":null,"companyName":null
 ,"companyType":null,"concat":null,"department":"1","rank":"","createDate":"2017-08-02 22:28:11","manager"
 :true,"joinDate":"2017-08-02","name":"ceshi"},{"id":"59390581075910c2d60d0801","stopflag":false,"loginName"
 :"cash","sex":null,"phone":"13901100000","email":"8912631@qq.com","addr":null,"companyName":"新时代","companyType"
 :"互联网和移动互联网","concat":null,"department":"***","rank":"***11111","createDate":"2017-06-08 16:06:25","manager"
 :true,"joinDate":"2017-06-08","name":"小灰灰"}]
 */
-(void)YuanGongQuery;



/*
 9.2 员工添加
 请求 post http://116.228.176.34:9002/chuangke-serve/user/save/staff
 参数
 所在部门 department	1
 邮箱 email
 id
 登录帐号 loginName	ceshi
 手机号 mobilePhone	18511111111
 用户姓名 name	ceshi
 初始密码 password	123456
 所处职级 rank
 备注 remark	11
 
 响应 {"actionid":"","result":1,"errorcode":"","desc":"","obj":"","objid":null,"action":null,"recordsTotal"
 :0,"recordsFiltered":0,"totalPages":0}
 */
-(void)YuanGongSubmit:(NSDictionary*)param;

/*
 9.3 删除员工
 请求 get http://116.228.176.34:9002/chuangke-serve/user/staff/kick?id=5937677f075910c2d60d07b5
 参数为员工记录id
 响应 {"actionid":"","result":1,"errorcode":null,"desc":"","obj":null,"objid":null,"action":null,"recordsTotal"
 :0,"recordsFiltered":0,"totalPages":0}
 */
-(void)YuanGongDelete:(NSString*)ids;


/*
 9.4 修改员工
 请求 post http://116.228.176.34:9002/chuangke-serve/user/staff/update
 参数同员工添加一样，注意员工id必须填
 */
-(void)YuanGongUpdate:(NSDictionary*)param;



@end
