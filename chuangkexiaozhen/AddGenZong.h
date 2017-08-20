//
//  AddGenZong.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/21.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "ChengGuoGenZong.h"
#import "DuoXuanVC.h"
#import "ImgeUpViewController.h"
@interface AddGenZong : BaseViewController<BussinessApiDelegate>

@property (strong, nonatomic) IBOutlet UIButton *luyanName;


@property (strong, nonatomic) IBOutlet UITextField *baogaoName;
@property(nonatomic,strong)ChengGuoGenZong*genzong;

@property(nonatomic,strong)NSMutableDictionary*dic;
@property(nonatomic,strong)NSString*photoIds;




@end
