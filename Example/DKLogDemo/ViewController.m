//
//  ViewController.m
//  DKLogDemo
//
//  Created by admin on 2022/6/22.
//

#import "ViewController.h"
#import <DKLog/DKLog.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    DKLogDebug(@"dir path= %@", [[DKLog shared] getDirPath]);    
    DKLogDebug(@"hello xlog");
    DKLogInfo(@"hello xlog");
    DKLogWarn(@"hello xlog");
    DKLogError(@"hello xlog");
    DKLogWarn(@"this class is %@", NSStringFromClass(self.class));
    
    DKLogModuleDebug("DKLog", @"hello xlog");
    DKLogModuleInfo("DKLog", @"hello xlog");
    DKLogModuleWarn("DKLog", @"hello xlog");
    DKLogModuleError("DKLog", @"hello xlog");
    DKLogModuleInfo("DKLog", @"this class is %@", NSStringFromClass(self.class));

    [[DKLog shared] flush];
}

@end
