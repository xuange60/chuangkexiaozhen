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
#import "KaoQinLuoJiVC.h"

@interface zhuyeVC ()

@end

@implementation zhuyeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView* footer=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 130)];
    footer.backgroundColor=self.view.backgroundColor;
    [self.tableview setTableFooterView:footer];
    
    
    //前一个界面进行了数据存储，现在进行数据的获取
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray* arrays=[defaults objectForKey:@"chuangkexiaozhen.zhujiemian"];

    self.datas=arrays;


}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _count=0;
    self.timer=[NSTimer scheduledTimerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
        _count++;
        if(_count>2) _count=0;
        if(_count==0){
            _imgview.image=[UIImage imageNamed:@"about-us.jpg"];
        }else if(_count==1){
            _imgview.image=[UIImage imageNamed:@"about-us-1.jpg"];
        }else if(_count==2){
            _imgview.image=[UIImage imageNamed:@"about-us-2.jpg"];
        }
    }];
    
    [self loadCookie];
    
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


-(void)viewWillDisappear:(BOOL)animated
{
    [_timer invalidate];
    _timer=nil;
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
        if(cell2==nil){
            UINib* nib=[UINib nibWithNibName:@"MyView2" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:str2];
            cell2=[tableView dequeueReusableCellWithIdentifier:str2];
        }
        
        [cell2 initWithTitle:key andValues:values];
        cell=cell2;
    }else{
        MyView* cell1=[tableView dequeueReusableCellWithIdentifier:str1];

        if(cell1==nil){
            UINib* nib=[UINib nibWithNibName:@"MyView" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:str1];
            cell1=[tableView dequeueReusableCellWithIdentifier:str1];
        }
        [cell1 initWithTitle:key andValues:values];        
        cell=cell1;
    }

    
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
        return 221;
    }
    return 147;
}


