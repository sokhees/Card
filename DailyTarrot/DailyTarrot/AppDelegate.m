//
//  AppDelegate.m
//  DailyTarrot
//
//  Created by Do Quoc Lam on 9/13/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import "AppDelegate.h"
#import "DBHelper.h"
#import "DataAccess.h"
#import "Const.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
@import GoogleMobileAds;
@interface AppDelegate ()

@end

@implementation AppDelegate

+ (AppDelegate *)sharedInstance {
    static dispatch_once_t onceToken;
    static AppDelegate *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        if (!sharedInstance) {
            sharedInstance = [[AppDelegate alloc] init];
        }
    });
    
    return sharedInstance;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    [AppDelegate sharedInstance].TarotCardArray = [DBHelper getDataFromDataBase];
    [self checkResetCardNewDay];
    
    [GADMobileAds configureWithApplicationID:@"ca-app-pub-1033592509452797/2585334662"];
    
    UILocalNotification* local = [[UILocalNotification alloc]init];
    if (local)
    {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [[NSDateComponents alloc] init];
        [components setDay: 3];
        [components setMonth: 7];
        [components setYear: 2012];
        [components setHour: 7];
        [components setMinute: 0];
        [components setSecond: 0];
        [calendar setTimeZone: [NSTimeZone defaultTimeZone]];
        NSDate *dateToFire = [calendar dateFromComponents:components];
        
        local.fireDate = dateToFire;
        local.repeatInterval = kCFCalendarUnitDay;
        local.alertBody = @"Hey Go pick your daily card!!!";
        local.timeZone = [NSTimeZone defaultTimeZone];
        [[UIApplication sharedApplication] scheduleLocalNotification:local];
        
    }
    return YES;
}
- (void)checkResetCardNewDay {
    
    NSDictionary *dict = [DataAccess getCurrentLocalTime];
    NSInteger day = [[dict objectForKey:lastOpenCardDay] integerValue];
    NSInteger month = [[dict objectForKey:lastOpenCardMonth] integerValue];
    NSArray *arr = @[kWork,kFinance,kLove,kHealth];
    for (int i = 0; i < 4; i++) {
        TarotDetails *tarrot = [DataAccess getTarrotForKey:[arr objectAtIndex:i]];
        if (tarrot.month == 0 || tarrot.day == 0) {
            continue;
        }
        if (tarrot ) {
            if (tarrot.month < month || (((tarrot.month == month) && tarrot.day < day))) {
                [DataAccess setDailyTarot:nil forKey:[arr objectAtIndex:i]];
            }
        }
    }
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
