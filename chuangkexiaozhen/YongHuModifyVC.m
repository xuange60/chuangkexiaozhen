//
//  YongHuModifyVC.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/21.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "YongHuModifyVC.h"

@interface YongHuModifyVC ()

@end

@implementation YongHuModifyVC




- (void)viewDidLoad {
    _yonghuxinxi=[[YongHuXinXi alloc] init];
    _yonghuxinxi.delegate=self;
    self.navigationItem.title=@"修改用户信息";
    [super viewDidLoad];
    _comanyname.text=[_datas objectNotNullForKey:@"companyName"];
    _department.text=[_datas objectNotNullForKey:@"department"];
    _email.text=[_datas objectNotNullForKey:@"email"];
    _mobile.text=[_datas objectNotNullForKey:@"phone"];
    _rank.text=[_datas objectNotNullForKey:@"rank"];
    _name.text=[_datas objectNotNullForKey:@"name"];
    _username.text=[_datas objectNotNullForKey:@"loginName"];
    [self query];
    // Do any additional setup after loading the view.
}

-(void)query
{
    NSString* ids=[_datas objectNotNullForKey:@"id"];
    [_yonghuxinxi YongHuDetailQuery:ids];
}

-(void)afternetwork5:(id)data
{
    _roles=[(NSDictionary*)data objectForKey:@"roleIds"];
    _selectedroles=[(NSDictionary*)data objectForKey:@"selectedroleIds"];
    _companytypes=[(NSDictionary*)data objectForKey:@"companytype"];
    _selectedcompanytype=[(NSDictionary*)data objectForKey:@"selectedcompanytype"];
    NSArray* ary1=[_selectedcompanytype allKeys];
    if([ary1 count]>0){
        NSMutableString* str=[NSMutableString string];
        for (NSString* tmp in ary1) {
            [str appendString:tmp];
            [str appendString:@" "];
        }
        [_companytype setTitle:str forState:UIControlStateNormal];
    }
    
    NSArray* ary2=[_selectedroles allKeys];
    if([ary2 count]>0){
        NSMutableString* str=[NSMutableString string];
        int i=0;
        for (NSString* tmp in ary2) {
            i++;
            [str appendString:tmp];
            if(i!=[ary2 count]){
                [str appendString:@","];
            }
        }
        [_roleIds setTitle:str forState:UIControlStateNormal];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)tyleclick:(id)sender {
    DuoXuanVC* add=[[DuoXuanVC alloc] init];
    NSArray* keys=[_companytypes allKeys];
    [add setArray:keys btn:sender];
    [add setNavTitle:@"选择企业类型"];
    [add setDanXuan];
    
    [add setSelectedData:[NSMutableArray arrayWithArray:[_selectedcompanytype allKeys]]];
    
    [self.navigationController pushViewController:add animated:YES];
    
    
}



- (IBAction)roleclick:(id)sender {
    DuoXuanVC* add=[[DuoXuanVC alloc] init];
    NSArray* keys=[_roles allKeys];
    [add setArray:keys btn:sender];
    [add setNavTitle:@"选择权限"];
    
    [add setSelectedData:[NSMutableArray arrayWithArray:[_selectedroles allKeys]]];
    
    [self.navigationController pushViewController:add animated:YES];
    
    
}


/*
 2.20.4 查询用户
 http://116.228.176.34:9002/chuangke-serve/user/edit?id=598495bc80ab5e6790d54493
 
 2.20.5 修改用户
 http://116.228.176.34:9002/chuangke-serve/user/update

 mobile	17566562783
 name	ceshigongsi
 rank	21
 remark	1112
 roleIds	5875a66fee19799d1cc83827
 roleIds	589d240277c87dfcad569547
 username	ceshi12222
 */
- (IBAction)submit:(id)sender {
    NSMutableDictionary* param=[NSMutableDictionary dictionary];
    [param setNotNullStrObject:_comanyname.text forKey:@"comanyname"];
    [param setNotNullStrObject:[_companytype currentTitle] forKey:@"companytype"];
    [param setNotNullStrObject:_department.text forKey:@"department"];
    [param setNotNullStrObject:_email.text forKey:@"email"];
    [param setNotNullStrObject:[_datas objectNotNullForKey:@"id"] forKey:@"id"];
    [param setNotNullStrObject:_mobile.text forKey:@"mobile"];
    [param setNotNullStrObject:_name.text forKey:@"name"];
    [param setNotNullStrObject:_rank.text forKey:@"rank"];
    [param setNotNullStrObject:@"" forKey:@"remark"];
    [param setNotNullStrObject:_username.text forKey:@"username"];
    NSString* str=[_roleIds currentTitle];
    NSArray* ary1=[str componentsSeparatedByString:@","];
    NSMutableArray* ary2=[NSMutableArray array];
    if(ary1==nil){
        ary1=[NSArray array];
    }
    for (NSString* tmp in ary1) {
        [ary2 addObject:[_roles objectNotNullForKey:tmp]];
    }
    
    [param setObject:ary2 forKey:@"roleIds"];
    
    [_yonghuxinxi yongHuModify:param];
    
}


-(void) afternetwork4:(id)data
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"YongHuVC" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
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
