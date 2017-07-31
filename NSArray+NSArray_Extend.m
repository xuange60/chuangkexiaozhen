//
//  NSArray+NSArray_Extend.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/7/31.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "NSArray+NSArray_Extend.h"

@implementation NSArray (NSArray_Extend)



- (id)objectAtIndexNotErr:(NSUInteger)index
{
    if(index>=[self count]){
        return nil;
    }else{
        return [self objectAtIndex:index];
    }
}

@end
