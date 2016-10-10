//
//  DataAccess.m
//  DailyTarrot
//
//  Created by Do Quoc Lam on 9/14/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import "DataAccess.h"
#import "Const.h"

@implementation DataAccess

+ (void)setDailyTarot:(TarotDetails *)tarot forKey:(NSString *)key {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:tarot];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:key];
    [defaults synchronize];
}

+ (TarotDetails *)getTarrotForKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:key];
    TarotDetails *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return object;
}
+ (NSMutableDictionary *)getCurrentLocalTime {
    NSDate *date = [NSDate date];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    dateFormatter.dateFormat = @"dd";
    
    [dict setValue:[dateFormatter stringFromDate:date] forKey:lastOpenCardDay];
    dateFormatter.dateFormat = @"MM";
    [dict setValue:[dateFormatter stringFromDate:date] forKey:lastOpenCardMonth];
    return dict;
}

+ (NSMutableArray *)getAllTarotPicked {
    NSMutableArray *result  = [[NSMutableArray alloc] init];
    NSArray *arr = @[kWork,kFinance,kLove,kHealth];
    for (NSString *str in arr) {
        if ([self getTarrotForKey:str]) {
            [result addObject:[self getTarrotForKey:str]];
        }
    }
    
    return result;
}
@end
