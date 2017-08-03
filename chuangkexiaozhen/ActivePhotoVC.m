//
//  ActivePhotoVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/1.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "ActivePhotoVC.h"
#import "ActivePhotoCell.h"
#import "BussinessApi.h"
#import "xiazaiPhotoVC.h"
@interface ActivePhotoVC ()

@end

@implementation ActivePhotoVC


-(void)ReceiveShuJuPhoto:(NSString*)str
{
    _entryID=[NSString stringWithString:str];
    _Marray=[NSMutableArray array];
    _num=0;
    
    _api=[[BussinessApi alloc]init];
    _api.delegate=self;
    [_api huoDongQueryFileNew:_entryID];
    
}

//  第二页查询的代理
-(void)queryAllFileUp:(id)data
{
    _Marray=(NSMutableArray*)data;
    
    [_tableView reloadData];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"文档下载";
}
#pragma mark-
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_Marray.count==0)
    {
        return 0;
    }
    return _Marray.count;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString*ss=@"ActivePhotoCell";
    ActivePhotoCell*cell=[tableView dequeueReusableCellWithIdentifier:ss];
    
    if (!cell) {
        cell=(ActivePhotoCell*)[[ActivePhotoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ss];
    }
    
    
    NSDictionary*dic=[_Marray objectAtIndex:indexPath.row];
    NSString*str1=[dic objectForKey:@"name"];
    NSString*str2=[dic objectForKey:@"date"];
    
    cell.Name.text=str1;
    cell.Date.text=str2;
    
    return cell;
}

- (IBAction)activeDeleteClick:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches=[event allTouches];
    UITouch*touch=[touches anyObject];
    CGPoint point=[touch locationInView:_tableView];
    NSIndexPath*indexPath=[_tableView indexPathForRowAtPoint:point];
    _num=indexPath.row;
    
    NSDictionary*dic=[_Marray objectAtIndex:_num];
    NSString*strID=[dic objectForKey:@"id"];
    
    
    [_api huoDongDeleteNew:strID withEntityIdNew:_entryID];
}

//第二页删除的代理
#pragma mark-BussinessApiDelegate

-(void)DeleteDoubleParam:(id)data
{
    [_api huoDongQueryFileNew:_entryID];
    
}


- (IBAction)activeDownloadClick:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches=[event allTouches];
    UITouch*touch=[touches anyObject];
    CGPoint point=[touch locationInView:_tableView];
    NSIndexPath*indexPath=[_tableView indexPathForRowAtPoint:point];
    _num=indexPath.row;
    
    NSDictionary*dic=[_Marray objectAtIndex:_num];
    NSString*strID=[dic objectForKey:@"id"];
    
    
    [_api chushishenqingFileDownload:strID];

}

//第二页下载的代理
-(void)XianShiPhoto:(id)data
{
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"MyStoryboard1" bundle:nil];
    xiazaiPhotoVC*vc= [board instantiateViewControllerWithIdentifier:@"xiazaiPhotoVC"];
    [vc setData:(NSData*)data];
    [self.navigationController pushViewController:vc animated:YES];
}

@end