- (IBAction)btnclick:(id)sender {
    UIButton* btn=(UIButton*)sender;
    NSString* data=btn.titleLabel.text;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary* logindata=[defaults objectForKey:@"chuangkexiaozhen.login"];
    BOOL isLogin=NO;
    if(logindata!=nil && [(NSString*)[logindata objectForKey:@"login"] isEqualToString:@"Y"]){
        isLogin=YES;
    }
    
    if([data isEqualToString:@"实体入驻"]){
        if(!isLogin){
            UIStoryboard*board=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ViewController*vc=[board instantiateViewControllerWithIdentifier:@"ViewController"];
            [self dismissViewControllerAnimated:YES completion:nil];
            [vc setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            [self presentViewController:vc animated:YES completion:nil];
            return;
        }
        NSLog(@"%@ 按钮被点击",data);
        UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"MyStoryboard1" bundle:nil];
        ShiTiVC*vc=[storyboard instantiateViewControllerWithIdentifier:@"ShiTiVC"];
        [self.navigationController pushViewController:vc animated:YES];
    }else if([data isEqualToString:@"虚拟入驻"]){
        if(!isLogin){
            UIStoryboard*board=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ViewController*vc=[board instantiateViewControllerWithIdentifier:@"ViewController"];
            [self dismissViewControllerAnimated:YES completion:nil];
            [vc setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            [self presentViewController:vc animated:YES completion:nil];
            return;
        }
        NSLog(@"%@ 按钮被点击",data);
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"MyStoryboard1" bundle:nil];
        XuNiVC*vc=[board instantiateViewControllerWithIdentifier:@"XuNiVC"];
        [self.navigationController pushViewController:vc animated:YES];
    }else if([data isEqualToString:@"文档下载"]){
        if(!isLogin){
            UIStoryboard*board=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ViewController*vc=[board instantiateViewControllerWithIdentifier:@"ViewController"];
            [self dismissViewControllerAnimated:YES completion:nil];
            [vc setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            [self presentViewController:vc animated:YES completion:nil];
            return;
        }
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
        if([_isadmin isEqualToString:@"Y"]){
            UIStoryboard*board=[UIStoryboard storyboardWithName:@"xitongpeizhi" bundle:nil];
            YuanGongLieBiaoVC*vc=[board instantiateViewControllerWithIdentifier:@"YuanGongLieBiaoVC"];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            UIStoryboard*board=[UIStoryboard storyboardWithName:@"yuangongguanli" bundle:nil];
            YuanGongViewController*vc=[board instantiateViewControllerWithIdentifier:@"YuanGongViewController"];
            [self.navigationController pushViewController:vc animated:YES];
        }

        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"考勤统计"]){//普通用户 管理员都会返回考勤统计
        NSLog(@"%@ 按钮被点击",data);
        
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"KaoQinGuanLi" bundle:nil];
        KaoQinGuanLiVC*vc=[board instantiateViewControllerWithIdentifier:@"KaoQinGuanLiVC"];
        vc.isadmin=_isadmin;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if([data isEqualToString:@"路演发布管理"]){//普通用户 管理员都会返回
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"huodongluyan" bundle:nil];
        HuoDongLuYanViewController* vc=[board instantiateViewControllerWithIdentifier:@"HuoDongLuYanViewController"];
        vc.isadmin=_isadmin;
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"主动性退出管理"]){
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"tuichujizhi" bundle:nil];
        ZhuDongTuiChuVC*vc=[board instantiateViewControllerWithIdentifier:@"ZhuDongTuiChuVC"];
        vc.isadmin=_isadmin;
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"被动性退出管理"]){
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"tuichujizhi" bundle:nil];
        BeiDongTuiChuVC*vc=[board instantiateViewControllerWithIdentifier:@"BeiDongTuiChuVC"];
        vc.isadmin=_isadmin;
        [self.navigationController pushViewController:vc animated:YES];
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
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"KaoQinGuanLi" bundle:nil];
        KaoQinLuoJiVC*vc=[board instantiateViewControllerWithIdentifier:@"KaoQinLuoJiVC"];
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"签到统计管理"]){
        NSLog(@"%@ 按钮被点击",data);
        
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"QianDaoTongJi" bundle:nil];
        QianDaoTongJiVC*vc=[board instantiateViewControllerWithIdentifier:@"QianDaoTongJiVC"];
        [self.navigationController pushViewController:vc animated:YES];

    }else if([data isEqualToString:@"活动报销管理"]){
        NSLog(@"%@ 按钮被点击",data);
        
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"HuoDongBaoXiao" bundle:nil];
        BaoXiaoVC*vc=[board instantiateViewControllerWithIdentifier:@"BaoXiaoVC"];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if([data isEqualToString:@"成果跟踪管理"]){
        NSLog(@"%@ 按钮被点击",data);
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"ChengGuoGenZong" bundle:nil];
        GenZongVC*vc=[board instantiateViewControllerWithIdentifier:@"GenZongVC"];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if([data isEqualToString:@"资源编辑"]){
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"yuanquziyuanguanli" bundle:nil];
        YuanQuZiYuanVC*vc=[board instantiateViewControllerWithIdentifier:@"YuanQuZiYuanVC"];
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"模块"]){
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"权限"]){
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"角色"]){
        NSLog(@"%@ 按钮被点击",data);
    }else if([data isEqualToString:@"用户"]){
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"xitongpeizhi" bundle:nil];
        YongHuVC*vc=[board instantiateViewControllerWithIdentifier:@"YongHuVC"];
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"%@ 按钮被点击",data);
    }
    
}




-(void)loadCookie
{
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookieArray = [NSArray arrayWithArray:[cookieJar cookies]];
    NSLog(@"current cookie %@",cookieArray);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData * cookiesData=[defaults objectForKey:@"chuangkexiaozhen.cookie"];
    NSArray<NSHTTPCookie *>* cookies=[NSKeyedUnarchiver unarchiveObjectWithData:cookiesData];
    if(cookiesData!=nil && cookies!=nil){
        for(NSHTTPCookie* cookie in cookies)
        {
            [cookieJar setCookie:cookie];
        }
    }
    
    [self syncUserinfo];
    
    
}


