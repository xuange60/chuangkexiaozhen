//
//  KaiTongZhuXianVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/12.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "KaiTongZhuXianVC.h"

@interface KaiTongZhuXianVC ()

@end

@implementation KaiTongZhuXianVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title=@"开通主线管理";
    _zhuxian=[[KaiTongZhuXianGuanLi alloc]init];
    _zhuxian.delegate=self;
    
    [_zhuxian KaiTongZhuXianQuery];
    
}

-(void)loadNetworkFinished:(id)data
{
    _array=[NSMutableArray arrayWithArray:(NSArray*)data];
    [_tableView reloadData];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*str=@"KaiTongZhuXianCell";
    KaiTongZhuXianCell*cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell=[[KaiTongZhuXianCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    /*
     2.11.1 开通主线管理 查询
     http://116.228.176.34:9002/chuangke-serve/mainline/search?start=0&length=10000
     [{"id":"597dc20280ab5e6790d52d7f","reportedBodys"
     :20,"leaseArea":45,"floor":3,"bearing":"无特殊需求","water":"无特殊需求","electricity":"无特殊需求","communications"
     :"开通电信","parkingLot":"3","repastBodies":3,"businessNeeds":"提供注册帮助","legalNeeds":"提供法务帮助","printNeeds"
     :"需要打印","applyNetAlone":"否","applyNetShare":"是","reformDecoration":"否","companyStatus":"创业团队，工商未注册","companyName"
     :"ceshigongsi","uniNumber":"","tenantInit":"uninit"},{"id":"597d812f80ab5e6790d52d4e","reportedBodys"
     :4,"leaseArea":20,"floor":1,"bearing":"无特殊需求","water":"无特殊需求","electricity":"无特殊需求","communications"
     :"开通电信","parkingLot":"4","repastBodies":4,"businessNeeds":"提供注册帮助","legalNeeds":"提供法务帮助","printNeeds"
     :"需要","applyNetAlone":"否","applyNetShare":"是","reformDecoration":"否","companyStatus":"创业团队，工商未注册","companyName"
     :"测试公司zhangxuan3","uniNumber":"","tenantInit":"inited"}]
     */
    
    NSDictionary*dic=[_array objectAtIndex:indexPath.row];
    cell.companyName.text=[dic objectNotNullForKey:@"companyName"];
    cell.personNum.text=[dic objectNotNullForKey:@"reportedBodys"];
    cell.mianJi.text=[dic objectNotNullForKey:@"leaseArea"];
    cell.louCeng.text=[dic objectNotNullForKey:@"floor"];
    cell.chengZhong.text=[dic objectNotNullForKey:@"bearing"];
    cell.yongShui.text=[dic objectNotNullForKey:@"water"];
    cell.yongDian.text=[dic objectNotNullForKey:@"electricity"];
    cell.tongXin.text=[dic objectNotNullForKey:@"communications"];
    
    cell.cheWei.text=[dic objectNotNullForKey:@"parkingLot"];
    cell.jiuCan.text=[dic objectNotNullForKey:@"repastBodies"];
    cell.gongShang.text=[dic objectNotNullForKey:@"businessNeeds"];
    cell.faWu.text=[dic objectNotNullForKey:@"legalNeeds"];
    cell.wenYin.text=[dic objectNotNullForKey:@"printNeeds"];
    cell.singleNet.text=[dic objectNotNullForKey:@"applyNetAlone"];
    cell.shareNet.text=[dic objectNotNullForKey:@"applyNetShare"];
    cell.gaiZao.text=[dic objectNotNullForKey:@"reformDecoration"];
    cell.qingKuang.text=[dic objectNotNullForKey:@"companyStatus"];
    cell.tonYiHao.text=[dic objectNotNullForKey:@"uniNumber"];
    NSString* inited=[dic objectNotNullForKey:@"tenantInit"];
    if([inited isEqualToString:@"uninit"]){
        cell.editBtn.hidden=NO;
    }else{
        cell.editBtn.hidden=YES;
    }
    
   [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (IBAction)editBtnClick:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches=[event allTouches];
    UITouch*touch=[touches anyObject];
    CGPoint point=[touch locationInView:_tableView];
    NSIndexPath*path=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_array objectAtIndex:path.row];
    
    NSString*strID=[dic objectNotNullForKey:@"id"];
    
    
    NSArray*ary=[NSArray arrayWithObjects:
                 [dic objectNotNullForKey:@"numberOfOffice"],
                 [dic objectNotNullForKey:@"ppppppppp"],//没有正确的，暂代替
                 [dic objectNotNullForKey:@"numberOftc"],
                 [dic objectNotNullForKey:@"tcCodes"],
                 [dic objectNotNullForKey:@"numberOfoe"],
                 [dic objectNotNullForKey:@"oeCodes"],
                 [dic objectNotNullForKey:@"printAccount"],
                 [dic objectNotNullForKey:@"printPassword"],
                 [dic objectNotNullForKey:@"numberOfegc"],
                 [dic objectNotNullForKey:@"egcCodes"],
                 [dic objectNotNullForKey:@"numberOfpl"],
                 [dic objectNotNullForKey:@"plCodes"],
                 [dic objectNotNullForKey:@"name"],
                 [dic objectNotNullForKey:@"concatType"],
                 [dic objectNotNullForKey:@"companyName"],
                 nil];
    
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"ZiYuanPeiZhi" bundle:nil];
    EditZiYuanPeiZhiVC*vc=[board instantiateViewControllerWithIdentifier:@"EditZiYuanPeiZhiVC"];
    
    [vc setStr:strID infoAry:ary];
    vc.isInit=@"Y";
    [self.navigationController pushViewController:vc animated:YES];

    
}

- (IBAction)deleteBtnClick:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches=[event allTouches];
    UITouch*touch=[touches anyObject];
    CGPoint point=[touch locationInView:_tableView];
    NSIndexPath*path=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_array objectAtIndex:path.row];
    
    NSString*strID=[dic objectNotNullForKey:@"id"];
    UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:nil message:@"请确认是否删除？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*action1=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction*action2=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [_zhuxian KaiTongZhuXianDelete:strID];
    }];
    
    [alertCon addAction:action1];
    [alertCon addAction:action2];
    
    [self presentViewController:alertCon animated:YES completion:nil];
    
}

-(void)afternetwork1:(id)data
{
    [self tiShiKuangDisplay:deleteStr viewController:self];
    [_zhuxian KaiTongZhuXianQuery];
}






@end
