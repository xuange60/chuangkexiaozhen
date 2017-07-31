//
//  NSMutableDictionary+NSMutableDictory_Extend.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/7/31.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (NSMutableDictory_Extend)

- (void)setNotNullStrObject:(NSString*)anObject forKey:(id)aKey;

- (void)setNotNullObject:(id)anObject forKey:(id)aKey;


@end
