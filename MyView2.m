//
//  MyView2.m
//  chuangkexiaozhen
//
//  Created by zx on 17/7/26.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "MyView2.h"

@implementation MyView2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void) initWithTitle:(NSString*) title andValues:(NSArray*) values
{
    self.title=title;
    NSString* imgstr=[NSString stringWithFormat:@"%@%@",title,@".png"];
    UIImage* img=[UIImage imageNamed:imgstr];
    if(!img){
        img=[UIImage imageNamed:@"defaultImg.png"];
    }
    [self.img setImage:img];
    
    
    self.values=values;
    self.lab.text=title;
    
    int num=0;
    if(num<[values count]){
        NSString* str=values[num];
        NSString* imgstr=[NSString stringWithFormat:@"%@%@",str,@".gif"];
        UIImage* img=[UIImage imageNamed:imgstr];
        if(!img){
            img=[UIImage imageNamed:@"defaultBtnImg.png"];
        }
        [self.btn1 setImage:img forState:UIControlStateNormal];
        [self.btn1 setTitle:str forState:UIControlStateNormal];
        self.lab1.text=str;
        num++;
    }else{
        self.btn1.hidden=YES;
        self.lab1.hidden=YES;
    }
    
    
    if(num<[values count]){
        NSString* str=values[num];
        NSString* imgstr=[NSString stringWithFormat:@"%@%@",str,@".gif"];
        UIImage* img=[UIImage imageNamed:imgstr];
        if(!img){
            img=[UIImage imageNamed:@"defaultBtnImg.png"];
        }
        [self.btn2 setImage:img forState:UIControlStateNormal];
        [self.btn2 setTitle:str forState:UIControlStateNormal];
        self.lab2.text=str;
        num++;
    }else{
        self.btn2.hidden=YES;
        self.lab2.hidden=YES;
    }
    
    if(num<[values count]){
        NSString* str=values[num];
        NSString* imgstr=[NSString stringWithFormat:@"%@%@",str,@".gif"];
        UIImage* img=[UIImage imageNamed:imgstr];
        if(!img){
            img=[UIImage imageNamed:@"defaultBtnImg.png"];
        }
        [self.btn3 setImage:img forState:UIControlStateNormal];
        [self.btn3 setTitle:str forState:UIControlStateNormal];
        self.lab3.text=str;
        num++;
    }else{
        self.btn3.hidden=YES;
        self.lab3.hidden=YES;
    }
    
    if(num<[values count]){
        NSString* str=values[num];
        NSString* imgstr=[NSString stringWithFormat:@"%@%@",str,@".gif"];
        UIImage* img=[UIImage imageNamed:imgstr];
        if(!img){
            img=[UIImage imageNamed:@"defaultBtnImg.png"];
        }
        [self.btn4 setImage:img forState:UIControlStateNormal];
        [self.btn4 setTitle:str forState:UIControlStateNormal];
        self.lab4.text=str;
        num++;
    }else{
        self.btn4.hidden=YES;
        self.lab4.hidden=YES;
    }
    
    
    if(num<[values count]){
        NSString* str=values[num];
        NSString* imgstr=[NSString stringWithFormat:@"%@%@",str,@".gif"];
        UIImage* img=[UIImage imageNamed:imgstr];
        if(!img){
            img=[UIImage imageNamed:@"defaultBtnImg.png"];
        }
        [self.btn5 setImage:img forState:UIControlStateNormal];
        [self.btn5 setTitle:str forState:UIControlStateNormal];
        self.lab5.text=str;
        num++;
    }else{
        self.btn5.hidden=YES;
        self.lab5.hidden=YES;
    }
    
    if(num<[values count]){
        NSString* str=values[num];
        NSString* imgstr=[NSString stringWithFormat:@"%@%@",str,@".gif"];
        UIImage* img=[UIImage imageNamed:imgstr];
        if(!img){
            img=[UIImage imageNamed:@"defaultBtnImg.png"];
        }
        [self.btn6 setImage:img forState:UIControlStateNormal];
        [self.btn6 setTitle:str forState:UIControlStateNormal];
        self.lab6.text=str;
        num++;
    }else{
        self.btn6.hidden=YES;
        self.lab6.hidden=YES;
    }
    
    if(num<[values count]){
        NSString* str=values[num];
        NSString* imgstr=[NSString stringWithFormat:@"%@%@",str,@".gif"];
        UIImage* img=[UIImage imageNamed:imgstr];
        if(!img){
            img=[UIImage imageNamed:@"defaultBtnImg.png"];
        }
        [self.btn7 setImage:img forState:UIControlStateNormal];
        [self.btn7 setTitle:str forState:UIControlStateNormal];
        self.lab7.text=str;
        num++;
    }else{
        self.btn7.hidden=YES;
        self.lab7.hidden=YES;
    }
    
    if(num<[values count]){
        NSString* str=values[num];
        NSString* imgstr=[NSString stringWithFormat:@"%@%@",str,@".gif"];
        UIImage* img=[UIImage imageNamed:imgstr];
        if(!img){
            img=[UIImage imageNamed:@"defaultBtnImg.png"];
        }
        [self.btn8 setImage:img forState:UIControlStateNormal];
        [self.btn8 setTitle:str forState:UIControlStateNormal];
        self.lab8.text=str;
        num++;
    }else{
        self.btn8.hidden=YES;
        self.lab8.hidden=YES;
    }
    
}

@end
