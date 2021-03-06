//
//  KaoQinGuanLi.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/5.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BussinessApi.h"
@interface KaoQinGuanLi : NSObject

@property(nonatomic,assign)id <BussinessApiDelegate> delegate;


/*
 10.1 考勤统计查询
 请求 get  http://116.228.176.34:9002/chuangke-serve/userattendance/search?start=0&length=10000
 响应： [{"id":"58f9d2ea19eb8cbffbb87b23","actualCount"
 :0,"absentCount":1,"shouldCount":1,"rateOfAttend":"0.00%","companyName":"都步（上海）智能科技有限公司"},{"id":"58f5887219eb8cbffbb87aa0"
 ,"actualCount":0,"absentCount":1,"shouldCount":1,"rateOfAttend":"0.00%","companyName":"清基(上海）农业发展有限公
 司"},{"id":"597d7aba80ab5e6790d52d37","actualCount":0,"absentCount":1,"shouldCount":1,"rateOfAttend":"0
 .00%","companyName":"测试机构zhangxuan"}]
 */

-(void)KaoQinQueryStart:(NSString*)starttime End:(NSString*)endtime;

/*
 10.2 查询考勤详情
 请求 get  http://116.228.176.34:9002/chuangke-serve/userattendance/user/search?start=0&length=1000
 响应 [{"id":"58f9d27d19eb8cbffbb87b1f","date"
 :"2017-08-04","username":"都步（上海）智能科技有限公司","status":null,"absence":"未出勤","startTime":null,"endTime":null
 }]
 */

-(void)KaoQinDetailQuery:(NSString*)ids date:(NSString*)date;





@end
