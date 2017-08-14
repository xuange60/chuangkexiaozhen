//
//  DuoXuanVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/12.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "DuoXuanVC.h"

@interface DuoXuanVC ()

@end

@implementation DuoXuanVC
-(void)setArray:(NSArray*)array  btn:(UIButton*)btn
{
    _array=[NSMutableArray arrayWithArray:array];
    _btn=btn;

}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    if(_titlestr==nil || _titlestr.length==0){
        self.navigationItem.title=@"选择资产编号";
    }else{
        self.navigationItem.title=_titlestr;
    }

    self.view.backgroundColor=[UIColor whiteColor];
    
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
    if(_Mstr==nil || [_Mstr length]==0){
        _Mstr=[NSMutableString string];
    }
    
    if(_currentSelected==nil || [_currentSelected count]==0)
    {
        _currentSelected=[NSMutableArray array];
    }

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*str=@"cell";
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.accessoryType= UITableViewCellAccessoryNone;
    NSString* text=[_array objectAtIndex:indexPath.row];
    cell.textLabel.text=text;
    
    if([self isSelected:text]){//初始化数据可能被选中
        if([_isDanXuan isEqualToString:@"Y"] && [_currentSelected count]==1){
           cell.accessoryType=UITableViewCellAccessoryCheckmark;
        };
        if(![_isDanXuan isEqualToString:@"Y"]){
            cell.accessoryType=UITableViewCellAccessoryCheckmark;
        };
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(![_isDanXuan isEqualToString:@"Y"]){//多选
        UITableViewCell*cell=[tableView cellForRowAtIndexPath:indexPath];
        
        if (cell.accessoryType==UITableViewCellAccessoryNone)
        {
            cell.accessoryType=UITableViewCellAccessoryCheckmark;
            [self dataSelected:[_array objectAtIndex:indexPath.row]];
        }else{
            cell.accessoryType=UITableViewCellAccessoryNone;
            [self removeSelected:[_array objectAtIndex:indexPath.row]];

        }
        _Mstr=[self getMStr];
        NSLog(@"多选，%@",_Mstr);
        [_btn setTitle:_Mstr forState:UIControlStateNormal];
    }else{ //单选
        UITableViewCell*cell=[tableView cellForRowAtIndexPath:indexPath];
        if (cell.accessoryType==UITableViewCellAccessoryNone)
        {
            cell.accessoryType=UITableViewCellAccessoryCheckmark;
            for (NSString* data in _currentSelected) {
                if([_array containsObject:data]){
                    NSUInteger index1=[_array indexOfObject:data];
                    NSIndexPath *tmpindexpath = [NSIndexPath indexPathForRow:index1 inSection:0];
                    UITableViewCell*cell1=[tableView cellForRowAtIndexPath:tmpindexpath];
                    cell1.accessoryType=UITableViewCellAccessoryNone;
                    [self removeSelected:data];
                }
            }
            [self dataSelected:[_array objectAtIndex:indexPath.row]];
        }else{
            cell.accessoryType=UITableViewCellAccessoryNone;
            [self removeSelected:[_array objectAtIndex:indexPath.row]];
        }
        
        
        _Mstr=[self getMStr];
        NSLog(@"单选，%@",_Mstr);
        [_btn setTitle:_Mstr forState:UIControlStateNormal];
    }
    
    

    
}





-(void)setNavTitle:(NSString*)titlestr
{
    _titlestr=titlestr;
}

-(void)setDanXuan
{
    _isDanXuan=@"Y";
}



-(Boolean)isSelected:(NSString*)data
{
    return [_currentSelected containsObject:data];
}


-(void) dataSelected:(NSString*)data
{
    if(![self isSelected:data]){
        [_currentSelected addObject:data];
    }
}

-(void)removeSelected:(NSString*)data
{
    if(_currentSelected==nil || [_currentSelected count]==0)
    {
        _currentSelected=[NSMutableArray array];
        return ;
    }
    [_currentSelected removeObject:data];
}






-(void)setSelectedData:(NSMutableArray*)datas
{
    _currentSelected=datas;
    _Mstr=[self getMStr];

}

-(NSMutableString*) getMStr
{
    NSMutableString* tmp=[NSMutableString string];
    if(_currentSelected!=nil && [_currentSelected count]>0){
        for (int i=0; i<[_currentSelected count]; i++) {
            [tmp appendString:[_currentSelected objectAtIndex:i]];
            if(i<[_currentSelected count]-1){
                [tmp appendString:@","];
            }
        }
    }
    return tmp;
}



//- (IBAction)btnclick:(id)sender {
//    UIButton* btn=(UIButton*)sender;
//    NSString* datas=btn.titleLabel.text;
//    if(datas!=nil && datas.length>0 && [datas containsString:@","])
//    {
//        datas=[datas stringByReplacingOccurrencesOfString:@"[" withString:@""];
//        datas=[datas stringByReplacingOccurrencesOfString:@"]" withString:@""];
//        NSArray* array=[datas componentsSeparatedByString:@","];
//    }
// }







@end