//用户登录
//参数 用户名，密码
//返回数组数据 [{"初始申请",["实体入驻","虚拟入驻","文档下载"]}]
-(void) syncUserinfo
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary* logindata=[defaults objectForKey:@"chuangkexiaozhen.login"];
    NSString* name=[logindata objectForKey:@"name"];
    NSString* pwd=[logindata objectForKey:@"pwd"];
    NSDate* logindate=[logindata objectForKey:@"logindate"];
    if(logindata==nil || name==nil || pwd==nil || logindate==nil){
        UIStoryboard*board=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ViewController*vc=[board instantiateViewControllerWithIdentifier:@"ViewController"];
        [self dismissViewControllerAnimated:YES completion:nil];
        [vc setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentViewController:vc animated:YES completion:nil];
        return;
    }
    NSDate* curdate=[NSDate date];
    NSTimeInterval secs=[curdate timeIntervalSinceDate:logindate];
    NSLog(@"已登陆 %f 秒",secs);
    if(secs<60*10){
        return;
    }

    //清除cookie缓存
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookieArray = [NSArray arrayWithArray:[cookieJar cookies]];
    for(id obj in cookieArray)
    {
        [cookieJar deleteCookie:obj];
    }
    NSString* baseurl=[[NSUserDefaults standardUserDefaults] objectForKey:@"baseurl"];

    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithObjectsAndKeys:name,@"username",pwd,@"password",@"1",@"holdme", nil];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/login"];
    
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        
        if([contenttype containsString:@"json"])
        {//返回json格式数据
            UIStoryboard*board=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ViewController*vc=[board instantiateViewControllerWithIdentifier:@"ViewController"];
            [self dismissViewControllerAnimated:YES completion:nil];
            [vc setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            [self presentViewController:vc animated:YES completion:nil];
            return;
        }else if([contenttype containsString:@"html"]){ //登陆成功
            CommNetWork* comnetwork=[[CommNetWork alloc] init];
            [comnetwork getUserinfo:name];
            //保存cookies
            NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject:[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:cookiesData forKey:@"chuangkexiaozhen.cookie"];
            [defaults synchronize];
            
            TFHpple* doc=[[TFHpple alloc]initWithHTMLData:responseObject];
            NSArray* arrays=[doc searchWithXPathQuery:@"//dl"];
            
            NSMutableArray* datas=[[NSMutableArray alloc]init];
            for (TFHppleElement *ele in arrays) {
                TFHppleElement* e1 =[ele firstChildWithTagName:@"dt"];
                NSString* title=[[e1 text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                NSArray* ary1=[ele searchWithXPathQuery:@"//a"];
                
                NSMutableArray* ary=[[NSMutableArray alloc] init];
                for (TFHppleElement *e2 in ary1) {
                    NSString* content=[e2.content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    [ary addObject:content];
                }
                if([ary count]>0){
                    NSDictionary* dic=[[NSDictionary alloc] initWithObjectsAndKeys:ary,title,nil];
                    [datas addObject:dic];
                }
                
            }
            
            if([datas count]>0){
                int index=-1;
                for (int i=0; i<[datas count]; i++) {
                    NSDictionary* tmp=[datas objectAtIndex:i];
                    if([tmp objectForKey:@"内部审核管理"] !=nil){
                        index=i;
                        break;
                    }
                }
                if(index>0){
                    [datas removeObjectAtIndex:index];
                }
                
                for (int i=0; i<[datas count]; i++) {
                    NSDictionary* tmp=[datas objectAtIndex:i];
                    NSMutableArray* ary=(NSMutableArray*)[tmp objectForKey:@"系统配置"];
                    if(ary!=nil){
                        [ary removeObject:@"模块"];
                        [ary removeObject:@"权限"];
                        [ary removeObject:@"角色"];
                        [ary removeObject:@"数据字典"];
                    }
                }
                
            }
            
            [defaults setObject:datas forKey:@"chuangkexiaozhen.zhujiemian"];
            NSMutableDictionary* login=[NSMutableDictionary dictionary];
            [login setObject:name forKey:@"name"];
            [login setObject:pwd forKey:@"pwd"];
            [login setObject:@"Y" forKey:@"login"];
            [login setObject:[NSDate date] forKey:@"logindate"];
            [defaults setObject:login forKey:@"chuangkexiaozhen.login"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}




@end
