//
//  TestViewController.m
//  chuangkexiaozhen
//
//  Created by zx on 17/7/26.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "TestViewController.h"
#import "FilelistViewController.h"

//接口测试文件
@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    self.bussinessapi=[[BussinessApi alloc] init];
    self.fuhuachengzguanli=[[FuHusChengZhangGuanLi alloc] init];
    self.yuangongguanli=[[YuanGongGuanLi alloc] init];
    self.yuanqufuwushenqing=[[YuanQuFuWuShenQing alloc] init];
    _kaoqinguanli=[[KaoQinGuanLi alloc] init];
    _huodong=[[HuoDong alloc] init];
    _genzongfuwu=[[GenZongFuWu alloc] init];
    _paihangbang=[[PaiHangBang alloc] init];
    _dabianguanli=[[DaBianGuanLi alloc] init];
    _shitiruzhuguanli=[[ShiTiRuZhuGuanLi alloc] init];
    _shitiruzhuguanli.delegate=self;
    
    _dianzihetongguanli=[[DianZiHeTongGuanLi alloc] init];
    _dianzihetongguanli.delegate=self;
    
    _xuniruzhuguanli=[[XuNiRuZhuGuanLi alloc] init];
    _xuniruzhuguanli.delegate=self;
    
    _kaitongzhuxianguanli=[[KaiTongZhuXianGuanLi alloc] init];
    _kaitongzhuxianguanli.delegate=self;
    
    _shensushenqingguanli=[[ShenSuShenQingGuanLi alloc] init];
    _shensushenqingguanli.delegate=self;
    
    _ziyuanpeizhiguanli=[[ZiYuanPeiZhiGuanLi alloc] init];
    _ziyuanpeizhiguanli.delegate=self;
    
    
    _yuanqufuwuguanli=[[YuanQuFuWuGuanLi alloc] init];
    _yuanqufuwuguanli.delegate=self;
    
    _yuanqurenwutonggao=[[YuanQuRenWuTongGao alloc] init];
    _yuanqurenwutonggao.delegate=self;
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)loadNetworkFinished:(id)data
{
    if([data isKindOfClass:[NSArray class]]){
        NSLog(@"count=%lu",(unsigned long)[(NSArray*)data count]);
        
    }
    NSLog(@"%@",data);
}



- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)test:(id)sender {
    FilelistViewController* filelist=[[FilelistViewController alloc] initView];
    [self presentViewController:filelist animated:YES completion:nil];
}





- (IBAction)login:(id)sender {
    BussinessApi* bussiness=[[BussinessApi alloc] init];
    // [bussiness loginWithName:@"gaogaihui" andPwd:@"123456"];
    [bussiness loginWithName:@"admin" andPwd:@"123123"];
   // [bussiness loginWithName:@"cash" andPwd:@"123456"];

}
- (IBAction)shitiruzhuquery:(id)sender {
    BussinessApi* bussiness=[[BussinessApi alloc] init];
    [bussiness shiTiRuZhuQuery];
}

//- (IBAction)shitiruzhufileup:(id)sender {
//    UIImage *image = [UIImage imageNamed:@"Snip20170722_1"];
//    NSData *data = UIImagePNGRepresentation(image);
//    BussinessApi* bussiness=[[BussinessApi alloc] init];
//    [bussiness shitiRuZhuFileup:data withType:@"png"];
//}
//- (IBAction)shitiruzhusubmit:(id)sender {
//    BussinessApi* bussiness=[[BussinessApi alloc] init];
//    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:@"电子信息",@"businessline",@"测试机构",@"companyname",@"小刚",@"contact",@"18576672852",@"contacttype",@"初创团队",@"description",@"597a200480ab5e6790d51fdd,597a213880ab5e6790d51fde",@"resourceids", nil];
//    [bussiness shiTiRuZhuSubmitWithParam:param];
//}


