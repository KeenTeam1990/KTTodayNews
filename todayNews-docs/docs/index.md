# 头条接口

## 请求地址前缀

http://lf.snssdk.com

http://ib.snssdk.com

https://is.snssdk.com

默认数据格式：JSON

## 部分参数介绍以及获取方法：

|      参数    |  类型  | 是否必须 |   描  述  | 示例  |
| ----------- | ------ | :------: | :-------: | ----- |
| resolution  | String |   N   | 屏幕尺寸 | 640*1136 |
| ab_feature  | String |   N   |  未知  | z1 |
| ab_version  | String |   N   | 未知  | 167910,164959,124647,170019,170695,170018,164677,163247,170349,157001,170749,159165,168998,169430,134128,169448,161298,162742,170294,152026,170238,162572,169058,170520,170567,156262,170508,166324,170691,170603,169601,169318,169300,165734,170659,170713,167300,145585,168081,170578,168629,165497,161718,150353 |
| ab_client  | String |   N  | 未知 | a1,f2,f7,e1 |
| ab_group   | String |   N  | 未知 | z1 |
| ac   | String |   N  | 网络连接方式 | WIFI |
| idfa  | String |   N  | 广告标识符 | 09F2E546-BA11-465E-BEAB-9C69C897351B |
| vid  | String |   N   |  同 idfv  | 09F2E546-BA11-465E-BEAB-9C69C897351B |
| idfv  | String |   N  | 设备唯一标识  | DD92E107-C73C-4A8B-9567-9DF97B6203D4 |
| os_version  | String |   N   |  系统版本  | 9.3.5 |
| version_code  | String |   N |  app 版本  | 6.3.2 |
| aid  | String |   N   |  未知  | 13 |
| device_platform  | String |   N   |  手机平台  | iphone |
| ssmix  | String |   N   |   未知  | a |
| device_type  | String |   N   |   手机型号  | iPhone 5S |
| channel  | String |   N   |   可能是下载渠道  | App Store |
| app_name  | String |   N   |   app 名称？  | news_article |

```
/// idfv 获取方法
let idfv = UIDevice.current.identifierForVendor?.uuidString
/// idfa 获取方法，需要 import AdSupport 
let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
/// 系统版本号
let systemVersion = UIDevice.current.systemVersion
/// 版本号
let versionCode = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
/// 屏幕尺寸
let resolution = "\(screenWidth * 2)*\(screenHeight * 2)"
/// https://github.com/ylechelle/OpenUDID
/// 需要 #include "OpenUDID.h"
NSString *openudid = [OpenUDID value];
```

> IDFV(identifierForVendor) 是 apple 给供应商唯一的一个值，也就是说同一个公司发行的的 app 在相同的设备上运行的时候会有这个相同的标识符，然而，如果用户删除了这个供应商的所有app然后再重新安装的话，这个标识符就会不一致。

> IDFA(identifierForAdvertising) 则是给在这个设备上所有软件供应商相同的一个值，一般在广告的时候使用，这个值虽然不会因为重装app改变，但是在某些情况下还是会改变。另外如果用户明确的还原广告(设置程序-> 通用 -> 关于本机 -> 广告 -> 还原广告标示符)，那么广告标示符也会重新生成。关于广告标示符的还原，还有一点需要注意：如果程序在后台运行，此时用户“还原广告标示符”，然后再回到程序中，此时获取广告标示符并不会立即获得还原后的标示符。必须要终止程序，然后再重新启动程序，才能获得还原后的广告标示符。



