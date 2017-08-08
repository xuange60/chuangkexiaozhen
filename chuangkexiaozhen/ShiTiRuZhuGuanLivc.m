//
//  ShiTiRuZhuGuanLivc.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/8.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "ShiTiRuZhuGuanLivc.h"

@interface ShiTiRuZhuGuanLivc ()

@end

@implementation ShiTiRuZhuGuanLivc

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*str=@"";
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    return cell;
}








- (IBAction)EditClick:(id)sender forEvent:(UIEvent *)event {
}


- (IBAction)AddClick:(id)sender forEvent:(UIEvent *)event {
}


- (IBAction)SuccClick:(id)sender forEvent:(UIEvent *)event {
}

- (IBAction)ErrorClick:(id)sender forEvent:(UIEvent *)event {
}

- (IBAction)DeleteClick:(id)sender forEvent:(UIEvent *)event {
}

- (IBAction)DownloadClick:(id)sender forEvent:(UIEvent *)event {
}
















@end
