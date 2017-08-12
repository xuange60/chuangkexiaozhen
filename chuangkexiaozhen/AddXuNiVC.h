//
//  AddXuNiVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/12.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "XuNiRuZhuGuanLi.h"
@interface AddXuNiVC : BaseViewController<BussinessApiDelegate>

@property(nonatomic,strong)XuNiRuZhuGuanLi*XuNi;


@property (strong, nonatomic) IBOutlet UITextField *F1;
@property (strong, nonatomic) IBOutlet UITextField *F2;
@property (strong, nonatomic) IBOutlet UITextField *F3;
@property (strong, nonatomic) IBOutlet UIView *MyView;


@property (strong, nonatomic) IBOutlet UIButton *duoxuan;

@property (strong, nonatomic) IBOutlet UITextView *textView;

- (IBAction)BtnClicked:(id)sender;


@property(nonatomic,strong)NSString*strId;
@property(nonatomic,strong)NSArray*infoAry;

-(void) setShuJu:(NSString*)strId   infoAry:(NSArray*)infoAry;


@end
