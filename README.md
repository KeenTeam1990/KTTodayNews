# Swift开源项目-模仿今日头条

[![Build Status](https://travis-ci.org/hrscy/TodayNews.svg?branch=master)](https://travis-ci.org/hrscy/TodayNews) ![swift5.1](https://img.shields.io/badge/language-swift%205.1-orange.svg)

# 2022.09.09
## 新增接口文档
[接口文档](https://github.com/KeenTeam1990/KTTodayNews/tree/master/todayNews-docs)
接口文档使用的是 [MKDocs](http://www.mkdocs.org/)，具体安装方法以及使用可以参考官网的介绍。

# 2022.09.05
## 目前正在录制视频...

# 2022.08.22

## 编译的时候，可能会报错，提示某个文件找不到，可以去相应的文件夹里去找，然后拖到工程里，再编译运行就可以了。

# 2022.08.15

# 后面有时间的话会考虑出一个视频教程。

# 2022.06.15

## 删除 Swift 4.2 相关代码，继续适配 Swift 5.1。

## 带有YM 前缀的类都已不再使用，如果运行过程中出现报错，请删除相关类文件或代码。

# 2022.06.12 

# 目前在适配 Swift 5.1，只完成了部分功能，后面会继续更新。
## 环境设置

-  项目环境
-  Xcode 13
-  Swift 5.1
-  iOS 10.0 +
-  使用 cocoaPods 管理第三方库， 如果电脑没有安装 cocoapods，请先安装 cocoapods，cocoapods 版本为 1.2.0，安装方式请参考  [iOS-CocoaPod升级cocoapods1.2.0 (适配swift3)](http://blog.csdn.net/qxuewei/article/details/53113920)。

![](http://obna9emby.bkt.clouddn.com/news/news.gif)

## 实现的功能

1. 获取今日头条的接口
2. 完成首页的布局和数据的显示
3. 实现首页顶部导航栏滚动
4. 新闻详情界面显示广告和评论
5. 点击标题『+』按钮弹出频道界面
6. 悟空问答界面实现
7. 获取视频真实地址
8. 视频播放功能
9. 视频界面显示相关新闻和评论
10. 完成视频界面顶部导航栏滚动
11. 完成视频界面布局和数据获取
12. 微头条界面实现
13. 用户界面简单实现
14. 完成关注界面布局和数据的获取
15. 完成关注界面，添加关注功能
16. 完成搜索功能
17. 完成个人界面的布局
18. 个人界面点击关注出现相关关注详情
19. 活动界面简单实现
20. 登录界面的简单实现
21. 系统设置界面
22. 离线下载界面
23. 实现更换主题功能

## 数据请求

#### 今日头条的接口文件请看：

[今日头条接口.postman_collection.json](https://github.com/hrscy/TodayNews/blob/master/news.json)，需要提前安装 postman，然后把该文件导入到 postman 进行查看，可以打开谷歌浏览器，找到扩展程序，添加新的扩展，搜索 postman。

#### 下载完成后，直接拖入到谷歌浏览器的扩展程序界面即可。

#### 当然也可以使用 sublime 或 vscode 打开 json 文件。

#### 数据请求的具体方式，请看 [NetworkTool.swift](https://github.com/KeenTeam1990/KTTodayNews/blob/master/TodayNews/Classes/Main/Tools/NetworkTool.swift)。
#[GitHub](https://github.com/KeenTeam1990/KTTodayNews.git)

# 2022.02.18

## 说明

首先声明，今日头条是我经常用的 app 之一，模仿今日头条也是因为感兴趣，代码仅用于学习交流。对于项目中的数据接口都是通过 Charles 抓包获得，基本每个界面都是有数据请求，不会抓包的朋友可以看我 [这一篇文章](http://www.jianshu.com/p/235bc6c3ca77)。

项目中有的地方代码写的不是很简洁，毕竟自己能力有限，对 Swift 使用很熟练，还请各位朋友不喜勿喷。下面有项目的完整源码，喜欢的朋友可以下载下来，如果您感觉我写的代码对您有所帮助，还请在 github 给个star✨⭐️🇨🇳✨⭐️🇨🇳✨⭐️🇨🇳✨⭐️🇨✨⭐️🇨🇳✨⭐️🇨🇳✨⭐️🇨🇳✨⭐️🇨🇳，非常感谢您的支持！~

#### 对于代码中出现的问题，可以及时联系我，我会继续修改。

# License

The MIT License (MIT) keen_team Copyright (c) 2014 KEENTEAM
