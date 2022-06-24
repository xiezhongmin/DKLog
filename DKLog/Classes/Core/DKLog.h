//
//  DKLog.h
//  DKLog
//
//  Created by admin on 2022/6/22.
//

#import <Foundation/Foundation.h>
#import "LogHelper.h"

#define __FILENAME__ (strrchr(__FILE__,'/')+1)

/// Logger
#define DKLogDebug(format, ...) \
LogInternal(kLevelDebug, "null", __FILENAME__, __LINE__, __FUNCTION__, @" ", format, ##__VA_ARGS__)
#define DKLogInfo(format, ...) \
LogInternal(kLevelInfo, "null", __FILENAME__, __LINE__, __FUNCTION__, @" ", format, ##__VA_ARGS__)
#define DKLogWarn(format, ...) \
LogInternal(kLevelWarn, "null", __FILENAME__, __LINE__, __FUNCTION__, @" ", format, ##__VA_ARGS__)
#define DKLogError(format, ...) \
LogInternal(kLevelError, "null", __FILENAME__, __LINE__, __FUNCTION__, @" ", format, ##__VA_ARGS__)

/// Module Logger
#define DKLogModuleDebug(moduleName, format, ...) \
LogInternal(kLevelDebug, moduleName, __FILENAME__, __LINE__, __FUNCTION__, @" ", format, ##__VA_ARGS__)
#define DKLogModuleInfo(moduleName, format, ...) \
LogInternal(kLevelInfo, moduleName, __FILENAME__, __LINE__, __FUNCTION__, @" ", format, ##__VA_ARGS__)
#define DKLogModuleWarn(moduleName, format, ...) \
LogInternal(kLevelWarn, moduleName, __FILENAME__, __LINE__, __FUNCTION__, @" ", format, ##__VA_ARGS__)
#define DKLogModuleError(moduleName, format, ...) \
LogInternal(kLevelError, moduleName, __FILENAME__, __LINE__, __FUNCTION__, @" ", format, ##__VA_ARGS__)


typedef NS_ENUM(NSUInteger, DKLogConsoleFun) {
    DKLogConsoleFunNSLog,
    DKLogConsoleFunPrintf
};


@interface DKLogConfig : NSObject
/// --------------------------- @optional 可选配置  ---------------------------

/// 日志写入目录
@property (nonatomic, copy) NSString *dirPath;

/// 加密公钥, 不加密可设置 ""
@property (nonatomic, strong) NSString *pubKey;

/// 日志文件名的前缀
@property (nonatomic, copy) NSString *namePrefix;

/// 缓存文件夹路径
@property (nonatomic, copy) NSString *cacheDirPath;

/// 一般情况下填 0 即可, 非 0 表示会在 cacheDir 目录下存放几天的日志
@property (nonatomic) int cacheDays;

/// 日志最大存放大小， 超过 max_file_size 拆分成多个, 默认情况下，所有日志每天写入一个文件
@property (nonatomic) uint64_t maxFileSize;

/// 以秒为单位，默认为10天
@property (nonatomic) long aliveDuration;

/// debug 模式下是否打印日志, 默认打印
@property (nonatomic) BOOL debugConsole;

/// debug 模式下 设置日志级别, 默认为 kLevelDebug, 不推荐修改
@property (nonatomic) TLogLevel debugLogLevel;

/// release 模式下 设置日志级别, 默认为 kLevelInfo, 不推荐修改
@property (nonatomic) TLogLevel releaseLogLevel;

/// 打印方式, 默认为 DKLogConsoleFunNSLog
@property (nonatomic) DKLogConsoleFun consoleFun;

@end


@interface DKLog : NSObject

/// 当前的进程ID,
@property (nonatomic, readonly) int processId;

+ (instancetype)shared;

/// 默认配置初始化
/// 推荐在 main.mm, main 函数里中配置
/// 使用前只需要配置一次
- (void)install;

/// 自定义配置初始化
/// 推荐在 main.mm, main 函数里中配置
/// 使用前只需要配置一次
/// @param handle handle description
- (void)installWithConfig:(void (^)(DKLogConfig *config))handle;

/// 写入文件
- (void)flush;

/// 获取当前的日志写入目录
- (NSString *)getDirPath;

/// 获取当前日志缓存目录
- (NSString *)getCacheDirPath;

/// 在 applicationWillTerminate 函数中反初始化
- (void)close;

@end

