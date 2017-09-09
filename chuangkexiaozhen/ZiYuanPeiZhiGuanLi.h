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
  2.13.0 在修改资源时，可以下拉选择资产编号；查询到所有的资产编号
 http://116.228.176.34:9002/chuangke-serve/resourceallocation/edit?id=59361b09075910c2d60d0790
 查询到数据为：
 {
 "EgcCodes" : {
 "KCXZ-CYK0030" : "58f58da119eb8cbffbb87aca",
 "KCXZ-CYK0020" : "58f58d2319eb8cbffbb87ac0",
 "KCXZ-CYK0033" : "58f58dc019eb8cbffbb87acd",
 "KCXZ-CYK0013" : "58f58ca719eb8cbffbb87ab8",
 "KCXZ-CYK0003" : "58f58c0919eb8cbffbb87aae",
 "KCXZ-CYK0036" : "58f58de219eb8cbffbb87ad0",
 "KCXZ-CYK0026" : "58f58d6a19eb8cbffbb87ac6",
 "KCXZ-CYK0016" : "58f58cce19eb8cbffbb87abb",
 "KCXZ-CYK0006" : "58f58c2619eb8cbffbb87ab1",
 "KCXZ-CYK-0001" : "58e6005f19eb64c4e63875fd",
 "KCXZ-CYK00010" : "58f58c5819eb8cbffbb87ab5",
 "KCXZ-CYK0019" : "58f58cf119eb8cbffbb87abe",
 "KCXZ-CYK0009" : "58f58c4319eb8cbffbb87ab4",
 "KCXZ-CYK0029" : "58f58d9719eb8cbffbb87ac9",
 "KCXZ-CYK0032" : "58f58db619eb8cbffbb87acc",
 "KCXZ-CYK0012" : "58f58c9919eb8cbffbb87ab7",
 "KCXZ-CYK0002" : "58e6006f19eb64c4e63875fe",
 "KCXZ-CYK0035" : "58f58dd819eb8cbffbb87acf",
 "KCXZ-CYK0025" : "58f58d5f19eb8cbffbb87ac5",
 "KCXZ-CYK0015" : "58f58cc219eb8cbffbb87aba",
 "KCXZ-CYK0005" : "58f58c1f19eb8cbffbb87ab0",
 "A1" : "597d819b80ab5e6790d52d59",
 "A2" : "597d81a180ab5e6790d52d5a",
 "KCXZ-CYK0038" : "58f58dfe19eb8cbffbb87ad2",
 "KCXZ-CYK0028" : "58f58d8419eb8cbffbb87ac8",
 "KCXZ-CYK0018" : "58f58ce619eb8cbffbb87abd",
 "KCXZ-CYK0008" : "58f58c3b19eb8cbffbb87ab3",
 "A3" : "597d81ab80ab5e6790d52d5b",
 "KCXZ-CYK0031" : "58f58dab19eb8cbffbb87acb",
 "KCXZ-CYK0011" : "58f58c6119eb8cbffbb87ab6",
 "A4" : "597d81b180ab5e6790d52d5c",
 "KCXZ-CYK0034" : "58f58dcd19eb8cbffbb87ace",
 "KCXZ-CYK0014" : "58f58cb319eb8cbffbb87ab9",
 "KCXZ-CYK0004" : "58f58c1319eb8cbffbb87aaf",
 "KCXZ-CYK0037" : "58f58dee19eb8cbffbb87ad1",
 "KCXZ-CYK0027" : "58f58d7619eb8cbffbb87ac7",
 "KCXZ-CYK0017" : "58f58cda19eb8cbffbb87abc",
 "KCXZ-CYK0007" : "58f58c3119eb8cbffbb87ab2"
 },
 "PlCodes" : {
 "Z1" : "597d81ba80ab5e6790d52d5d",
 "KCXZ-CW0010" : "58f58e8219eb8cbffbb87ada",
 "KCXZ-CW0007" : "58f58e6519eb8cbffbb87ad7",
 "Z2" : "597d81c180ab5e6790d52d5e",
 "KCXZ-CW0009" : "58f58e7719eb8cbffbb87ad9",
 "KCXZ-CW0006" : "58f58e5b19eb8cbffbb87ad6",
 "124124414" : "597d7c8f80ab5e6790d52d40",
 "KCXZ-CW0008" : "58f58e6f19eb8cbffbb87ad8"
 },
 "TcCodes" : {
 "3" : "597d815980ab5e6790d52d51",
 "1" : "597d814c80ab5e6790d52d4f",
 "KCXZ-CW0005" : "58f58e5119eb8cbffbb87ad5",
 "4" : "597d815f80ab5e6790d52d52",
 "2" : "597d815480ab5e6790d52d50",
 "5" : "597d816580ab5e6790d52d53"
 },
 "ofoCodes" : {
 "KCXZ-GW0001" : "KCXZ-GW0001",
 "KCXZ-GW0004" : "KCXZ-GW0004",
 "Q1" : "Q1",
 "KCXZ-GW0003" : "KCXZ-GW0003",
 "KCXZ-GW0002" : "KCXZ-GW0002",
 "KCXZ-GW0005" : "KCXZ-GW0005"
 },
 "OeCodes" : {
 "B2" : "597d817b80ab5e6790d52d55",
 "KCXZ-BGSB0003" : "58e600f419eb64c4e6387604",
 "B3" : "597d818280ab5e6790d52d56",
 "***" : "594a15f6075910c2d60d08ca",
 "KCXZ-BGSB0004" : "59361919075910c2d60d0789",
 "B1" : "597d817480ab5e6790d52d54",
 "B4" : "597d818980ab5e6790d52d57",
 "KCXZ-BGSB0005" : "59361922075910c2d60d078a"
 }
 }
其中ofoCodes数据返回有误
 */
-(void) ZiYuanGuanLiDetailQuery:(NSString*)ids;

-(void) ZiYuanGuanLiInitQuery:(NSString*)ids;

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


-(void) ZiYuanGuanLiInit:(NSDictionary*)param;

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
