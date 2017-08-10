//
//  EditShiTiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/9.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "EditShiTiVC.h"

@interface EditShiTiVC ()

@end

@implementation EditShiTiVC

-(void)setShuJu:(NSString*)strId
{
    _strID=[NSString stringWithString:strId];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _shiti=[[ShiTiRuZhuGuanLi alloc]init];
    _shiti.delegate=self;

    [_shiti ShiTiRuZhuQuery:_strID];
    
}





- (IBAction)btn1Click:(id)sender {
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"电子信息",@"生物医药",@"新材料",@"互联网和移动互联网",@"先进制造",@"新能源及节能环保",@"科技服务业",@"农业科技",@"艺术文化",@"电子商务",@"创投孵化", nil];
    [vc setDatas:array withBtn:sender];
    vc.navigationItem.title=@"所属行业";
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)btn2Click:(id)sender {
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"初创团队",@"小微企业",@"加速企业",nil];
    [vc setDatas:array withBtn:sender];
    vc.navigationItem.title=@"团队描述";
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)tijiaoClick:(id)sender {
    
    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
    
    
    
    
    
    [_shiti ShiTiRuZhuModify:dic];
}





@end
