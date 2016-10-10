//
//  DataAccess.h
//  DailyTarrot
//
//  Created by Do Quoc Lam on 9/14/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TarotDetails.h"
@interface DataAccess : NSObject

+ (void)setDailyTarot:(TarotDetails *)tarot forKey:(NSString *)key;

+ (TarotDetails *)getTarrotForKey:(NSString *)key;

+ (NSMutableDictionary *)getCurrentLocalTime;
+ (NSMutableArray *)getAllTarotPicked;
@end
