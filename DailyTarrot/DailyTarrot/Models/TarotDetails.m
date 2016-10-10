//
//  TarotDetails.m
//  DailyTarrot
//
//  Created by Do Quoc Lam on 9/13/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import "TarotDetails.h"
#import "DataAccess.h"
#import "Const.h"
@implementation TarotDetails

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeInteger:self.idCard forKey:@"idCard"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.work forKey:kWork];
    [encoder encodeObject:self.finances forKey:kFinance];
    [encoder encodeObject:self.health forKey:kHealth];
    [encoder encodeObject:self.love forKey:kLove];
    NSMutableDictionary *dict = [DataAccess getCurrentLocalTime];
    [encoder encodeObject:[dict objectForKey:lastOpenCardMonth] forKey:@"month"];
    [encoder encodeObject:[dict objectForKey:lastOpenCardDay] forKey:@"day"];
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.idCard = [decoder decodeIntegerForKey:@"idCard"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.work = [decoder decodeObjectForKey:kWork];
        self.finances = [decoder decodeObjectForKey:kFinance];
        self.health = [decoder decodeObjectForKey:kHealth];
        self.love = [decoder decodeObjectForKey:kLove];
        self.month = [[decoder decodeObjectForKey:@"month"] integerValue];
        self.day = [[decoder decodeObjectForKey:@"day"] integerValue];
    }
    return self;
}

@end
