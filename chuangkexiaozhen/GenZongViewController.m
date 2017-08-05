//
//  TuiChuViewController.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/5.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "GenZongViewController.h"

@interface GenZongViewController ()

@end

@implementation GenZongViewController

- (void)viewDidLoad {
    self.datas=[NSArray array];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    [super viewDidLoad];
    
    //modify
    self.navigationItem.title=@"跟踪服务";
    UIImage *rightButtonIcon = [[UIImage imageNamed:@"add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithImage:rightButtonIcon
                                                                     style:UIBarButtonItemStylePlain target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem=rightBtnItem;
    
    self.genzongfuwu=[[GenZongFuWu alloc] init];
    self.genzongfuwu.delegate=self;
    [self query];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(query) name:@"GenZongViewController" object:nil];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//modify 查询数据，显示在tableview上时使用
-(void)query
{
    [self.genzongfuwu GenZongFuWuQuery];
}


- (void)loadNetworkFinished:(id)data
{
    self.datas=(NSArray*)data;
    [self.tableview reloadData];
}




-(void)add
{
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"tuichu" bundle:nil];
    GenZongFuWuAddViewController* add=[storyboard instantiateViewControllerWithIdentifier:@"GenZongFuWuAddViewController"];
    [self.navigationController pushViewController:add animated:YES];
    NSLog(@"%@",@"add");
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger num=[self.datas count];
    return num;
}

//modify 加载单元格数据时使用 注意设置单元格的Identifier
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* str1=@"GenZongCell";
    
    GenZongCell* cell=[tableView dequeueReusableCellWithIdentifier:str1];
    if(!cell){
        cell=[[GenZongCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str1];
    }
    NSDictionary* dic=[self.datas objectAtIndex:indexPath.row];

    cell.title.text=[dic objectForKey:@"title"];
    cell.content.text=[dic objectForKey:@"content"];

    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    return cell;
}


- (IBAction)delete:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableview];
    
    NSIndexPath *indexPath=[_tableview indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_datas objectAtIndex:indexPath.row];
    
    NSString* ids=(NSString*)[dic objectForKey:@"id"];
    
    [self.genzongfuwu GenZongFuWuDelete:ids];
}

-(void)deleteData:(id)data
{
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
