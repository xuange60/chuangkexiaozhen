//
//  AddXuNiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/12.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "AddXuNiVC.h"
#import "ComboViewController.h"
#import "ComBoRowsViewController.h"
@interface AddXuNiVC ()

@end

@implementation AddXuNiVC

-(void) setShuJu:(NSString*)strId   infoAry:(NSArray*)infoAry
{
    _strId=[NSString stringWithString:strId];
    _infoAry=[NSArray arrayWithArray:infoAry];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"虚拟入驻修改";
    
    self.rightbutton=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(BtnClicked:)];
    self.rightbutton.tintColor=[UIColor whiteColor];
    self.rightbutton.enabled=NO;
    self.navigationItem.rightBarButtonItem=self.rightbutton;
    
    [self receiveCurrentViewController:self];
    
    _XuNi=[[XuNiRuZhuGuanLi alloc]init];
    _XuNi.delegate=self;
    
    _F1.text=[_infoAry objectAtIndex:0];
    _F2.text=[_infoAry objectAtIndex:1];
    _F3.text=[_infoAry objectAtIndex:2];
    NSString*str=[_infoAry objectAtIndex:3];
    _textView.text=[_infoAry objectAtIndex:4];
    
    [_duoxuan setTitle:str forState:UIControlStateNormal];
    
}


- (IBAction)duoxuanBtnClick:(id)sender {
    
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComBoRowsViewController* vc=[storyboard instantiateViewControllerWithIdentifier:@"ComBoRowsViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"展示推介机会",@"投融资需求",@"信息技术需求",@"制造加工及场地需求",@"农艺新品种需求",@"交流合作机会",@"咨询管理",@"其他", nil];
    [vc setDatas:array withBtn:sender];
    [vc setNavigationItemTitle:@"寻求类别"];
    //[self presentViewController:vc animated:YES completion:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)BtnClicked:(id)sender {
    /*
     2.10.3 虚拟入驻申请修改 --
     参数 post id:id,contact:contact,contacttype:contactType,branchname:branchName,coopcategories
     :coopcategoriesStr,desc:desc}
     http://116.228.176.34:9002/chuangke-serve/apply/update/resapply
     */

    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
    [dic setNotNullStrObject:_F1.text forKey:@"contact"];
    [dic setNotNullStrObject:_F2.text forKey:@"contacttype"];
    [dic setNotNullStrObject:_F3.text forKey:@"branchname"];
    [dic setNotNullStrObject :_duoxuan.currentTitle    forKey:@"coopcategories"];
    [dic setNotNullStrObject:_textView.text forKey:@"desc"];
    [dic setNotNullStrObject:_strId forKey:@"id"];
    
    [_XuNi XuNiRuZhuGuanLiModify:dic];
}

-(void)afternetwork2:(id)data
{
    [self tiShiKuangDisplay:submitStr viewController:self];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"XIUGAIXUNISUCCESS" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}



@end
