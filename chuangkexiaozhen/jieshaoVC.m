//
//  jieshaoVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/18.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "jieshaoVC.h"
#import "CustomCell.h"
@interface jieshaoVC ()

@end

@implementation jieshaoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView* footer=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 130)];
    footer.backgroundColor=self.view.backgroundColor;
    [self.tableView setTableFooterView:footer];
    NSArray*ary1=[NSArray arrayWithObjects:@"event-1.png",@"办公载体服务 ",@"孵化工位,公司注册,并且提供拎包入住的孵化场地，配备办公家具、会议室、咖啡、免费wifi等", nil];
    NSArray*ary2=[NSArray arrayWithObjects:@"event-2.png",@"增值服务",@"核心团队,政策服务,政策代理申报,知识产权服务,人力资源服务,法律服务,财务服务,云平台服务,仪器设备共享服务。", nil];
    NSArray*ary3=[NSArray arrayWithObjects:@"event-3.png",@"创业培训",@"核心团队,政策服务,政策代理申报,知识产权服务,人力资源服务,法律服务,财务服务,云平台服务,仪器设备共享服务。", nil];
    NSArray*ary4=[NSArray arrayWithObjects:@"event-4.png",@"投融资服务",@"投融资对接,投资服务,风险补偿金。通过项目路演、天使轮、pre-A轮、A轮融资，融资规模100-2000万元.设立不少于1亿元的“科创小镇”创新创业引导资金，助力企业发展",nil];
    
    _array=[NSMutableArray arrayWithObjects:ary1,ary2,ary3,ary4, nil];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* ss=@"cell";
    static BOOL isRegister=NO;
    if(!isRegister){
        UINib* nib=[UINib nibWithNibName:@"CustomCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:ss];
        isRegister=YES;
    }
    
    
    
    CustomCell*cell=[tableView dequeueReusableCellWithIdentifier:ss];
    [cell setShuJu:[_array objectAtIndex:indexPath.row]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; //设置单元格被点击时，无特效
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 145;
}

@end
