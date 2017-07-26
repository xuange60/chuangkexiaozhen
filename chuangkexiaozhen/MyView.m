//
//  MyView.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/22.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "MyView.h"

@implementation MyView

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
        self.lab1.text=str;
        [self.btn1 setTitle:str forState:UIControlStateNormal];
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
    

}


@end
