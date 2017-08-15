//
//  zhuyeVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/18.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "zhuyeVC.h"
#import "MyView.h"
#import "MyView2.h"
#import "ShiTiVC.h"
#import "XuNiVC.h"
#import "WenDangVC.h"
#import "KaiTongZhuXianViewController.h"
#import "RiChangHuoYueVC.h"
#import "WoDeZiYuanViewController.h"
#import "ShenSuViewController.h"
#import "DianZiHeTongViewController.h"
#import "FuWuViewController.h"
#import "keJiChuanXinGuanLiVC.h"
#import "YuanGongViewController.h"
#import "GenZongViewController.h"
#import "PaiHangBangViewController.h"
#import "HuoDongLuYanViewController.h"
#import "DianZiHeTongVC.h"


@interface zhuyeVC ()

@end

@implementation zhuyeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView* footer=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 130)];
    footer.backgroundColor=self.view.backgroundColor;
    [self.tableview setTableFooterView:footer];
    
    
    
/*
    NSArray* ary1=@[@"实体入驻管理",@"电子合同管理",@"虚拟入驻管理",@"开通主线管理",@"申诉申请管理",@"资源配置管理"];
    NSArray* ary2=@[@"服务申请"];
    NSArray* ary3=@[@"模块",@"权限",@"角色",@"用户",@"员工列表",@"数据字典"];
    NSDictionary* dic1=[NSDictionary dictionaryWithObjectsAndKeys:ary1,@"创客入驻管理", nil];
    NSDictionary* dic2=[NSDictionary dictionaryWithObjectsAndKeys:ary2,@"服务申请管理", nil];
    NSDictionary* dic3=[NSDictionary dictionaryWithObjectsAndKeys:ary3,@"系统配置", nil];
    NSArray* ary=[NSArray arrayWithObjects:dic1,dic2,dic3, nil];
*/
    
    //前一个界面进行了数据存储，现在进行数据的获取
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray* arrays=[defaults objectForKey:@"chuangkexiaozhen.zhujiemian"];

    self.datas=arrays;

    

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:75/255.0 green:76/255.0 blue:77/255.0 alpha:1];
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController setNavigationBarHidden:YES];
    for (NSDictionary* datamap in self.datas) {
        NSArray* tmps=[datamap objectForKey:@"创客入驻管理"];
        for (NSString* data in tmps) {
            if([data isEqualToString:@"实体入驻管理"] || [data isEqualToString:@"虚拟入驻管理"]){
                self.isadmin=@"Y";
            }
            break;
        }
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.datas count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* str1=@"cell1";
    static BOOL isRegister1=NO;
    if(!isRegister1){
        UINib* nib=[UINib nibWithNibName:@"MyView" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:str1];
        isRegister1=YES;
    }
    
    static NSString* str2=@"cell2";
    static BOOL isRegister2=NO;
    if(!isRegister2){
        UINib* nib=[UINib nibWithNibName:@"MyView2" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:str2];
        isRegister2=YES;
    }
    long index=indexPath.row;
    NSDictionary* dic=[self.datas objectAtIndex:index];
    
    NSArray* ary=[dic allKeys];
    NSString* key=[ary objectAtIndex:0];
    NSArray* values=[dic objectForKey:key];
    
    UITableViewCell* cell;
    if([values count]>4){
        MyView2*cell2=[tableView dequeueReusableCellWithIdentifier:str2];
        [cell2 initWithTitle:key andValues:values];
        cell=cell2;
    }else{
        MyView* cell1=[tableView dequeueReusableCellWithIdentifier:str1];
        [cell1 initWithTitle:key andValues:values];
        cell=cell1;
    }

 //
    
    
 //   cell.selectionStyle = NO;
 //   [cell setShuJu:[_array objectAtIndex:indexPath.row]];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    long index=indexPath.row;
    NSDictionary* dic=[self.datas objectAtIndex:index];
    
    NSArray* ary=[dic allKeys];
    NSString* key=[ary objectAtIndex:0];
    NSArray* values=[dic objectForKey:key];
    if([values count]>4){
        return 250;
    }
    return 147;
}


