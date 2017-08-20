//
//  YongHuXinXi.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/20.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "CommNetWork.h"

@interface YongHuXinXi : CommNetWork

/*
 2.20.1 用户列表查询
 http://116.228.176.34:9002/chuangke-serve/user/search?start=0&length=1000
 [{"id":"5995799ea92b0b6e2c92edae","stopflag"
 :false,"loginName":"ceshi1","sex":null,"phone":"18676671111","email":"","addr":null,"companyName":null
 ,"companyType":null,"concat":null,"department":"xxx","rank":"xxx","createDate":"2017-08-17 19:10:22"
 ,"manager":true,"joinDate":null,"name":"测试"},{"id":"5981e17b80ab5e6790d53b59","stopflag":false,"loginName"
 :"ceshi","sex":null,"phone":"18511111111","email":"","addr":null,"companyName":null,"companyType":null
 ,"concat":null,"department":"1","rank":"","createDate":"2017-08-02 22:28:11","manager":true,"joinDate"
 :null,"name":"ceshi"}]
 */
-(void)YongHuQuery;


/*
 2.20.2 删除用户
 http://116.228.176.34:9002/chuangke-serve/user/batchdelete?ids=5995799ea92b0b6e2c92edae
 */
-(void)YongHuDelete:(NSString*)ids;


/*
 2.20.3 用户停用
 http://116.228.176.34:9002/chuangke-serve/user/upuserstatus?id=59849a3280ab5e6790d54495&flagStr=true
 */
-(void)YongHuStop:(NSString*)ids;




/*
 2.20.4 查询用户
 http://116.228.176.34:9002/chuangke-serve/user/edit?id=598495bc80ab5e6790d54493
 
 2.20.5 修改用户
 http://116.228.176.34:9002/chuangke-serve/user/update
 comanyname	xxxxx
 companytype	电子信息
 department	xxx
 email	4444@qq.com
 id	598495bc80ab5e6790d54493
 mobile	17566562783
 name	ceshigongsi
 rank	21
 remark	1112
 roleIds	5875a66fee19799d1cc83827
 roleIds	589d240277c87dfcad569547
 username	ceshi12222
 */
-(void)YongHuDetailQuery:(NSString*)ids;
-(void)yongHuModify:(NSDictionary*)param;


/*
 2.20.6 修改密码
 http://116.228.176.34:9002/chuangke-serve/user/update/password
 */
-(void)YongHuPwdModify:(NSDictionary*)param;


@end
