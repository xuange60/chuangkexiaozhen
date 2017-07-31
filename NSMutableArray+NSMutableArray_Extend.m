//
//  NSMutableArray+NSMutableArray_Extend.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/7/31.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "NSMutableArray+NSMutableArray_Extend.h"

@implementation NSMutableArray (NSMutableArray_Extend)

- (id)objectAtIndexNotErr:(NSUInteger)index
{
    if(index>=[self count]){
        return nil;
    }else{
        return [self objectAtIndex:index];
    }
}




@end
