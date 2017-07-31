//
//  ComboViewController.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/7/27.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "ComboViewController.h"

@interface ComboViewController ()

@end

@implementation ComboViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self initWithData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setDatas:(NSArray*)array
{
    self.array=array;
}

-(void) setDatas:(NSArray*)array withBtn:(UIButton*) btn
{
    self.array=array;
    self.clickbtn=btn;
}


-(void) initWithData
{
    int num=0;
    if(num<[_array count]){
        [self.btn1 setTitle:[_array objectAtIndex:num] forState:UIControlStateNormal];
        [self.btn1 setHidden:NO];
        num++;
    }else{
        [self.btn1 setHidden:YES];
    }
    
    
    if(num<[_array count]){
        [self.btn2 setTitle:[_array objectAtIndex:num] forState:UIControlStateNormal];
        [self.btn2 setHidden:NO];
        num++;
    }else{
        [self.btn2 setHidden:YES];
    }
    
    
    if(num<[_array count]){
        [self.btn3 setTitle:[_array objectAtIndex:num] forState:UIControlStateNormal];
        [self.btn3 setHidden:NO];
        num++;
    }else{
        [self.btn3 setHidden:YES];
    }
    
    if(num<[_array count]){
        [self.btn4 setTitle:[_array objectAtIndex:num] forState:UIControlStateNormal];
        [self.btn4 setHidden:NO];
        num++;
    }else{
        [self.btn4 setHidden:YES];
    }
    
    if(num<[_array count]){
        [self.btn5 setTitle:[_array objectAtIndex:num] forState:UIControlStateNormal];
        [self.btn5 setHidden:NO];
        num++;
    }else{
        [self.btn5 setHidden:YES];
    }
    
    if(num<[_array count]){
        [self.btn6 setTitle:[_array objectAtIndex:num] forState:UIControlStateNormal];
        [self.btn6 setHidden:NO];
        num++;
    }else{
        [self.btn6 setHidden:YES];
    }
    
    if(num<[_array count]){
        [self.btn7 setTitle:[_array objectAtIndex:num] forState:UIControlStateNormal];
        [self.btn7 setHidden:NO];
        num++;
    }else{
        [self.btn7 setHidden:YES];
    }
    
    if(num<[_array count]){
        [self.btn8 setTitle:[_array objectAtIndex:num] forState:UIControlStateNormal];
        [self.btn8 setHidden:NO];
        num++;
    }else{
        [self.btn8 setHidden:YES];
    }
    
    if(num<[_array count]){
        [self.btn9 setTitle:[_array objectAtIndex:num] forState:UIControlStateNormal];
        [self.btn9 setHidden:NO];
        num++;
    }else{
        [self.btn9 setHidden:YES];
    }
    
    if(num<[_array count]){
        [self.btn10 setTitle:[_array objectAtIndex:num] forState:UIControlStateNormal];
        [self.btn10 setHidden:NO];
        num++;
    }else{
        [self.btn10 setHidden:YES];
    }
    

    
    
}



- (IBAction)btnclick:(id)sender {
    UIButton* btn=(UIButton*) sender;
    [self.clickbtn setTitle:(btn.titleLabel.text) forState:UIControlStateNormal];
    [self.clickbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if(self.navigationController){ //如果当前视图是导航控制器弹出，则pop
        [self.navigationController popViewControllerAnimated:YES];
    }else{//如果当前视图不是导航控制器弹出，则dismiss
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
   
}





-(id) initView
{
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    self=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    return self;
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
