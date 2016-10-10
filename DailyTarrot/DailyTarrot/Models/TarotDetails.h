//
//  TarotDetails.h
//  DailyTarrot
//
//  Created by Do Quoc Lam on 9/13/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TarotDetails : NSObject

@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *work;
@property (copy,nonatomic) NSString *finances;
@property (copy,nonatomic) NSString *health;
@property (copy,nonatomic) NSString *love;
@property (nonatomic)      NSInteger idCard;

@property (nonatomic) NSInteger month;
@property (nonatomic) NSInteger day;
- (void)encodeWithCoder:(NSCoder *)encoder;
- (id)initWithCoder:(NSCoder *)decoder;
@end