- (IBAction)btnclick:(id)sender {
    UIButton* btn=(UIButton*)sender;
    NSString* data=btn.titleLabel.text;
    NSLog(@"%@,%@",@"click",data);
    
    if([data isEqualToString:@"实体入驻"]){
        NSLog(@"%@ 按钮被点击",data);
        UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"MyStoryboard1" bundle:nil];
        ShiTiVC*vc=[storyboard instantiateViewControllerWithIdentifier:@"ShiTiVC"];
        [self.navigationController pushViewController:vc animated:YES];
    }else if([data isEqualToString:@"虚拟入驻"]){
        NSLog(@"%@ 按钮被点击",data);
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"MyStoryboard1" bundle:nil];
        XuNiVC*vc=[board instantiateViewControllerWithIdentifier:@"XuNiVC"];
        [self.navigationController pushViewController:vc animated:YES];
    }else if([data isEqualToString:@"文档下载"]){
        NSLog(@"%@ 按钮被点击",data);
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"MyStoryboard1" bundle:nil];
        WenDangVC*vc=[board instantiateViewControllerWithIdentifier:@"WenDangVC"];
        [self.navigationController pushViewController:vc animated:YES];

    }else if([data isEqualToString:@"开通主线"]){
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"baodaoruzhu" bundle:nil];
        KaiTongZhuXianViewController*vc=[board instantiateViewControllerWithIdentifier:@"KaiTongZhuXianViewController"];
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"我的配置资源"]){
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"baodaoruzhu" bundle:nil];
        WoDeZiYuanViewController*vc=[board instantiateViewControllerWithIdentifier:@"WoDeZiYuanViewController"];
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"申诉申请"]){
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"baodaoruzhu" bundle:nil];
        ShenSuViewController*vc=[board instantiateViewControllerWithIdentifier:@"ShenSuViewController"];
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"电子合同"]){
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"baodaoruzhu" bundle:nil];
        DianZiHeTongViewController*vc=[board instantiateViewControllerWithIdentifier:@"DianZiHeTongViewController"];
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"日常活跃度考核"]){
        NSLog(@"%@ 按钮被点击",data);
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"RiChangHuoYue" bundle:nil];
        RiChangHuoYueVC*vc=[board instantiateViewControllerWithIdentifier:@"RiChangHuoYueVC"];
        [self.navigationController pushViewController:vc animated:YES];

    }else if([data isEqualToString:@"科技创新成熟度考核"]){
        NSLog(@"%@ 按钮被点击",data);
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"KeJiChuanXin" bundle:nil];
        keJiChuanXinGuanLiVC*vc=[board instantiateViewControllerWithIdentifier:@"keJiChuanXinGuanLiVC"];
        [self.navigationController pushViewController:vc animated:YES];

    }else if([data isEqualToString:@"市场销售成熟度考核"]){
        NSLog(@"%@ 按钮被点击",data);
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"ShiChangXiaoShou" bundle:nil];
        ShiChangXiaoShouVC*vc=[board instantiateViewControllerWithIdentifier:@"ShiChangXiaoShouVC"];
        [self.navigationController pushViewController:vc animated:YES];
        
    
    }else if([data isEqualToString:@"团队运营成熟度考核"]){
        NSLog(@"%@ 按钮被点击",data);
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"TuanDuiYunYing" bundle:nil];
        TuanDuiGuanLiVC*vc=[board instantiateViewControllerWithIdentifier:@"TuanDuiGuanLiVC"];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if([data isEqualToString:@"服务申请"]){//普通用户 管理员都会返回服务申请
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"YuanQuFuWu" bundle:nil];
        FuWuViewController*vc=[board instantiateViewControllerWithIdentifier:@"FuWuViewController"];
        vc.isadmin=_isadmin;
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"员工列表"]){
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"yuangongguanli" bundle:nil];
        YuanGongViewController*vc=[board instantiateViewControllerWithIdentifier:@"YuanGongViewController"];
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"考勤统计"]){//普通用户 管理员都会返回考勤统计
        NSLog(@"%@ 按钮被点击",data);
        
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"KaoQinGuanLi" bundle:nil];
        KaoQinGuanLiVC*vc=[board instantiateViewControllerWithIdentifier:@"KaoQinGuanLiVC"];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if([data isEqualToString:@"路演发布管理"]){
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"huodongluyan" bundle:nil];
        HuoDongLuYanViewController* vc=[board instantiateViewControllerWithIdentifier:@"HuoDongLuYanViewController"];
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"主动性退出管理"]){
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"被动性退出管理"]){
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"跟踪服务管理"]){
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"tuichu" bundle:nil];
        GenZongViewController*vc=[board instantiateViewControllerWithIdentifier:@"GenZongViewController"];
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"综合能力排行"]){
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"paihangbang" bundle:nil];
        PaiHangBangViewController*vc=[board instantiateViewControllerWithIdentifier:@"PaiHangBangViewController"];
        vc.paihangbangtype=@"ZongHeNengLi";
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"日活跃度排行"]){
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"paihangbang" bundle:nil];
        PaiHangBangViewController*vc=[board instantiateViewControllerWithIdentifier:@"PaiHangBangViewController"];
        vc.paihangbangtype=@"RiHuoYue";
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"科技创新能力排行"]){
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"paihangbang" bundle:nil];
        PaiHangBangViewController*vc=[board instantiateViewControllerWithIdentifier:@"PaiHangBangViewController"];
        vc.paihangbangtype=@"KeJiChuangXin";
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"市场业务能力排行"]){
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"paihangbang" bundle:nil];
        PaiHangBangViewController*vc=[board instantiateViewControllerWithIdentifier:@"PaiHangBangViewController"];
        vc.paihangbangtype=@"ShiChangPaiHang";
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"行政运营能力排行"]){
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"paihangbang" bundle:nil];
        PaiHangBangViewController*vc=[board instantiateViewControllerWithIdentifier:@"PaiHangBangViewController"];
        vc.paihangbangtype=@"XingZhengYunYing";
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"%@ 按钮被点击",data);
    }
    
    
    //注意一下内容只有管理员用户才有
    
    else if([data isEqualToString:@"答辩管理"]){
        NSLog(@"%@ 按钮被点击",data);
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"DaBianGuanLi" bundle:nil];
        DaBianGuanLiVC*vc=[board instantiateViewControllerWithIdentifier:@"DaBianGuanLiVC"];
        [self.navigationController pushViewController:vc animated:YES];
       
    }else if([data isEqualToString:@"实体入驻管理"]){
        NSLog(@"%@ 按钮被点击",data);
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"ShiTiRuZhuGuanLi" bundle:nil];
        ShiTiRuZhuGuanLivc*vc=[board instantiateViewControllerWithIdentifier:@"ShiTiRuZhuGuanLivc"];
        [self.navigationController pushViewController:vc animated:YES];
        

    }else if([data isEqualToString:@"虚拟入驻管理"]){
        NSLog(@"%@ 按钮被点击",data);

        UIStoryboard*board=[UIStoryboard storyboardWithName:@"XuNiRuZhu" bundle:nil];
        XuNiRuZhuVC*vc=[board instantiateViewControllerWithIdentifier:@"XuNiRuZhuVC"];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if([data isEqualToString:@"电子合同管理"]){
        NSLog(@"%@ 按钮被点击",data);
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"HeTongGuanLi" bundle:nil];
        DianZiHeTongVC*vc=[board instantiateViewControllerWithIdentifier:@"DianZiHeTongVC"];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if([data isEqualToString:@"开通主线管理"]){
        NSLog(@"%@ 按钮被点击",data);
        
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"KaiTongZhuXian" bundle:nil];
        KaiTongZhuXianVC*vc=[board instantiateViewControllerWithIdentifier:@"KaiTongZhuXianVC"];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if([data isEqualToString:@"申诉申请管理"]){
        NSLog(@"%@ 按钮被点击",data);
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"ShenSuShenQing" bundle:nil];
        ShenSuShenQingVC*vc=[board instantiateViewControllerWithIdentifier:@"ShenSuShenQingVC"];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if([data isEqualToString:@"资源配置管理"]){
        NSLog(@"%@ 按钮被点击",data);
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"ZiYuanPeiZhi" bundle:nil];
        ZiYuanPeiZhiVC*vc=[board instantiateViewControllerWithIdentifier:@"ZiYuanPeiZhiVC"];
        [self.navigationController pushViewController:vc animated:YES];
 
    }else if([data isEqualToString:@"日常活跃度材料审核"]){
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"RiChangHuoYue" bundle:nil];
        RiChangHuoYueVC*vc=[board instantiateViewControllerWithIdentifier:@"RiChangHuoYueVC"];
        vc.isadmin=@"Y";
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"科技创新材料审核"]){
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"KeJiChuanXin" bundle:nil];
        keJiChuanXinGuanLiVC*vc=[board instantiateViewControllerWithIdentifier:@"keJiChuanXinGuanLiVC"];
        vc.isadmin=@"Y";
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"市场成熟度管理"]){
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"ShiChangXiaoShou" bundle:nil];
        ShiChangXiaoShouVC*vc=[board instantiateViewControllerWithIdentifier:@"ShiChangXiaoShouVC"];
        vc.isadmin=@"Y";
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"%@ 按钮被点击..",data);
    }else if([data isEqualToString:@"行政运营材料审核"]){
        NSLog(@"%@ 按钮被点击",data);
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"TuanDuiYunYing" bundle:nil];
        TuanDuiGuanLiVC*vc=[board instantiateViewControllerWithIdentifier:@"TuanDuiGuanLiVC"];
        vc.isadmin=@"Y";
        [self.navigationController pushViewController:vc animated:YES];
    }else if([data isEqualToString:@"任务通告"]){
        NSLog(@"%@ 按钮被点击",data);
        
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"YuanQuRenWuTongGao" bundle:nil];
        YuanQuRenWuVC*vc=[board instantiateViewControllerWithIdentifier:@"YuanQuRenWuVC"];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if([data isEqualToString:@"发卡动作"]){
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"KaoQinGuanLi" bundle:nil];
        FaKaGuanLiVC*vc=[board instantiateViewControllerWithIdentifier:@"FaKaGuanLiVC"];
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"考勤逻辑"]){
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"路演发布管理"]){
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"签到统计管理"]){
        NSLog(@"%@ 按钮被点击",data);
        
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"QianDaoTongJi" bundle:nil];
        QianDaoTongJiVC*vc=[board instantiateViewControllerWithIdentifier:@"QianDaoTongJiVC"];
        [self.navigationController pushViewController:vc animated:YES];
        

    }else if([data isEqualToString:@"活动报销管理"]){
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"成果跟踪管理"]){
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"资源编辑"]){
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"主动性退出管理"]){
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"被动性退出管理"]){
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"跟踪服务管理"]){
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"模块"]){
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"权限"]){
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"角色"]){
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"用户"]){
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"数据字典"]){
        NSLog(@"%@ 按钮被点击",data);
    }
    
}







@end
