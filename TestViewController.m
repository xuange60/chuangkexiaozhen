//
//  TestViewController.m
//  chuangkexiaozhen
//
//  Created by zx on 17/7/26.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "TestViewController.h"

//接口测试文件
@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    self.bussinessapi=[[BussinessApi alloc] init];
    self.fuhuachengzguanli=[[FuHusChengZhangGuanLi alloc] init];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)login:(id)sender {
    BussinessApi* bussiness=[[BussinessApi alloc] init];
    // [bussiness loginWithName:@"gaogaihui" andPwd:@"123456"];
    //[bussiness loginWithName:@"zhangxuan" andPwd:@"111111"];
    [bussiness loginWithName:@"cash" andPwd:@"123456"];

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




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