- (IBAction)xuniruzhusubmit:(id)sender {
    BussinessApi* bussiness=[[BussinessApi alloc] init];
    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:@"测试公司",@"branchname",@"小红",@"contact",@"18676672851",@"contacttype",@"展示推介机会,投融资需求,信息技术需求",@"coopcategories",@"备注备注备注备注",@"desc", nil];
    [bussiness xuniRuZhuSubmitWithParam:param];
}

- (IBAction)chushishenqingfilequery:(id)sender {
    BussinessApi* bussiness=[[BussinessApi alloc] init];
    [bussiness chushishenqingFileQuery];
}

- (IBAction)shitiruzhufiledelete:(id)sender {
    BussinessApi* bussiness=[[BussinessApi alloc] init];
    [bussiness chushishenqingFileDelete:@"597a29e480ab5e6790d51fe3"];
}

- (IBAction)bisaiguanlifiledelete:(id)sender {
    BussinessApi* bussiness=[[BussinessApi alloc] init];
    [bussiness biSaiGuanLiFileDelete:@"597c955280ab5e6790d528ba" withEntityId:@"597c955a80ab5e6790d528bb"];
}


- (IBAction)chanxueyanquery:(id)sender {
    BussinessApi* bussiness=[[BussinessApi alloc] init];
    [bussiness chanXueYanQuery];
}

- (IBAction)chanxueyansubmit:(id)sender {
    BussinessApi* bussiness=[[BussinessApi alloc] init];
    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:@"设计大赛2",@"name",@"100万元",@"moneyLevel",@"1000000",@"money",@"合作机构一级",@"level",@"合作愉快",@"effect",@"",@"resourceIds", nil];
    [bussiness chanXueYanSubmit:param];
}

- (IBAction)chanxueyandelete:(id)sender {
    BussinessApi* bussiness=[[BussinessApi alloc] init];
    [bussiness chanXueYanDelete:@"597d4c2f80ab5e6790d52d17"];
}
- (IBAction)chanxueyanfilequery:(id)sender {
    BussinessApi* bussiness=[[BussinessApi alloc] init];
    [bussiness chanXueYanQueryFile:@"597cc95080ab5e6790d528c3"];
}

- (IBAction)chanxueyanfiledelete:(id)sender {
    BussinessApi* bussiness=[[BussinessApi alloc] init];
    [bussiness chanXueYanDelete:@"597cc90c80ab5e6790d528c2" withEntityId:@"597cc95080ab5e6790d528c3"];
}


- (IBAction)huodongquery:(id)sender {
    BussinessApi* bussiness=[[BussinessApi alloc] init];
    [bussiness huoDongQuery];
}

- (IBAction)huodongsubmit:(id)sender {
    BussinessApi* bussiness=[[BussinessApi alloc] init];
    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:@"省市级活动",@"activityLevel",@"唱歌比赛",@"name",@"2",@"participant",@"深圳市政府",@"sponsor",@"",@"resourceIds", nil];
    [bussiness huoDongSubmit:param];
}

- (IBAction)huodongdelete:(id)sender {
    BussinessApi* bussiness=[[BussinessApi alloc] init];
    [bussiness huoDongDelete:@"597d505080ab5e6790d52d1a"];
}


- (IBAction)huodongfilequery:(id)sender {
    BussinessApi* bussiness=[[BussinessApi alloc] init];
    [bussiness huoDongQueryFile:@"597d5ead80ab5e6790d52d1f"];
}

- (IBAction)huodongfiledelete:(id)sender {
    BussinessApi* bussiness=[[BussinessApi alloc] init];
    [bussiness huoDongDelete:@"597d5e9e80ab5e6790d52d1d" withEntityId:@"597d5ead80ab5e6790d52d1f"];
}
- (IBAction)back1:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)zhuanyezhishichanquanquery:(id)sender {
    [_bussinessapi zhuanYeZhiShiQuery];
}

