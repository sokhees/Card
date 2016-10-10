//
//  DBHelper.h
//  DailyTarrot
//
//  Created by Do Quoc Lam on 9/13/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
@interface DBHelper : NSObject
+ (NSMutableArray *)getDataFromDataBase ;
@end
