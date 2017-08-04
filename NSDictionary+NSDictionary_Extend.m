//
//  NSDictionary+NSDictionary_Extend.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/4.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "NSDictionary+NSDictionary_Extend.h"

@implementation NSDictionary (NSDictionary_Extend)

- (NSString*)objectNotNullForKey:(NSString*)aKey
{
    @try {
        id obj=[self objectForKey:aKey];
        if(obj==nil) return @"";
        if([obj isKindOfClass:[NSNull class]]){
            return @"";
        }else if([obj isKindOfClass:[NSNumber class]]){
            return [NSString stringWithFormat:@"%@",(NSNumber*)obj];
        }else if([obj isKindOfClass:[NSString class]]){
            return (NSString*)obj;
        }else{
            return @"";
        }
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    return @"";
}


@end
