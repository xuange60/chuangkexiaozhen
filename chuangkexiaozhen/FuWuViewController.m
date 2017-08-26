//
//  FuWuViewController.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/2.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "FuWuViewController.h"

@interface FuWuViewController ()

@end

@implementation FuWuViewController

- (void)viewDidLoad {
    self.datas=[NSArray array];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    [super viewDidLoad];
    
    //modify
    self.navigationItem.title=@"园区服务申请";

    
    self.yuanqufuwushenqing=[[YuanQuFuWuShenQing alloc] init];
    self.yuanqufuwushenqing.delegate=self;
    
    self.yuanqufuwuguanli=[[YuanQuFuWuGuanLi alloc] init];
    _yuanqufuwuguanli.delegate=self;
    [self query];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(query) name:@"FuWuViewController" object:nil];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//点击右上角+号时，添加申请时重写
-(void)add
{
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"YuanQuFuWu" bundle:nil];
    FuWuShenQingAddViewController* add=[storyboard instantiateViewControllerWithIdentifier:@"FuWuShenQingAddViewController"];
    [self.navigationController pushViewController:add animated:YES];
    NSLog(@"%@",@"add");
}

//modify 查询数据，显示在tableview上时使用
-(void)query
{
    if([_isadmin isEqualToString:@"Y"])
    {
        [_yuanqufuwuguanli YuanQuFuWuQuerywithAdmin];
    }else{
        [self.yuanqufuwushenqing YuanQuFuWuQuery];
    }

}


- (void)loadNetworkFinished:(id)data
{
    self.datas=(NSArray*)data;
    if(![_isadmin isEqualToString:@"Y"])
    {
        UIImage *rightButtonIcon = [[UIImage imageNamed:@"add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithImage:rightButtonIcon
                                                                         style:UIBarButtonItemStylePlain target:self action:@selector(add)];
        self.navigationItem.rightBarButtonItem=rightBtnItem;
    }
    
    [self.tableview reloadData];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger num=[self.datas count];
    return num;
}

//modify 加载单元格数据时使用 注意设置单元格的Identifier
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* str1=@"FuWuShenQingCell";
    
    FuWuShenQingCell* cell=[tableView dequeueReusableCellWithIdentifier:str1];
    if(!cell){
        cell=[[FuWuShenQingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str1];
    }
    NSDictionary* dic=[self.datas objectAtIndex:indexPath.row];
    cell.fuwutype.text=[dic objectNotNullForKey:@"serveCategory"];
    cell.shenqinggongsi.text=[dic objectNotNullForKey:@"tenantTitle"];
    cell.fuwucontent.text=[dic objectNotNullForKey:@"content"];
    NSString* status=[dic objectNotNullForKey:@"status"];
    cell.fuwustatus.text=status;
    if([_isadmin isEqualToString:@"Y"] && [status isEqualToString:@"未处理"])
    {
        [cell.fuwusucc setHidden:NO];
    }else{
        [cell.fuwusucc setHidden:YES];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}




- (IBAction)ShenSuDetail:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableview];
    
    NSIndexPath *indexPath=[_tableview indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_datas objectAtIndex:indexPath.row];
    
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"YuanQuFuWu" bundle:nil];
    FuWuShenQingDetailViewController* add=[storyboard instantiateViewControllerWithIdentifier:@"FuWuShenQingDetailViewController"];
    add.data=dic;
    
    [self.navigationController pushViewController:add animated:YES];
    NSLog(@"%@",@"add");
    
}


- (IBAction)FuWuDelete:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableview];
    
    NSIndexPath *indexPath=[_tableview indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_datas objectAtIndex:indexPath.row];
    
    NSString* ids=(NSString*)[dic objectNotNullForKey:@"id"];
    
    [self.yuanqufuwushenqing YuanQuFuWuDelete:ids];
    
}



-(void)deleteData:(id)data
{
    [self query];
}



- (IBAction)fileList:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableview];
    
    NSIndexPath *indexPath=[_tableview indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_datas objectAtIndex:indexPath.row];
    
    NSString* ids=(NSString*)[dic objectNotNullForKey:@"id"];
    
    FilelistViewController* filelist=[[FilelistViewController alloc] initView:ids withType:@"35"];
    [self.navigationController pushViewController:filelist animated:YES];
    
}



- (IBAction)ShenQingSucc:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableview];
    
    NSIndexPath *indexPath=[_tableview indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_datas objectAtIndex:indexPath.row];
    
    NSString* ids=(NSString*)[dic objectNotNullForKey:@"id"];
    
    [_yuanqufuwuguanli YuanQuFuWuSucc:ids];
}


-(void) afternetwork1:(id)data
{
    if(1==[(NSNumber*)data intValue]){
        UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:@"提示" message:@"服务申请已受理" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*action2=[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [alertCon addAction:action2];
        [self presentViewController:alertCon animated:YES completion:nil];
    }
    [self query];
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
