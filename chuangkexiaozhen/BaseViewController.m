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
    
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController setNavigationBarHidden:NO];
    
    UIImage *leftButtonIcon = [[UIImage imageNamed:@"left-arrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftBtnItem = [[UIBarButtonItem alloc] initWithImage:leftButtonIcon
                                                                    style:UIBarButtonItemStylePlain target:self action:@selector(backvc)];
    
    self.navigationItem.leftBarButtonItem=leftBtnItem;
    
//    self.navigationItem.rightBarButtonItem =self.rightbutton;
    
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
    UIView* view1=viewController.view;
    if(![self addDelegate:view1]){
        self.rightbutton.enabled=YES;
    }

}


-(BOOL) addDelegate:(UIView*)view
{
    BOOL hasInput=NO;
    if(view.hidden==YES){
        return hasInput;
    }
    
    NSArray*ary=view.subviews;

    
    for (  id obj in ary) {
        
        if ([obj isKindOfClass:[UITextField class]] && ((UITextField*)obj).hidden==NO && ((UITextField*)obj).userInteractionEnabled==YES)
        {
            UITextField*text=(UITextField*)obj;
            text.delegate=self;
            hasInput=YES;
        }else if ([obj isKindOfClass:[UITextView class]] && ((UITextView*)obj).hidden==NO && ((UITextView*)obj).userInteractionEnabled==YES)
        {
            UITextView*textView=(UITextView*)obj;
            textView.delegate=self;
            hasInput=YES;
        }else if ([obj isKindOfClass:[UIView class]] && [((UIView*)obj).subviews count]>0){
            if([self addDelegate:(UIView*)obj]){
                hasInput=YES;
            }
        }
    }
    return hasInput;
}


-(BOOL) checkInputHasNull:(UIView*) view
{
    NSArray*ary=view.subviews;
    BOOL isNull=NO;
    for (  id obj in ary) {
        if ([obj isKindOfClass:[UITextField class]] && ((UITextField*)obj).hidden==NO && ((UITextField*)obj).userInteractionEnabled==YES){
            UITextField*field=(UITextField*)obj;
            if (field.text !=nil && field.text.length>0){
                
            }else{
                isNull=YES;//有空跳出循环
                break;
            }
        }else if ([obj isKindOfClass:[UITextView class]] && ((UITextView*)obj).hidden==NO && ((UITextView*)obj).userInteractionEnabled==YES){
            UITextView*textView=(UITextView*)obj;
            if (textView.text!=nil && textView.text.length>0) {
                
            }else{
                isNull=YES;
                break;
            }
        }else if ([obj isKindOfClass:[UIView class]] && [((UIView*)obj).subviews count]>0){
            isNull=[self checkInputHasNull:(UIView*)obj];
        }
    }
    
    return isNull;
}



-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    BOOL isNull=[self checkInputHasNull:_currentVC.view];
    
    
    if (isNull==YES) {//有空不启用
        self.rightbutton.enabled=NO;
    }else{
        self.rightbutton.enabled=YES;
    }

    
}


-(void)textViewDidEndEditing:(UITextView *)textView
{
    BOOL isNull=[self checkInputHasNull:_currentVC.view];
    
    if (isNull==YES) {//有空不启用
        self.rightbutton.enabled=NO;
    }else{
        self.rightbutton.enabled=YES;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){//判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        
        [textView resignFirstResponder];
        
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    _TF=textField;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];//取消第一响应者
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_TF resignFirstResponder];
}




-(void)tiShiKuangDisplay:(NSString*)text viewController:(UIViewController*)vc;
{
    _HUD=[[MBProgressHUD alloc]initWithView:vc.view];
    [vc.view  addSubview:_HUD];
    
    _HUD.mode=MBProgressHUDModeText;
    _HUD.labelText=text;
    _HUD.margin=10;
//    _HUD.yOffset=vc.view.center.y-100;
    
    [_HUD show:YES];
    [_HUD hide:YES afterDelay:2];
    
}



-(void)paramsQuery:(NSString*)url
{
    [self queryParamMapwithRelativeUrl:url];
}

-(void) queryParamMapwithRelativeUrl:(NSString*) relativeurl
{
    NSString* baseurl=[[NSUserDefaults standardUserDefaults] objectForKey:@"baseurl"];
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,relativeurl];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        
        if([contenttype containsString:@"html"]){
            TFHpple* doc=[[TFHpple alloc]initWithHTMLData:responseObject];
            NSArray* arrays=[doc searchWithXPathQuery:@"//select"];
            NSMutableDictionary* datas=[[NSMutableDictionary alloc] init];
            for (TFHppleElement *ele in arrays) {
                NSString * name=[ele objectForKey:@"name"];
                NSArray* options=[ele childrenWithTagName:@"option"];
                if(name!=nil && options!=nil && [options count]>0){
                    NSMutableDictionary* data=[NSMutableDictionary dictionary];
                    for (TFHppleElement *ele1 in options) {
                        NSString* value1=[ele1 objectForKey:@"value"];
                        NSString* key1=[ele1 content];
                        if(value1!=nil && key1!=nil){
                            [data setObject:value1 forKey:key1];
                        }
                    }
                    [datas setObject:data forKey:name];
                }
            }
            
            _tmpparams=datas;
            //打印查询到的数据
            NSData *data = [NSJSONSerialization dataWithJSONObject:datas options:NSJSONWritingPrettyPrinted error:nil];
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",str);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}



@end
