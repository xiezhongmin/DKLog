//
//  DKLog.m
//  DKLog
//
//  Created by admin on 2022/6/22.
//

#import "DKLog.h"
#include <sys/xattr.h>
#import <mars/xlog/xlogger.h>
#import <mars/xlog/xloggerbase.h>
#import <mars/xlog/appender.h>
#import <Foundation/NSProcessInfo.h>

@interface DKLog ()

@property (nonatomic, readwrite) int processId;
@property (nonatomic, strong) DKLogConfig *config;

@end

@implementation DKLog

+ (instancetype)shared
{
    static id _shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[self alloc] init];
    });
    return _shared;
}

- (void)install
{
    [self installWithConfig:nil];
}

- (void)installWithConfig:(void (^)(DKLogConfig *config))handle
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _config = [[DKLogConfig alloc] init];
        _config.dirPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:@"/DKLog"];
        _config.namePrefix = @"DKLog";
        _config.pubKey = @"";
        _config.debugConsole = true;
        _config.debugLogLevel = kLevelDebug;
        _config.releaseLogLevel = kLevelInfo;
        _config.cacheDays = 0;
        _config.consoleFun = DKLogConsoleFunNSLog;
        if (handle) {
            handle(_config);
        }
        
        _processId = [NSProcessInfo processInfo].processIdentifier;
        
#ifdef DEBUG
        xlogger_SetLevel(_config.debugLogLevel);
        mars::xlog::appender_set_console_log(_config.debugConsole);
#else
        xlogger_SetLevel(_config.releaseLogLevel);
        mars::xlog::appender_set_console_log(false);
#endif
        
        // set max file size
        if (_config.maxFileSize) {
            mars::xlog::appender_set_max_file_size(_config.maxFileSize);
        }
        
        // set max alive duration
        if (_config.aliveDuration) {
            mars::xlog::appender_set_max_alive_duration(_config.aliveDuration);
        }
        
        if (_config.consoleFun != DKLogConsoleFunNSLog) {
            mars::xlog::appender_set_console_fun(mars::xlog::kConsolePrintf);
        }
        
        // set do not backup for logpath
        const char *attrName = "com.DKLog.MobileBackup";
        u_int8_t attrValue = 1;
        setxattr([_config.dirPath UTF8String], attrName, &attrValue, sizeof(attrValue), 0, 0);
        
        // set xlog appender open config
        mars::xlog::XLogConfig config = mars::xlog::XLogConfig();
        config.logdir_ = [_config.dirPath UTF8String];
        config.pub_key_ = [_config.pubKey UTF8String];
        config.nameprefix_ = [_config.namePrefix UTF8String];
        config.mode_ = mars::xlog::kAppenderAsync;
        
        if (_config.cacheDirPath) {
            config.cachedir_ = [_config.cacheDirPath UTF8String];
        }
        
        if (_config.cacheDays) {
            config.cache_days_ = _config.cacheDays;
        }
        
        mars::xlog::appender_open(config);
    });
}

- (void)flush
{
    mars::xlog::appender_flush();
}

/// 获取当前的日志写入目录
- (NSString *)getDirPath
{
    return _config.dirPath;
}

/// 获取当前日志缓存目录
- (NSString *)getCacheDirPath
{
    return _config.cacheDirPath;
}

- (void)close
{
    mars::xlog::appender_close();
}

@end


@implementation DKLogConfig

@end
