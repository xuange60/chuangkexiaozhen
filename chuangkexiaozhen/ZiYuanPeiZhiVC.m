//
//  ZiYuanPeiZhiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/12.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "ZiYuanPeiZhiVC.h"

@interface ZiYuanPeiZhiVC ()

@end

@implementation ZiYuanPeiZhiVC

- (void)viewDidLoad {
    [super viewDidLoad];
   self.navigationItem.title=@"资源配置管理";

    _ziyuan=[[ZiYuanPeiZhiGuanLi alloc]init];
    _ziyuan.delegate=self;
    
    [_ziyuan ZiYuanGuanLiQuery];
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

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*str=@"ZiYuanPeiZhiCell";
    ZiYuanPeiZhiCell*cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell=[[ZiYuanPeiZhiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    /*
     2.13.2 资源管理查询
     http://116.228.176.34:9002/chuangke-serve/resourceallocation/search?length=1000&start=0
     [{"id":"58e5fd9f19eb64c4e63875f6","officeArea"
     :null,"numberOfOffice":2,"numberOftc":2,"tcCodes":"KCXZ-BGZY0001,KCXZ=BGZY0002","numberOfoe":2,"oeCodes"
     :"KCXZ-BGSB0001,KCXZ-BGSB0002","printAccount":"wy01","printPassword":"wy01","numberOfegc":2,"egcCodes"
     :"KCXZ-CYK0039,KCXZ-CYK0040","numberOfpl":2,"plCodes":"KCXZ-CW0001,KCXZ-CW0002","companyName":"上海匠睿智
     能科技有限公司","name":"王俊","concatType":"15901647707","desc":""},{"id":"58f5892e19eb8cbffbb87aa5","officeArea"
     :null,"numberOfOffice":6,"numberOftc":6,"tcCodes":"","numberOfoe":0,"oeCodes":"","printAccount":"qjny01"
     ,"printPassword":"111111","numberOfegc":4,"egcCodes":"KCXZ-CYK0021,KCXZ-CYK0022,KCXZ-CYK0023,KCXZ-CYK0024"
     ,"numberOfpl":2,"plCodes":"KCXZ-CW0003,KCXZ-CW0004","companyName":"清基(上海）农业发展有限公司","name":"陈强","concatType"
     :"","desc":""}]
     */
    NSDictionary*dic=[_array objectAtIndex:indexPath.row];
    
    cell.companyName.text=[dic objectNotNullForKey:@"companyName"];
    cell.workArea.text=[dic objectNotNullForKey:@"officeArea"];
    cell.zuoweiNum.text=[dic objectNotNullForKey:@"numberOfOffice"];
    cell.zhuoyiNum.text=[dic objectNotNullForKey:@"numberOftc"];
    cell.zhuoYiCode.text=[dic objectNotNullForKey:@"tcCodes"];
    cell.shebeiNum.text=[dic objectNotNullForKey:@"numberOfoe"];
    cell.sheBeiCode.text=[dic objectNotNullForKey:@"oeCodes"];
    cell.wenyinAccount.text=[dic objectNotNullForKey:@"printAccount"];
    cell.wenyinPsw.text=[dic objectNotNullForKey:@"printPassword"];
    cell.menjinkaNum.text=[dic objectNotNullForKey:@"numberOfegc"];
    cell.menjinkaCode.text=[dic objectNotNullForKey:@"egcCodes"];
    cell.carstopNum.text=[dic objectNotNullForKey:@"numberOfpl"];
    cell.carstopCode.text=[dic objectNotNullForKey:@"plCodes"];
    cell.witerName.text=[dic objectNotNullForKey:@"name"];
    cell.witerPhone.text=[dic objectNotNullForKey:@"concatType"];
    
    return cell;
}

- (IBAction)EditClicked:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches=[event allTouches];
    UITouch*touch=[touches anyObject];
    CGPoint point=[touch locationInView:_tableView];
    NSIndexPath*path=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_array objectAtIndex:path.row];
    
    NSString*strID=[dic objectNotNullForKey:@"id"];
    
//    cell.companyName.text=[dic objectNotNullForKey:@"companyName"];
//    cell.workArea.text=[dic objectNotNullForKey:@"officeArea"];
//    cell.zuoweiNum.text=[dic objectNotNullForKey:@"numberOfOffice"];
//    cell.zhuoyiNum.text=[dic objectNotNullForKey:@"numberOftc"];
//    cell.zhuoYiCode.text=[dic objectNotNullForKey:@"tcCodes"];
//    cell.shebeiNum.text=[dic objectNotNullForKey:@"numberOfoe"];
//    cell.sheBeiCode.text=[dic objectNotNullForKey:@"oeCodes"];
//    cell.wenyinAccount.text=[dic objectNotNullForKey:@"printAccount"];
//    cell.wenyinPsw.text=[dic objectNotNullForKey:@"printPassword"];
//    cell.menjinkaNum.text=[dic objectNotNullForKey:@"numberOfegc"];
//    cell.menjinkaCode.text=[dic objectNotNullForKey:@"egcCodes"];
//    cell.carstopNum.text=[dic objectNotNullForKey:@"numberOfpl"];
//    cell.carstopCode.text=[dic objectNotNullForKey:@"plCodes"];
//    cell.witerName.text=[dic objectNotNullForKey:@"name"];
//    cell.witerPhone.text=[dic objectNotNullForKey:@"concatType"];
//
    
    NSArray*ary=[NSArray arrayWithObjects:
                 [dic objectNotNullForKey:@"numberOfOffice"],
                 [dic objectNotNullForKey:@"ppppppppppppppppppppppppppppppppp"],
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
                 nil];
    
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"ZiYuanPeiZhi" bundle:nil];
    EditZiYuanPeiZhiVC*vc=[board instantiateViewControllerWithIdentifier:@"EditZiYuanPeiZhiVC"];
    
    [vc setStr:strID infoAry:ary];
    [self.navigationController pushViewController:vc animated:YES];

}



- (IBAction)DeleteClicked:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches=[event allTouches];
    UITouch*touch=[touches anyObject];
    CGPoint point=[touch locationInView:_tableView];
    NSIndexPath*path=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_array objectAtIndex:path.row];
    
    NSString*strID=[dic objectNotNullForKey:@"id"];
    
    [_ziyuan ZiYuanGuanLiDelete:strID];
    
}
-(void)afternetwork2:(id)data
{
    [_ziyuan ZiYuanGuanLiQuery];
}















@end
