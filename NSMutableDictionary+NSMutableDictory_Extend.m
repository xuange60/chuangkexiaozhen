//
//  NSMutableDictionary+NSMutableDictory_Extend.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/7/31.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "NSMutableDictionary+NSMutableDictory_Extend.h"

@implementation NSMutableDictionary (NSMutableDictory_Extend)


- (void)setNotNullStrObject:(NSString*)anObject forKey:(id)aKey
{
    if(aKey==nil){
        return;
    }
    if(anObject==nil){
        anObject=@"";
    }
    [self setObject:anObject forKey:aKey];
}

- (void)setNotNullObject:(id)anObject forKey:(id)aKey;
{
    if(aKey==nil || anObject==nil){
        return;
    }

    [self setObject:anObject forKey:aKey];
}


@end