- (IBAction)zhuanyezhishichanquansubmit:(id)sender {
    NSDictionary* dic=[NSDictionary dictionaryWithObjectsAndKeys:@"1234567890",@"code",@"知识产权1",@"name",@"软件著作权",@"type",@"",@"resourceIds", nil];
    [_bussinessapi zhuanYeZhiShiSubmit:dic];
    
}


- (IBAction)zhuanyezhishichanquandelete:(id)sender {
    [_bussinessapi zhuanYeZhiShiDelete:@"597d615280ab5e6790d52d24"];
}


- (IBAction)zhuanyezhishichanquanfilequery:(id)sender {
    [_bussinessapi zhuanYeZhiShiFileQuery:@"597d60ea80ab5e6790d52d23"];
}



- (IBAction)zhuanyezhishichanquanfiledelete:(id)sender {
    [_bussinessapi zhuanYeZhiShiFileDelete:@"597d60d680ab5e6790d52d21" withEntityId:@"597d60ea80ab5e6790d52d23"];
    
}




- (IBAction)bisaiguanliquery:(id)sender {
    [_bussinessapi jiangLiQuery];
}

/*
名称 name	羽毛球奖
级别 awardLevel	58c7c7094c1a775d6de79f72
单位 awardunit	体委
编码 code	131231
文件id  resourceIds	597d6fcb80ab5e6790d52d2a,597d6fcf80ab5e6790d52d2b
<option value="58c7c7094c1a775d6de79f72">一级奖励</option>
<option value="58c7c7094c1a775d6de79f73">二级奖励</option>
<option value="58c7c7094c1a775d6de79f74">三级奖励</option>
 */
- (IBAction)bisaiguanliadd:(id)sender {
    NSDictionary* dic=[NSDictionary dictionaryWithObjectsAndKeys:@"羽毛球奖",@"name",@"一级奖励",@"awardLevel",@"1231",@"awardunit",@"124312312",@"code",@"",@"resourceIds", nil];
    [_bussinessapi jiangLiSubmit:dic];
}

- (IBAction)bisaiguanlidelete:(id)sender {
    [_bussinessapi jiangLiDelete:@"597d700b80ab5e6790d52d2c"];
}


- (IBAction)bisaiguanlifilequery:(id)sender {
    [_bussinessapi jiangLiFileQuery:@"597d700b80ab5e6790d52d2c"];
}

- (IBAction)bisaifiledelete:(id)sender {
    [_bussinessapi jiangLiFileDelete:@"597d6fcf80ab5e6790d52d2b" withEntityId:@"597d700b80ab5e6790d52d2c"];
}




- (IBAction)xiangmuquery:(id)sender {
    [_bussinessapi xiangMuQuery];
}


- (IBAction)xiangmusubmit:(id)sender {
    NSDictionary* dic=[NSDictionary dictionaryWithObjectsAndKeys:@"1231312",@"code",@"深圳",@"competentunit",@"测试",@"name",@"省部级",@"projectLevel",@"",@"resourceIds", nil];
    [_bussinessapi xiangMuSubmit:dic];
}

- (IBAction)xiangmudelete:(id)sender {
    [_bussinessapi xiangMuDelete:@"597d6d7b80ab5e6790d52d28"];
}


- (IBAction)xiangmufielquery:(id)sender {
    [_bussinessapi xiangMuFileQuery:@"597d6d7b80ab5e6790d52d28"];
    
}


- (IBAction)xiangmufiledelete:(id)sender {
    [_bussinessapi xiangMuFileDelete:@"597d6d7480ab5e6790d52d27" withEntityId:@"597d6d7b80ab5e6790d52d28"];
}


- (IBAction)xiaoshouhetongguanliquery:(id)sender {
    [_fuhuachengzguanli XiaoShouHeTongQuery];
   
}

