//
//  WengDangVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/27.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "WenDangVC.h"

@interface WenDangVC ()

@end

@implementation WenDangVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     self.navigationItem.title=@"文档下载";
    
    
    
    
    
    
    
    
}
#pragma mark-
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*ss=@"xiazaicell";
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:ss];
    
    if (!cell) {
        cell=(UITableViewCell*)[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ss];
    }
    
    return cell;
}



- (IBAction)DeleteBtnClick:(id)sender {
    UIButton*btn=(UIButton*)sender;
    
}


- (IBAction)DownLoadBtnClick:(id)sender {
     UIButton*btn=(UIButton*)sender;
    
    
    
    
}























@end
