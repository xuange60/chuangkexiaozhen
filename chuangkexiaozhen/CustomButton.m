//
//  CustomButton.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/27.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton


- (void)drawRect:(CGRect)rect
{
    NSLog(@"%s",__func__);
}

- (void)setNeedsDisplay
{
    NSLog(@"%s",__func__);
}
- (void)setNeedsDisplayInRect:(CGRect)rect
{
    NSLog(@"%s",__func__);
}


- (void)setNeedsLayout
{
    NSLog(@"%s",__func__);
}
- (void)layoutIfNeeded
{
    NSLog(@"%s",__func__);
}

- (void)layoutSubviews
{
    NSLog(@"%s",__func__);
}


- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    NSLog(@"%s",__func__);
    if (self=[super initWithCoder:aDecoder])
    {
        
    }
    return self;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    NSLog(@"%s",__func__);
    
    _lab1=[[UILabel alloc]init];
    _lab1.text=@"label1";
    [self addSubview:_lab1];
    
    _lab2=[[UILabel alloc]init];
    _lab2.text=@"label2";
    [self addSubview:_lab2];

    self.backgroundColor=[UIColor greenColor];
    
    
}

-(void)setContent:(NSString*)str   attributeStr:(NSString*)string
{
    _lab1.frame=CGRectMake(0, 0, 80,self.frame.size.height);
    _lab1.textAlignment=NSTextAlignmentRight;
    _lab1.font=[UIFont systemFontOfSize:12];
    _lab1.textColor=[UIColor blueColor];
    _lab1.text=str;

    
    
    _lab2.frame=CGRectMake(_lab1.frame.size.width, 0, 80, self.frame.size.height);
    _lab2.textAlignment=NSTextAlignmentLeft;
    _lab2.font=[UIFont systemFontOfSize:12];
    _lab2.textColor=[UIColor blueColor];
    _lab2.text=string;
    
//    self.autoresizesSubviews=YES;

    UITapGestureRecognizer*ges=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gesClick:)];
    [self addGestureRecognizer:ges];

}

- (nullable UIView *)hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event
{
    UIView*view;
    return view;
}
- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event
{
    return YES;
}
- (CGPoint)convertPoint:(CGPoint)point toView:(nullable UIView *)view
{
    return point;
}
- (CGPoint)convertPoint:(CGPoint)point fromView:(nullable UIView *)view
{
    return point;
}
- (CGRect)convertRect:(CGRect)rect toView:(nullable UIView *)view
{
    return rect;
}
- (CGRect)convertRect:(CGRect)rect fromView:(nullable UIView *)view{
    return rect;
}



-(id)init
{
    NSLog(@"%s",__func__);
    
    if (self=[super init]) {
    
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    NSLog(@"%s",__func__);
    if (self=[super initWithFrame:frame]){
        
    }
     return self;
}

-(void)gesClick:(UIGestureRecognizer*)ges
{
    
}

-(void)clicked:(CustomButton*)btn
{
    
}





















@end
