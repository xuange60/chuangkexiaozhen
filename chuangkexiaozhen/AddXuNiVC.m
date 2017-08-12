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
    
    _XuNi=[[XuNiRuZhuGuanLi alloc]init];
    _XuNi.delegate=self;
    
//    _InfoAry=[NSArray arrayWithObjects:
//              [dic objectNotNullForKey:@"contact"],
//              [dic objectNotNullForKey:@"contactType"],
//              [dic objectNotNullForKey:@"companyName"],
    
//              [dic objectNotNullForKey:@"coopCategories"],
//              [dic objectNotNullForKey:@"desc"],
//              nil];

    
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
    [dic setObject:_F1.text forKey:@"contact"];
    [dic setObject:_F2.text forKey:@"contacttype"];
    [dic setObject:_F3.text forKey:@"branchname"];
    [dic setObject :_duoxuan.currentTitle    forKey:@"coopcategories"];
    [dic setObject:_textView.text forKey:@"desc"];
    [dic setNotNullObject:_strId forKey:@"id"];
    
    [_XuNi XuNiRuZhuGuanLiModify:dic];
}

-(void)afternetwork2:(id)data
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"XIUGAIXUNISUCCESS" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}



@end
