//
//  AppDelegate.m
//  DKLogDemo
//
//  Created by admin on 2022/6/22.
//

#import "AppDelegate.h"
#import <DKLog/DKLog.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[DKLog shared] close];
}

@end