- (IBAction)xiaoshouhetongsubmit:(id)sender {
    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:@"",@"arrivalResourceIds",@"",@"benefitResourceIds",@"产品销售合同",@"pactName",@"二级合作方",@"partnerLevel",@"30000",@"partnerPrice", @"10000元级别",@"saleBenefit",@"1万",@"saleMoney",@"1000",@"societyBenefit",nil];
    [_fuhuachengzguanli XiaoShouHeTongSubmit:param];
}

- (IBAction)xiaoshouhetongdelete:(id)sender {
    [_fuhuachengzguanli XiaoShouHeTongDelete:@"594b6f3a075910c2d60d08e6"];
}

- (IBAction)xioaoshouhetongfilequery:(id)sender {
    [_fuhuachengzguanli XiaoShouHeTongFileQuery:@"59809b9480ab5e6790d536d3"];
}

- (IBAction)xiashouhetongfiledelete:(id)sender {
    [_fuhuachengzguanli XiaoShouHeTongFileDelete:@"59809b8c80ab5e6790d536d1" withEntityId:@"59809b9480ab5e6790d536d3"];
}


- (IBAction)nashuiguanliquery:(id)sender {
    [_fuhuachengzguanli NaShuiGuanLiQuery];
}


- (IBAction)nashuiguanlisubmit:(id)sender {
    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:@"纳税季度级别",@"dateType",@"10000元级别",@"taxLevel",@"5000",@"taxPrice",@"",@"taxResourceIds",@"公司",@"taxTarget",@"国税",@"taxType", nil];
    [_fuhuachengzguanli NaShuiGuanLiSubmit:param];
}

- (IBAction)nashuiguanlidelete:(id)sender {
    [_fuhuachengzguanli NaShuiGuanLiDelete:@"5938ee2e075910c2d60d07e7"];
}




- (IBAction)nashuiguanlifilequery:(id)sender {
    [_fuhuachengzguanli NaShuiGuanLiFileQuery:@"5981d65280ab5e6790d53b4d"];
}


- (IBAction)nashuiguanlifiledelete:(id)sender {
    [_fuhuachengzguanli NaShuiGuanLiFileDelete:@"5981d64d80ab5e6790d53b4b" withEntityId:@"5981d65280ab5e6790d53b4d"];
}




- (IBAction)shichangzhanyoulvquery:(id)sender {
    [_fuhuachengzguanli ShiChangZhanYouQuery];
}


- (IBAction)shichangzhanyoulvssubmit:(id)sender {
    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:@"",@"investigateResourceIds",@"ceshi",@"marketDetail",@"20",@"marketPercent",@"jigou",@"organizationName",@"占有率级别5%",@"percentLevel", nil];
    [_fuhuachengzguanli ShiChangZhanYouSubmit:param];
}


- (IBAction)shichangzhanyoulvdelete:(id)sender {
    [_fuhuachengzguanli ShiChangZhanYouDelete:@"5938edcc075910c2d60d07e6"];
}


- (IBAction)shicahngzhenyoulvfilequery:(id)sender {
    [_fuhuachengzguanli ShiChangZhanYouFileQuery:@"5980a0fc80ab5e6790d536db"];
}

- (IBAction)shichangzhenyoulvfiledelete:(id)sender {
    [_fuhuachengzguanli ShiChangZhanYouFileDelete:@"5980a0f980ab5e6790d536da" withEntityId:@"5980a0fc80ab5e6790d536db"];
}






- (IBAction)renyuanjiegouquery:(id)sender {
    [_fuhuachengzguanli RenYuanJieGouQuery];
}


- (IBAction)renyuanjiegousubmit:(id)sender {
    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:@"4",@"marketPerson",@"50",@"marketPersonPercent",@"2",@"operatePerson",@"25",@"operatePersonPercent",@"2",@"techniquePerson",@"25",@"techniquePersonPercent",@"8",@"toltalPerson",@"",@"resourceIds", nil];
    [_fuhuachengzguanli RenYuanJieGouSubmit:param];
}


