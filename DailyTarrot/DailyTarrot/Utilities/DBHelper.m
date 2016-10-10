//
//  DBHelper.m
//  DailyTarrot
//
//  Created by Do Quoc Lam on 9/13/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import "DBHelper.h"
#import "TarotDetails.h"
@implementation DBHelper
+ (NSMutableArray *)getDataFromDataBase {
    NSString *dbUrl = [[NSBundle mainBundle] pathForResource:@"phuc" ofType:@"db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbUrl];
    if (![db open]) {
        return nil;
    }
    NSMutableArray *results = [[NSMutableArray alloc] init];
    FMResultSet *s = [db executeQuery:@"SELECT * FROM tarots"];
    while ([s next]) {
        //retrieve values for each record
        NSLog(@"%@",[s objectForColumnIndex:1]);
        TarotDetails *tarot = [[TarotDetails alloc] init];
        tarot.idCard = [[s objectForColumnName:@"_id"] integerValue];
        tarot.name   = [s objectForColumnName:@"name"];
        tarot.work   = [s objectForColumnName:@"work"];
        tarot.love   = [s objectForColumnName:@"love"];
        tarot.finances = [s objectForColumnName:@"finances"];
        tarot.health = [s objectForColumnName:@"health"];
        tarot.day = 0;
        tarot.month = 0;
        [results addObject:tarot];
    }
   [db close];
    return results;
}
@end
