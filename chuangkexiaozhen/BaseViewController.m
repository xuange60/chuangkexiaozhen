//
//  BaseViewController.m
//  chuangkexiaozhen
//
//  Created by zx on 17/7/26.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString* title1=self.navigationItem.title;
    if(title1==nil || title1.length==0){
        self.navigationItem.title=self.navtitle;
    }
    
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController setNavigationBarHidden:NO];
    
    UIImage *leftButtonIcon = [[UIImage imageNamed:@"left-arrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftBtnItem = [[UIBarButtonItem alloc] initWithImage:leftButtonIcon
                                                                    style:UIBarButtonItemStylePlain target:self action:@selector(backvc)];
    
    self.navigationItem.leftBarButtonItem=leftBtnItem;
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
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void) setNavigationItemTitle:(NSString*) title
{
    self.navtitle=title;
}
-(void)receiveCurrentViewController:(UIViewController*)viewController
{
    _currentVC=viewController;
    
    //用来设置特殊控件的delegate
    NSArray*ary=_currentVC.view.subviews;
    for (  id obj in ary) {
        
        if ([obj isKindOfClass:[UITextField class]])
        {
            UITextField*text=(UITextField*)obj;
            text.delegate=self;
        }else if ([obj isKindOfClass:[UITextView class]])
        {
            UITextView*textView=(UITextView*)obj;
            textView.delegate=self;
        }
    }

}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSArray*ary=_currentVC.view.subviews;
    
    BOOL isNull=NO;
    
    for (id obj in ary)
    {
        if ([obj  isKindOfClass:[UITextField class]])
        {
            UITextField*field=(UITextField*)obj;
            if (field.text !=nil && field.text.length>0)
            {
                
            }else{
                isNull=YES;//有空跳出循环
                break;
            }
        }else if ([obj isKindOfClass:[UITextView class]]){
            UITextView*textView=(UITextView*)obj;
            if (textView.text!=nil && textView.text.length>0) {
                
            }else{
                isNull=YES;
                break;
            }
        }
    }
    
    
    if (isNull==YES) {//有空不启用
        self.rightbutton.enabled=NO;
    }else{
        self.rightbutton.enabled=YES;
    }

    
}


-(void)textViewDidEndEditing:(UITextView *)textView
{
    NSArray*ary=_currentVC.view.subviews;
    
    BOOL isNull=NO;
    
    for (id obj in ary)
    {
        if ([obj  isKindOfClass:[UITextField class]])
        {
            UITextField*field=(UITextField*)obj;
            if (field.text !=nil && field.text.length>0)
            {
                
            }else{
                isNull=YES;//有空跳出循环
                break;
            }
        }else if ([obj isKindOfClass:[UITextView class]]){
            UITextView*textView=(UITextView*)obj;
            if (textView.text!=nil && textView.text.length>0) {
                
            }else{
                isNull=YES;
                break;
            }
        }
    }
    
    
    if (isNull==YES) {//有空不启用
        self.rightbutton.enabled=NO;
    }else{
        self.rightbutton.enabled=YES;
    }


}

-(void)tiShiKuangDisplay:(NSString*)text viewController:(UIViewController*)vc;
{
    _HUD=[[MBProgressHUD alloc]initWithView:vc.view];
    [vc.view  addSubview:_HUD];
    
    _HUD.mode=MBProgressHUDModeText;
    _HUD.labelText=text;
    _HUD.margin=10;
    _HUD.yOffset=vc.view.center.y-100;
    [_HUD show:YES];
    [_HUD hide:YES afterDelay:2];
    
}


@end