- (IBAction)renyuanjiegoudelete:(id)sender {
    [_fuhuachengzguanli RenYuanJieGouDelete:@"5981d8cf80ab5e6790d53b51"];
}


- (IBAction)renyuanjiegoufilequery:(id)sender {
    [_fuhuachengzguanli RenYuanJieGouFileQuery:@"5980a57c80ab5e6790d536df"];
}


- (IBAction)renyuanjiegoufiledelete:(id)sender {
    [_fuhuachengzguanli RenYuanJieGouFileDelete:@"5980a57580ab5e6790d536dd" withEntityId:@"5980a57c80ab5e6790d536df"];
}






- (IBAction)yuanqufuwushenqingquery:(id)sender {
    [_yuanqufuwushenqing YuanQuFuWuQuery];
    
}


- (IBAction)yuanqufuwushenqingsubmit:(id)sender {
    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:@"xxxxxtest",@"content",@"59830a1f80ab5e6790d53ff9,59830a3980ab5e6790d53ffa",@"resourceIds",@"企业培训",@"serveCategory", nil];
    [_yuanqufuwushenqing YuanQuFuWuSubmit:param];
}


- (IBAction)yuanqufuwushenqingdelete:(id)sender {
    [_yuanqufuwushenqing YuanQuFuWuDelete:@"5981ec8e80ab5e6790d53b5b"];
}



- (IBAction)yuanqufuwushenqingfilequery:(id)sender {
    [_yuanqufuwushenqing YuanQuFuWuFileQuery:@"5981dedc80ab5e6790d53b58"];
}


- (IBAction)yuanqufuwushenqingfiledelete:(id)sender {
    [_yuanqufuwushenqing YuanQuFuWuFileDelete:@"5981ded080ab5e6790d53b56" withEntityId:@"5981dedc80ab5e6790d53b58"];
}








- (IBAction)yuangongquery:(id)sender {
    [_yuangongguanli YuanGongQuery];
    
}

- (IBAction)yuangongsubmit:(id)sender {
    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:@"测试部门",@"department",@"111@qq.com",@"email",@"",@"id",@"ceshi111",@"loginName",@"18511111111",@"mobilePhone",@"测试用户",@"name",@"123456",@"password",@"1",@"rank",@"beizhu",@"remark", nil];
    [_yuangongguanli YuanGongSubmit:param];
}

- (IBAction)yuangongdeldte:(id)sender {
    [_yuangongguanli YuanGongDelete:@"5981ee1f80ab5e6790d53b60"];
}

- (IBAction)yuangongupdate:(id)sender {
    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:@"测试部门",@"department",@"111_asdadas@qq.com",@"email",@"5981eeb580ab5e6790d53b62",@"id",@"ceshi111",@"loginName",@"18511111111",@"mobilePhone",@"测试用户222",@"name",@"123456",@"password",@"1",@"rank",@"beizhu",@"remark", nil];
    [_yuangongguanli YuanGongSubmit:param];
}




- (IBAction)kaoqinquery:(id)sender {
    [_kaoqinguanli KaoQinQueryStart:@"2017-08-04 00:00:00" End:@"2017-08-04 23:59:59"];
}



- (IBAction)kaoqindetailquery:(id)sender {
    [_kaoqinguanli KaoQinDetailQuery:@"58f9d2ea19eb8cbffbb87b23" date:@"2017-08-04"];
}



- (IBAction)luyanquery:(id)sender {
    [_huodong HuoDongLuYanQuery];
}



- (IBAction)luyanxiangqingquery:(id)sender {
    [_huodong HuoDongLuYanDetailQuery:@"596b820b80ab5e6790d4f05a"];
}




- (IBAction)genzongfuwuquery:(id)sender {
    [_genzongfuwu GenZongFuWuQuery];
}



- (IBAction)genzongfuwusubmit:(id)sender {
    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:@"xxxxx",@"content",@"反馈意见",@"title", nil];
    [_genzongfuwu GenZongFuWuSubmit:param];
    
}



