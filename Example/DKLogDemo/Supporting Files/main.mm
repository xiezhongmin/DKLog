//
//  main.m
//  DKLogDemo
//
//  Created by admin on 2022/6/22.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <DKLog/DKLog.h>

int main(int argc, char * argv[]) {
    [[DKLog shared] install];
    
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
