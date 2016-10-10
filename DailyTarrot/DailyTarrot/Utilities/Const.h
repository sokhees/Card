//
//  Const.h
//  DailyTarrot
//
//  Created by Do Quoc Lam on 9/14/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#ifndef Const_h
#define Const_h
typedef NS_ENUM(NSInteger, TypeCard) {
    WorkType = 0,
    HealthType,
    FinanceType,
    LoveType
};

static NSString * const kWork = @"work";
static NSString * const kLove = @"love";
static NSString * const kHealth = @"health";
static NSString * const kFinance = @"finances";

static NSString * const lastOpenCardDay = @"lastOpenDay";
static NSString * const lastOpenCardMonth = @"lastOpenMonth";
#endif /* Const_h */