- (IBAction)genzongfuwudelete:(id)sender {
    [_genzongfuwu GenZongFuWuDelete:@"59853bb080ab5e6790d5491d"];
}


- (IBAction)zonghenenglipaihang:(id)sender {
    [_paihangbang ZongHeNengLiQuery];
}


- (IBAction)zonghenengliscore:(id)sender {
    [_paihangbang ZongHeNengLiDetailQuery:@"5937757d075910c2d60d07bf"];
}


- (IBAction)rihuoyuedupaihang:(id)sender {
    [_paihangbang RiHuoYueQuery];
}



- (IBAction)rihuoyueduscore:(id)sender {
    [_paihangbang RiHuoYueDelatiQuery:@"58e5eab219eb64c4e63875f3"];
}



- (IBAction)kejichuangxinpaihang:(id)sender {
    [_paihangbang KeJiChuangXinQuery];
}



- (IBAction)kejichuangxinscore:(id)sender {
    [_paihangbang KeJiChuangXinDetailQuery:@"58e5eab219eb64c4e63875f3"];
}




- (IBAction)shichangyewupaihang:(id)sender {
    [_paihangbang ShiChangPaiHangQuery];
}



- (IBAction)shicahngyewuscore:(id)sender {
    [_paihangbang ShiChangPaiHangDetailQuery:@"58e5eab219eb64c4e63875f3"];
}



- (IBAction)xingzhengyunyingpaihang:(id)sender {
    [_paihangbang XingZhengYunYingQuery];
}



- (IBAction)xingzhengyunyingscore:(id)sender {
    [_paihangbang XingZhengYunYingDetailQuery:@"5937757d075910c2d60d07bf"];
}



- (IBAction)dabianguanliquery:(id)sender {
    [_dabianguanli DaBianGuanLiQuery];
    
}


- (IBAction)dabianguanlidelete:(id)sender {
    [_dabianguanli DaBianDelete:@"59888c1422637b17beb2f882"];
}





- (IBAction)dabianguanlidafen2:(id)sender {
    NSArray* ary1=[NSArray arrayWithObjects:@"与园区方向切合度",@"项目创新性和独特性",@"项目团队运营能力",@"项目市场业务能力",@"项目产品技术研发能力", nil];
    NSArray* ary2=[NSArray arrayWithObjects:@"90",@"90",@"90",@"90",@"90", nil];
    NSMutableDictionary* param=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"true",@"agreeApplyin",@"598b25e722637b17beb30166",@"applyTreatId",@"",@"resourceIds",ary1,@"reasons",ary2,@"scores", nil];
    [_dabianguanli DaBianPingFenAdd:param];
}



- (IBAction)shitiruzhugunliquery:(id)sender {
    [_shitiruzhuguanli ShiTiRuZhuGuanLiQuery];
}



- (IBAction)shitiruzhuNo:(id)sender {
    [_shitiruzhuguanli ShiTiRuZhuGuanLiJuJue:@"59798aff80ab5e6790d51fd8"];
}


- (IBAction)shitiruzhuCancleNo:(id)sender {
    [_shitiruzhuguanli ShiTiRuZhuGuanLiJuJueCancle:@"59798aff80ab5e6790d51fd8"];
}


- (IBAction)shitiruzhuYes:(id)sender {
    [_shitiruzhuguanli ShiTiRuZhuGuanLiTongGuo:@"597a0a1680ab5e6790d51fda"];
}


- (IBAction)shitiruzhudelete:(id)sender {
    [_shitiruzhuguanli ShiTiRuZhuDelete:@"59798aff80ab5e6790d51fd8"];
}

/*
记录id applyid
评审专家id userIds
答辩时间 defenceDateStr
答辩地点 addr
*/
- (IBAction)shitiruzhuadddabian:(id)sender {
    [_shitiruzhuguanli DaBianZhuanJiaQuery];
    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:@"597a26d180ab5e6790d51fe1",@"applyid",@"5875a60bee19799d1cc83824",@"userIds",@"2017-08-10",@"defenceDateStr",@"上海答辩",@"addr", nil];
    [_shitiruzhuguanli TiJiaoDaBianShenQing:param];
}

