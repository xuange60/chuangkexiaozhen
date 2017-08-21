//
//  TuanDuiYunYing.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/21.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "CommNetWork.h"

@interface TuanDuiYunYing : CommNetWork

//查询所有数据
-(void)queryData:(NSString*)type;

//管理员查询所有数据
-(void)queryDataAdmin:(NSString*)type;

//添加前查询参数
-(void)queryParam:(NSString*)type;

//添加数据
-(void)addData:(NSDictionary*)param withType:(NSString*)type;

//删除数据
-(void)deleteData:(NSString*)ids withType:(NSString*)type;

//查询记录详情
-(void)queryDetail:(NSString*)ids withType:(NSString*)type;

//审批记录
-(void)shenpiData:(NSDictionary*)param withType:(NSString*)type;
@end



/*
 2.23.1 高学历人才
 查询
 http://116.228.176.34:9002/chuangke-serve/highlyeducated/search?start=0&length=1000&role=ck
 
 查询参数 http://116.228.176.34:9002/chuangke-serve/highlyeducated/add
 
 
 添加 http://116.228.176.34:9002/chuangke-serve/highlyeducated/save
 参数：
 学位级别 degreeLevel	58c7c7ce4c1afcafba9f669b
 毕业学校 graduateSchool	2222
 人员姓名 name	小刚
 resourceIds
 学校级别 schoolLevel	58c7c1114c1a5936e85c6103
 
 
 删除 http://116.228.176.34:9002/chuangke-serve/highlyeducated/batchdelete?ids=5999bac2a92b0b6e2c92fb84
 
 
 查询详情 http://116.228.176.34:9002/chuangke-serve/highlyeducated/detail?id=5999bae0a92b0b6e2c92fb85
 
 管理员提交审核 其中审核通过status传success，审核不通过status传fail，注意在审批时参数不用转换
 http://116.228.176.34:9002/chuangke-serve/highlyeducated/status
 参数：
 degreeLevel	博士学历
 graduateSchool	xxx
 id	5999bae0a92b0b6e2c92fb85
 memo
 name	小刚
 schoolLevel	一级学校
 scoreRead	8
 statusRead	审核中
 status	success
 
 
 文件下载 typeIndex=18
 
 
 2.23.2 高技能人才
 http://116.228.176.34:9002/chuangke-serve/highskill/add
 
 添加时参数
 职称 jobTitle	1级
 职称级别 jobTitleLevel	58c7c83e4c1aca850999b3d8
 人员姓名 name	小红
 resourceIds
 
 
 审批通过时参数：
 id	599ad8e2a92b0b6e2c93001d
 jobTitle	1级
 jobTitleLevel	专家
 memo
 name	小红
 scoreRead	4
 status	fail
 statusRead	审核中
 
 typeIndex	19
 
 2.23.4 规划目标
 http://116.228.176.34:9002/chuangke-serve/companygoal/add
 typeIndex	15
 
 添加时参数
 longTermGoal	1000万
 mediumTermGoal	100万
 resourceIds
 shortTermGoal	10万
 
 审核时参数
 id	599ad9ada92b0b6e2c93001e
 longTermGoal	1000万
 mediumTermGoal	100万
 memo
 resourceIds
 scoreRead	3
 shortTermGoal	10万
 status	success
 statusRead	审核中
 
 2.23.5 规模制度
 http://116.228.176.34:9002/chuangke-serve/comsummatebylaws/add
 typeIndex	17
 
 添加时参数
 制度文件名称 bylawsFileName	工商证书
 制度文件类别 bylawsFileType	工商
 resourceIds
 
 
 审核时参数
 bylawsFileName	工商证书
 bylawsFileType	工商
 id	599ada03a92b0b6e2c93001f
 memo
 scoreRead	0
 status	success
 statusRead	审核中
 
 2.23.6 投融资情况
 http://116.228.176.34:9002/chuangke-serve/investmentandfinancing/add
 
 typeIndex	20
 
 添加数据： 此时提交时investmentInstitutions需要传数组
 注意 提交融资情况 http://116.228.176.34:9002/chuangke-serve/investmentandfinancing/save
 投资金额 investmentAmount	300000
 投资机构1 investmentInstitutions	111
 投资机构2 investmentInstitutions	222
 投资机构3 investmentInstitutions	333
 投资轮次 investmentWheel	A
 resourceIds
 
 审核数据：
 id	599ada81a92b0b6e2c930020
 investmentAmount	20000
 investmentInstitutions	[机构1, 机构2, 机构3]
 investmentWheel	B
 memo
 scoreRead	2010
 status	success
 statusRead	审核中
 
 
 2.23.7 社保缴纳
 http://116.228.176.34:9002/chuangke-serve/companyresource/add
 typeIndex	16
 
 添加时参数
 公司账号 companyAccount	xxx
 职工人数 employeeNumber	2
 身份证号 idCards	121342142112
 投保人数 insureNumber	2
 职工姓名 newEmployeeNames	小明
 resourceIds	、
 
 审批时参数
 companyAccount	xxx
 employeeNumber	2
 id	599adb23a92b0b6e2c930021
 idCards	[121342142112]
 insureNumber	2
 memo
 newEmployeeNames	[小明]
 scoreRead	2
 status	success
 statusRead	审核中
 
 2.23.8 社会责任履行
 http://116.228.176.34:9002/chuangke-serve/socialresponsibility/detail?id=5999bd6da92b0b6e2c92fb8b
 typeIndex	22
 
 添加时参数
 参加人数 employeeNumber	2
 活动名称 name	asdsa
 resourceIds
 活动类型 type	慈善募捐
 
 审核时参数
 employeeNumber	2
 id	599adbc6a92b0b6e2c930022
 memo
 name	asdsa
 scoreRead	2
 status	success
 statusRead	审核中
 type	慈善募捐
 
 2.23.9 税务正规化
 http://116.228.176.34:9002/chuangke-serve/taxnormalization/add
 typeIndex	23
 
 添加时参数
 会计证书 accountIdentityUS	23434523453
 会计名 accountName	小红
 resourceIds
 税号 taxNo	24789237489ew
 
 审核时参数
 accountIdentityUS	23434523453
 accountName	小红
 id	599adc27a92b0b6e2c930023
 memo
 scoreRead	1
 status	success
 statusRead	审核中
 taxNo	24789237489ew
 
 2.23.10 员工福利
 http://116.228.176.34:9002/chuangke-serve/benefit/add
 typeIndex	14
 
 添加时参数
 福利占收入比 benefitPercent	50
 福利人数 benefitPerson	3
 福利名称 name	福利
 resourceIds
 福利金额 totalBenefitMoney	30000
 
 审核时参数
 benefitPercent	50.0
 benefitPerson	3
 id	599adc9fa92b0b6e2c930024
 memo	
 name	福利
 resourceIds	
 scoreRead	100
 status	success
 statusRead	审核中
 totalBenefitMoney	30000
 
 
 */
