//
//  DuoXuanVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/12.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"

@interface DuoXuanVC : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray*array;
@property(nonatomic,strong)UIButton*btn;
@property(nonatomic,strong)NSMutableString*Mstr;

@property (strong, nonatomic) IBOutlet UITableView *tableView;



-(void)setArray:(NSArray*)array  btn:(UIButton*)btn;


-(void)setNavTitle:(NSString*)titlestr;
-(void)setDanXuan;//Y指单选 否则为多选
-(void)setSelectedData:(NSMutableArray*)datas;//以数组的形式传如默认选中数据

@property (nonatomic,strong) NSString* titlestr;
@property (nonatomic,strong) NSString* isDanXuan;

@property (nonatomic,strong) NSMutableArray* currentSelected; //当前已经被选中的



@end