/*
 参数：businessLine	电子信息
 companyName	克里斯蒂
 contact	浮动浮动
 contactType	354657648611
 description	初创团队
 id	597af69d80ab5e6790d5243d
 */

- (IBAction)shitiruzhumodify:(id)sender {
    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:@"597a0a1680ab5e6790d51fda",@"id",@"初创团队",@"description",@"354657648611",@"contactType",@"xiugai",@"contact",@"ceshijigou",@"companyName",@"电子信息",@"businessLine", nil];
    [_shitiruzhuguanli ShiTiRuZhuModify:param];
}





- (IBAction)dianzihetongquery:(id)sender {
    [_dianzihetongguanli DianZiHeTongQuery];
}


- (IBAction)xuniruzhuquery:(id)sender {
    [_xuniruzhuguanli XuNiRuZhuGuanLiQuery];
    
}


- (IBAction)xuniruzhuno:(id)sender {
    [_xuniruzhuguanli XuNiRuZhuGuanLiNo:@"596b2d9380ab5e6790d4f04e"];
}


- (IBAction)xuniruzhudelete:(id)sender {
    [_xuniruzhuguanli XuNiRuZhuGuanLiDelete:@"596b29a680ab5e6790d4f04b"];
}


- (IBAction)xuniruzhuyes:(id)sender {
    [_xuniruzhuguanli XuNiRuZhuGuanLiYes:@"596cd43b80ab5e6790d4f4ba"];
}

/*
 2.10.3 虚拟入驻申请修改 --
 参数 post id:id,contact:contact,contacttype:contactType,branchname:branchName,coopcategories
 :coopcategoriesStr,desc:desc}
 http://116.228.176.34:9002/chuangke-serve/apply/update/resapply
 */
- (IBAction)xuniruzhumodify:(id)sender {
    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:@"596cd43b80ab5e6790d4f4ba",@"id",@"xioagao1",@"contact",@"18577777777",@"contacttype",@"12312312000",@"branchname",@"投融资需求,信息技术需求",@"coopcategories",@"ceshishuju",@"desc", nil];
    [_xuniruzhuguanli XuNiRuZhuGuanLiModify:param];
}




- (IBAction)kaitongzhuxianquery:(id)sender {
    [_kaitongzhuxianguanli KaiTongZhuXianQuery];
    
}



- (IBAction)kaitongzhuxiandelete:(id)sender {
    [_kaitongzhuxianguanli KaiTongZhuXianDelete:@"58e5fd0d19eb64c4e63875f5"];
}



- (IBAction)shensuqingqiuquery:(id)sender {
    [_shensushenqingguanli ShenSuShenQingQuery];
}



- (IBAction)shensuqingqiudelete:(id)sender {
    [_shensushenqingguanli ShenSuShenQingDelete:@"59361bad075910c2d60d0791"];
}




- (IBAction)shensuqingqiusucc:(id)sender {
    [_shensushenqingguanli ShenSuShenQingSucc:@"597a0c0480ab5e6790d51fdb"];
}



- (IBAction)ziyuanpeizhiquery:(id)sender {
    
    [_ziyuanpeizhiguanli ZiYuanGuanLiQuery];
}

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
- (IBAction)ziyuanpeizhimodify:(id)sender {
    NSArray* ary1=[NSArray arrayWithObjects:@"58e6005f19eb64c4e63875fd", nil];
    NSArray* ary2=[NSArray arrayWithObjects:@"58e600f419eb64c4e6387604", nil];
    NSArray* ary3=[NSArray array];
    NSArray* ary4=[NSArray arrayWithObjects:@"58f58e5119eb8cbffbb87ad5", nil];
    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:@"",@"concatType",@"hello",@"desc",@"597d825c80ab5e6790d52d62",@"id",@"xiaoming",@"name",@"4",@"numberOfOffice",@"4",@"numberOfegc",@"4",@"numberOfoe",@"4",@"numberOfpl",@"4",@"numberOftc",@"xzczx",@"printAccount",@"123123wqe",@"printPassword",ary1,@"EgcCodes",ary2,@"OeCodes",ary3,@"PlCodes",ary4,@"TcCodes",nil];
    [_ziyuanpeizhiguanli ZiYuanGuanLiModify:param];
}



