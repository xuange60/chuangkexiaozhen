//
//  ComBoRowsViewController.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/29.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "ComBoRowsViewController.h"

@interface ComBoRowsViewController ()

@end

@implementation ComBoRowsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.flag1=NO;
    self.flag2=NO;
    self.flag3=NO;
    self.flag4=NO;
    self.flag5=NO;
    self.flag6=NO;
    self.flag7=NO;
    self.flag8=NO;
    self.flag9=NO;
    self.flag10=NO;
    self.value1=nil;
    self.value2=nil;
    self.value3=nil;
    self.value4=nil;
    self.value5=nil;
    self.value6=nil;
    self.value7=nil;
    self.value8=nil;
    self.value9=nil;
    self.value10=nil;
    [self initWithData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void) backvc
{
    NSArray* viewControllersr = self.navigationController.viewControllers;
    if([viewControllersr count]<=2){
        [self.navigationController setNavigationBarHidden:YES];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
    
    
    NSMutableString* string=[NSMutableString string];
    BOOL flag=NO;
    if(self.value1!=nil){
        if(flag){
            [string appendString:@","];
        }
        [string appendString:self.value1];
        flag=YES;
    }
    if(self.value2!=nil){
        if(flag){
            [string appendString:@","];
        }
        [string appendString:self.value2];
        flag=YES;
    }
    if(self.value3!=nil){
        if(flag){
            [string appendString:@","];
        }
        [string appendString:self.value3];
        flag=YES;
    }
    if(self.value4!=nil){
        if(flag){
            [string appendString:@","];
        }
        [string appendString:self.value4];
        flag=YES;
    }
    if(self.value5!=nil){
        if(flag){
            [string appendString:@","];
        }
        [string appendString:self.value5];
        flag=YES;
    }
    if(self.value6!=nil){
        if(flag){
            [string appendString:@","];
        }
        [string appendString:self.value6];
        flag=YES;
    }
    if(self.value7!=nil){
        if(flag){
            [string appendString:@","];
        }
        [string appendString:self.value7];
        flag=YES;
    }
    if(self.value8!=nil){
        if(flag){
            [string appendString:@","];
        }
        [string appendString:self.value8];
        flag=YES;
    }
    if(self.value9!=nil){
        if(flag){
            [string appendString:@","];
        }
        [string appendString:self.value9];
        flag=YES;
    }
    if(self.value10!=nil){
        if(flag){
            [string appendString:@","];
        }
        [string appendString:self.value10];
        flag=YES;
    }
    
    if(flag){
        [self.clickbtn setTitle:string forState:UIControlStateNormal];
        [self.clickbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else{
        [self.clickbtn setTitle:@"" forState:UIControlStateNormal];
    }

    
    [self.navigationController popViewControllerAnimated:YES];
    
}




- (IBAction)btn1click:(id)sender {
    UIButton* btn=(UIButton*)sender;
    if(!self.flag1){
        self.flag1=YES;
        btn.backgroundColor=[UIColor lightGrayColor];
        self.value1=btn.currentTitle;
    }else{
        self.flag1=NO;
        btn.backgroundColor=[UIColor colorWithRed:255 green:255 blue:255 alpha:1];
        self.value1=nil;
    }
    
}


- (IBAction)btn2click:(id)sender {
    UIButton* btn=(UIButton*)sender;
    if(!self.flag2){
        self.flag2=YES;
        btn.backgroundColor=[UIColor lightGrayColor];
        self.value2=btn.currentTitle;
    }else{
        self.flag2=NO;
        btn.backgroundColor=[UIColor colorWithRed:255 green:255 blue:255 alpha:1];
        self.value2=nil;
    }
}

- (IBAction)btn3click:(id)sender {
    UIButton* btn=(UIButton*)sender;
    if(!self.flag3){
        self.flag3=YES;
        btn.backgroundColor=[UIColor lightGrayColor];
        self.value3=btn.currentTitle;
    }else{
        self.flag3=NO;
        btn.backgroundColor=[UIColor colorWithRed:255 green:255 blue:255 alpha:1];
        self.value3=nil;
    }
}

- (IBAction)btn4click:(id)sender {
    UIButton* btn=(UIButton*)sender;
    if(!self.flag4){
        self.flag4=YES;
        btn.backgroundColor=[UIColor lightGrayColor];
        self.value4=btn.currentTitle;
    }else{
        self.flag4=NO;
        btn.backgroundColor=[UIColor colorWithRed:255 green:255 blue:255 alpha:1];
        self.value4=nil;
    }
}

- (IBAction)btn5click:(id)sender {
    UIButton* btn=(UIButton*)sender;
    if(!self.flag5){
        self.flag5=YES;
        btn.backgroundColor=[UIColor lightGrayColor];
        self.value5=btn.currentTitle;
    }else{
        self.flag5=NO;
        btn.backgroundColor=[UIColor colorWithRed:255 green:255 blue:255 alpha:1];
        self.value5=nil;
    }
}

- (IBAction)btn6click:(id)sender {
    UIButton* btn=(UIButton*)sender;
    if(!self.flag6){
        self.flag6=YES;
        btn.backgroundColor=[UIColor lightGrayColor];
        self.value6=btn.currentTitle;
    }else{
        self.flag6=NO;
        btn.backgroundColor=[UIColor colorWithRed:255 green:255 blue:255 alpha:1];
        self.value6=nil;
    }
}

- (IBAction)btn7click:(id)sender {
    UIButton* btn=(UIButton*)sender;
    if(!self.flag7){
        self.flag7=YES;
        btn.backgroundColor=[UIColor lightGrayColor];
        self.value7=btn.currentTitle;
    }else{
        self.flag7=NO;
        btn.backgroundColor=[UIColor colorWithRed:255 green:255 blue:255 alpha:1];
        self.value7=nil;
    }
}

- (IBAction)btn8click:(id)sender {
    UIButton* btn=(UIButton*)sender;
    if(!self.flag8){
        self.flag8=YES;
        btn.backgroundColor=[UIColor lightGrayColor];
        self.value8=btn.currentTitle;
    }else{
        self.flag8=NO;
        btn.backgroundColor=[UIColor colorWithRed:255 green:255 blue:255 alpha:1];
        self.value8=nil;
    }
}

- (IBAction)btn9click:(id)sender {
    UIButton* btn=(UIButton*)sender;
    if(!self.flag9){
        self.flag9=YES;
        btn.backgroundColor=[UIColor lightGrayColor];
        self.value9=btn.currentTitle;
    }else{
        self.flag9=NO;
        btn.backgroundColor=[UIColor colorWithRed:255 green:255 blue:255 alpha:1];
        self.value9=nil;
    }
}

- (IBAction)btn10click:(id)sender {
    UIButton* btn=(UIButton*)sender;
    if(!self.flag10){
        self.flag10=YES;
        btn.backgroundColor=[UIColor lightGrayColor];
        self.value10=btn.currentTitle;
    }else{
        self.flag10=NO;
        btn.backgroundColor=[UIColor colorWithRed:255 green:255 blue:255 alpha:1];
        self.value10=nil;
    }
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







/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
