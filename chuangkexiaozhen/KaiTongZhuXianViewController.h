//
//  KaiTongZhuXianViewController.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/7/30.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "BussinessApi.h"

@interface KaiTongZhuXianViewController : BaseViewController <UITextFieldDelegate>

@property (nonatomic) BOOL readonly;


@property (strong, nonatomic) IBOutlet UITextField *companyname;

@property (strong, nonatomic) IBOutlet UITextField *reportedbodies;

@property (strong, nonatomic) IBOutlet UITextField *leasearea;

@property (strong, nonatomic) IBOutlet UITextField *floor;

@property (strong, nonatomic) IBOutlet UITextField *communications;

@property (strong, nonatomic) IBOutlet UITextField *parkingLot;

@property (strong, nonatomic) IBOutlet UITextField *repastbodies;

@property (strong, nonatomic) IBOutlet UITextField *businessneeds;

@property (strong, nonatomic) IBOutlet UITextField *legalneeds;

@property (strong, nonatomic) IBOutlet UITextField *printneeds;

@property (strong, nonatomic) IBOutlet UITextField *companystatus;



@end
