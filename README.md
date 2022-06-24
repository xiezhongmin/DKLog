# DKLog
基于 mars/xlog 的高性能日志组件, 支持 Cocoapods 集成, 支持 bitcode

此库，目前阶段主要是方便使用 Cocoapods 集成管理, mars/xlog 集成过于麻烦，后续考虑封装或改造更多功能


## 关于集成 Cocoapods

```
 pod 'DKLog'
```

## 接入步骤:

- (1) 工程的 main.m 和 AppDelegate.m 后缀改成 .mm

- (2) 建议在 main.mm 中初始化

##效果图
![沙盒中存储的日志](https://i.postimg.cc/9M1LDk64/04ae1860-7612-4736-8eff-b8765b215e97.png)
![日志内容](https://i.postimg.cc/QNQ6P00K/0e084c2f-d140-45b4-a63d-3e03c1650967.png)