- (IBAction)ziyuanpeizhidelete:(id)sender {
    [_ziyuanpeizhiguanli ZiYuanGuanLiDelete:@"58f9cfa419eb8cbffbb87b18"];
}

- (IBAction)ziyuanpeizhidetailquery:(id)sender {
    [_ziyuanpeizhiguanli ZiYuanGuanLiDetailQuery:@"597d825c80ab5e6790d52d62"];
}




- (IBAction)fuwushenqingqueryadmin:(id)sender {
    [_yuanqufuwuguanli YuanQuFuWuQuerywithAdmin];
    
}


- (IBAction)fuwushenqingshouli:(id)sender {
    [_yuanqufuwuguanli YuanQuFuWuSucc:@"5983509880ab5e6790d5401c"];
}



- (IBAction)renwutonggaochaxun:(id)sender {
    [_yuanqurenwutonggao YuanQuRenWuQuery];
}



- (IBAction)renwutonggaoshanchu:(id)sender {
    [_yuanqurenwutonggao YuanQuRenWuDelete:@"5969ecc580ab5e6790d4ebf7"];
}

- (IBAction)renwutonggaowancheng:(id)sender {
    [_yuanqurenwutonggao YuanQuRenWuSucc:@"598ff9c822637b17beb31417"];
}


/*
 添加任务通告
 参数：
 通告类型 category 整理内务
 通告内容 content xxxx
 截止时间 enddate 2017-08-14 14:38:31
 file
 紧急程度 levels 紧急
 通告主题 name ceshi
 文件id resourceIds 598ff39922637b17beb31415
 涉及人员 users 597d807680ab5e6790d52d45 users 597db39c80ab5e6790d52d6a
 workId
 */
- (IBAction)renwutonggaoadd:(id)sender {
    NSArray* ary=[NSArray arrayWithObjects:@"5966cdcc80ab5e6790d4e34d", nil];
    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:@"整理内务",@"category",@"测试任务通知",@"content",@"2017-08-28 15:05:11",@"enddate",@"紧急",@"levels",@"任务通知",@"name",@"",@"resourceIds",ary,@"users", nil];
    [_yuanqurenwutonggao YuanQuRenWuParamQuery];
    [_yuanqurenwutonggao YuanQuRenWuAdd:param];
}


- (IBAction)renwutonggaodetailquery:(id)sender {
    [_yuanqurenwutonggao YuanQuRenWuDetail:@"598ff9c822637b17beb31417"];
}



- (IBAction)qiandaotongji:(id)sender {
    QianDaoTongJi* qiandaotongji=[[QianDaoTongJi alloc] init];
    qiandaotongji.delegate=self;
    
    [qiandaotongji QianDaoTongJiQuery];
    [qiandaotongji QianDaoTongJiDelete:@"5991dacfa92b0b6e2c92dfdf"];
    
    [qiandaotongji QianDaoTongJiQueryParam];

    NSDictionary* dic=[NSDictionary dictionaryWithObjectsAndKeys:@"30",@"actualNum",@"75.00%",@"percent",@"xxxxxx",@"remark",@"596b820b80ab5e6790d4f05a",@"roadshows",@"80",@"shouldNum",@"",@"otherResourceIds",@"",@"signResourceIds", nil];
//    [qiandaotongji QianDaoTongJiAdd:dic];
    
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
