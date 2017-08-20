//
//  YuanGongXinXi.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/20.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "CommNetWork.h"

@interface YuanGongXinXi : CommNetWork

/*
 2.21.1 员工列表查询
 http://116.228.176.34:9002/chuangke-serve/user/searchstaff?start=0&length=1000
 [{"id":"58e7316c19eb5e6b9401247e","stopflag"
 :false,"loginName":"wangboya","sex":null,"phone":"13817053160","email":"","addr":null,"companyName":"
 上海枫泾创业投资服务有限公司","companyType":"创投孵化","concat":null,"department":"服务部","rank":"专员","createDate":"2017-04-07
 14:27:56","manager":true,"joinDate":"2017-04-07","name":"王博雅"},{"id":"58e5c65c19eb26b288dc9759","stopflag"
 :false,"loginName":"jiyuehui","sex":null,"phone":"18621108800","email":"zheng@163.com","addr":null,"companyName"
 :"上海漕河泾开发区枫泾新兴产业发展有限公司","companyType":"创投孵化","concat":null,"department":"招商部","rank":"总经理助理","createDate"
 :"2017-04-06 12:38:52","manager":true,"joinDate":"2017-04-06","name":"季悦慧"}]
 */

-(void)YuanGongQuery;


/*
 2.22.2 添加员工
 http://116.228.176.34:9002/chuangke-serve/user/save/staff
 department	xxx
 email	77777@qq.com
 id
 loginName	ceshiadmin
 mobilePhone	18777778888
 name	123456
 password	123456
 rank	xxx
 remark	xxx
 */

-(void)YuanGongAdd:(NSDictionary*)param;


/*
 2.22.3 删除员工
 http://116.228.176.34:9002/chuangke-serve/user/staff/kick?id=5999a0c2a92b0b6e2c92fb79
 */

-(void)YuanGongDelete:(NSString*)ids;


/*
 2.22.4 修改用户信息
 http://116.228.176.34:9002/chuangke-serve/user/staff/update
 department	ssxxxx
 email
 id	5999a120a92b0b6e2c92fb7b
 loginName	ceshiadmin2
 mobile	18677772222
 name	ceshiadmin2
 newLoginName	ceshiadmin2
 newMobilePhone	18677772222
 rank	ss
 */
-(void)YuanGongUpdate:(NSDictionary*)param;

@end
