//
//  DetailShenSuVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/12.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"

@interface DetailShenSuVC : BaseViewController

@property (strong, nonatomic) IBOutlet UIButton *typeB;

@property (strong, nonatomic) IBOutlet UITextView *contentTV;

@property (strong, nonatomic) IBOutlet UITextView *reasonTV;



@property(nonatomic,strong)NSArray*ary;


-(void)setShuJu:(NSString*)str   infoAry:(NSArray*)ary;
@end
