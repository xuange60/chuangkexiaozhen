//
//  CustomButton.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/27.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton
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
    
    self.backgroundColor=[UIColor whiteColor];
    
    
}

-(void)setContent:(NSString*)str   attributeStr:(NSString*)string
{
    _lab1.frame=CGRectMake(0, 0, 80,self.frame.size.height);
    _lab1.textAlignment=NSTextAlignmentRight;
    _lab1.font=[UIFont systemFontOfSize:14];
    _lab1.text=str;
    

    _lab2.frame=CGRectMake(0, 0, 150, self.frame.size.height);
    _lab2.textAlignment=NSTextAlignmentLeft;
    _lab2.font=[UIFont systemFontOfSize:14];
    _lab2.text=string;
    
}









































































//- (void)drawRect:(CGRect)rect
//{
//    NSLog(@"%s",__func__);
//}
//
//- (void)setNeedsDisplay
//{
//    NSLog(@"%s",__func__);
//}
//- (void)setNeedsDisplayInRect:(CGRect)rect
//{
//    NSLog(@"%s",__func__);
//}
//
//
//- (void)setNeedsLayout
//{
//    NSLog(@"%s",__func__);
//}
//- (void)layoutIfNeeded
//{
//    NSLog(@"%s",__func__);
//}
//
//- (void)layoutSubviews
//{
//    NSLog(@"%s",__func__);
//}


//- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
//{
//    NSLog(@"%s",__func__);
//    if (self=[super initWithCoder:aDecoder])
//    {
//        
//    }
//    return self;
//}



//-(void)gesClick:(UIGestureRecognizer*)ges
//{
//    
//}


//该方法作用： 寻找并返回最合适的view来处理触摸响应事件

//- (nullable UIView *)hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event
//{
//    NSLog(@"%s",__func__);
//    UIView*view;
//    return view;
//}


//- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event
//{
//    NSLog(@"%s",__func__);
//    return YES;
//}

//
//- (CGPoint)convertPoint:(CGPoint)point toView:(nullable UIView *)view
//{
//    NSLog(@"%s",__func__);
//    return point;
//}
//- (CGPoint)convertPoint:(CGPoint)point fromView:(nullable UIView *)view
//{
//    NSLog(@"%s",__func__);
//    return point;
//}
//- (CGRect)convertRect:(CGRect)rect toView:(nullable UIView *)view
//{
//    NSLog(@"%s",__func__);
//    return rect;
//}
//- (CGRect)convertRect:(CGRect)rect fromView:(nullable UIView *)view{
//    NSLog(@"%s",__func__);
//    return rect;
//}



//-(id)init
//{
//    NSLog(@"%s",__func__);
//    
//    if (self=[super init]) {
//    
//    }
//    return self;
//}
//
//-(id)initWithFrame:(CGRect)frame
//{
//    NSLog(@"%s",__func__);
//    if (self=[super initWithFrame:frame]){
//        
//    }
//     return self;
//}
//










////UIRespond的触摸事件响应方法
//
////这些方法系统会自动调用，不需要手动调用
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
//{
//    NSLog(@"%s",__func__);
//}
//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
//{
//     NSLog(@"%s",__func__);
//}
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
//{
//     NSLog(@"%s",__func__);
//}
//- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
//{
//     NSLog(@"%s",__func__);
//}
//- (void)touchesEstimatedPropertiesUpdated:(NSSet<UITouch *> *)touches
//{
//     NSLog(@"%s",__func__);
//}
//

////UIRespond的加速计（摇一摇）事件响应方法
//- (void)motionBegan:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event
//{
//     NSLog(@"%s",__func__);
//}
//- (void)motionEnded:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event
//{
//     NSLog(@"%s",__func__);
//}
//- (void)motionCancelled:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event
//{
//     NSLog(@"%s",__func__);
//}
//
////UIRespond的远程控制事件响应方法
//- (void)remoteControlReceivedWithEvent:(nullable UIEvent *)event
//{
//     NSLog(@"%s",__func__);
//}








@end
