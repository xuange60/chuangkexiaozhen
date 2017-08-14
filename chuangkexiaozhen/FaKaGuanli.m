//
//  FaKaGuanli.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/14.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "FaKaGuanli.h"

@implementation FaKaGuanli


-(void)FaKaQuery
{
    [super querylistWithRole:@"" andRelativeUrl:@"/hairpinaction/search"];
}

-(void)FaKaDelete:(NSString*)ids
{
    [super deleteWithId:ids andRelativeUrl:@"/hairpinaction/delete"];
}

-(void)FaKaParamMapQuery
{
    [super queryParamMapwithRelativeUrl:@"/hairpinaction/add"];
}

-(void)FaKaAdd:(NSDictionary*)param
{
    [super addWithData:param andRelativeUrl:@"/hairpinaction/save"];
}


@end
