//
//  ZiYuanPeiZhiGuanLi.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/11.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BussinessApi.h"
@interface ZiYuanPeiZhiGuanLi : NSObject

@property(nonatomic,assign)id <BussinessApiDelegate> delegate;


/*
 2.13.0 资源管理修改前查询
 */
-(void) ZiYuanGuanLiDetailQuery:(NSString*)ids;


/*
 2.13.1 资源管理配置修改
 post http://116.228.176.34:9002/chuangke-serve/resourceallocation/update
 参数
 EgcCodes	58e6005f19eb64c4e63875fd
 EgcCodes	58e6005f19eb64c4e63875fd
 OeCodes	58e600f419eb64c4e6387604
 OeCodes	59361919075910c2d60d0789
 OeCodes	58e600f419eb64c4e6387604
 OeCodes	59361919075910c2d60d0789
 PlCodes	58f58e5119eb8cbffbb87ad5
 PlCodes	58f58e6519eb8cbffbb87ad7
 PlCodes	58f58e5119eb8cbffbb87ad5
 PlCodes	58f58e6519eb8cbffbb87ad7
 TcCodes	597d815f80ab5e6790d52d52
 TcCodes	597d814c80ab5e6790d52d4f
 TcCodes	597d815480ab5e6790d52d50
 concatType
 desc	2222
 id	597d825c80ab5e6790d52d62
 name
 numberOfOffice	1
 numberOfegc	1
 numberOfoe	3
 numberOfpl	2
 numberOftc	2
 printAccount	1
 printPassword	1
 
 
 {"actionid":"","result":1,"errorcode":"","desc":"","obj":null,"objid":null,"action":null,"recordsTotal"
 :0,"recordsFiltered":0,"totalPages":0}
 */
-(void) ZiYuanGuanLiModify:(NSDictionary*)param;



/*
 2.13.2 资源管理查询
 http://116.228.176.34:9002/chuangke-serve/resourceallocation/search?length=1000&start=0
 [{"id":"58e5fd9f19eb64c4e63875f6","officeArea"
 :null,"numberOfOffice":2,"numberOftc":2,"tcCodes":"KCXZ-BGZY0001,KCXZ=BGZY0002","numberOfoe":2,"oeCodes"
 :"KCXZ-BGSB0001,KCXZ-BGSB0002","printAccount":"wy01","printPassword":"wy01","numberOfegc":2,"egcCodes"
 :"KCXZ-CYK0039,KCXZ-CYK0040","numberOfpl":2,"plCodes":"KCXZ-CW0001,KCXZ-CW0002","companyName":"上海匠睿智
 能科技有限公司","name":"王俊","concatType":"15901647707","desc":""},{"id":"58f5892e19eb8cbffbb87aa5","officeArea"
 :null,"numberOfOffice":6,"numberOftc":6,"tcCodes":"","numberOfoe":0,"oeCodes":"","printAccount":"qjny01"
 ,"printPassword":"111111","numberOfegc":4,"egcCodes":"KCXZ-CYK0021,KCXZ-CYK0022,KCXZ-CYK0023,KCXZ-CYK0024"
 ,"numberOfpl":2,"plCodes":"KCXZ-CW0003,KCXZ-CW0004","companyName":"清基(上海）农业发展有限公司","name":"陈强","concatType"
 :"","desc":""}]
 */
-(void) ZiYuanGuanLiQuery;


/*
 2.13.3 资源管理删除
 http://116.228.176.34:9002/chuangke-serve/resourceallocation/delete?id=58e5fd9f19eb64c4e63875f6
 */
-(void) ZiYuanGuanLiDelete:(NSString*)ids;








@end
