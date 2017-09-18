# 视频接口

## 首页顶部标题接口

- 请求方式：GET

- 请求地址：/video_api/get_category/v1/?

- 请求参数

|      参数    |  类型  | 是否必须 |   描述  | 示例  |
| ----------- | ------ | :------: | ------- | ----- |
| device_id   | Int    |   N   | 设备 ID  | 8800803362 |
| iid   | Int    |   N   |  未知  | 14486549076 |
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

返回数据示例：

```
{
    "message": "success",
    "data": [
        {
            "category": "subv_voice",
            "name": "音乐",
            "icon_url": "",
            "web_url": "",
            "flags": 0,
            "tip_new": 0,
            "type": 4
        },
        {
            "category": "hotsoon",
            "name": "火山直播",
            "icon_url": "",
            "web_url": "",
            "flags": 0,
            "tip_new": 0,
            "type": 4
        }
    ]
}
```

## 视频列表接口

- 请求方式：GET

- 请求地址：/2/article/v39/refresh_tip/

- 请求参数

返回数据示例：

#### 1.视频-1

![](img/video/视频-1.png)

```
{
    "login_status": 0,
    "total_number": 8,
    "has_more": true,
    "post_content_hint": "分享「视频」的新鲜事",
    "sub_entrance_list": [],
    "show_et_status": 0,
    "feed_flag": 0,
    "message": "success",
    "has_more_to_refresh": true,
    "data": [
        {
            "content":{
                "abstract":"牛人改编《朋友的酒》制作的蘑菇头视频《减肥歌》，听完太扎心！",
                "action_extra":{
                    "channel_id":3431225546
                },
                "action_list":[
                    {
                        "action":1,
                        "desc":"",
                        "extra":{

                        }
                    },
                    {
                        "action":3,
                        "desc":"",
                        "extra":{

                        }
                    },
                    {
                        "action":7,
                        "desc":"",
                        "extra":{

                        }
                    },
                    {
                        "action":9,
                        "desc":"",
                        "extra":{

                        }
                    }
                ],
                "aggr_type":1,
                "allow_download":false,
                "article_sub_type":0,
                "article_type":0,
                "article_url":"http://toutiao.com/group/6456194233832309262/",
                "ban_comment":0,
                "behot_time":1503406281,
                "bury_count":24,
                "cell_flag":11,
                "cell_layout_style":1,
                "cell_type":0,
                "comment_count":478,
                "cursor":1503406281999,
                "digg_count":969,
                "display_url":"http://toutiao.com/group/6456194233832309262/",
                "filter_words":[
                    {
                        "id":"8:0",
                        "is_selected":false,
                        "name":"看过了"
                    },
                    {
                        "id":"9:1",
                        "is_selected":false,
                        "name":"内容太水"
                    },
                    {
                        "id":"5:1432815916",
                        "is_selected":false,
                        "name":"拉黑作者:蘑菇头视频"
                    },
                    {
                        "id":"6:16011",
                        "is_selected":false,
                        "name":"不想看:减肥"
                    },
                    {
                        "id":"6:50159991",
                        "is_selected":false,
                        "name":"不想看:朋友的酒"
                    }
                ],
                "forward_info":{
                    "forward_count":22
                },
                "group_flags":32832,
                "group_id":6456194233832310000,
                "has_m3u8_video":false,
                "has_mp4_video":0,
                "has_video":true,
                "hot":0,
                "ignore_web_transform":1,
                "is_subject":false,
                "item_id":6456194233832310000,
                "item_version":0,
                "keywords":"朋友的酒,视频,蘑菇头,减肥歌",
                "large_image_list":[
                    {
                        "height":326,
                        "uri":"video1609/36f700099777e8103c00",
                        "url":"http://p3.pstatp.com/video1609/36f700099777e8103c00",
                        "url_list":[
                            {
                                "url":"http://p3.pstatp.com/video1609/36f700099777e8103c00"
                            },
                            {
                                "url":"http://pb9.pstatp.com/video1609/36f700099777e8103c00"
                            },
                            {
                                "url":"http://pb1.pstatp.com/video1609/36f700099777e8103c00"
                            }
                        ],
                        "width":580
                    }
                ],
                "level":0,
                "like_count":969,
                "log_pb":{
                    "impr_id":"201708222051210100080430747122C9"
                },
                "media_info":{
                    "avatar_url":"http://p3.pstatp.com/large/3642000b7e3fc2fb7846",
                    "follow":false,
                    "is_star_user":false,
                    "media_id":1576158551899150,
                    "name":"蘑菇头视频",
                    "recommend_reason":"",
                    "recommend_type":0,
                    "user_id":66754998204,
                    "user_verified":false,
                    "verified_content":""
                },
                "media_name":"蘑菇头视频",
                "middle_image":{
                    "height":360,
                    "uri":"list/36f700099777e8103c00",
                    "url":"http://p3.pstatp.com/list/300x196/36f700099777e8103c00.webp",
                    "url_list":[
                        {
                            "url":"http://p3.pstatp.com/list/300x196/36f700099777e8103c00.webp"
                        },
                        {
                            "url":"http://pb9.pstatp.com/list/300x196/36f700099777e8103c00.webp"
                        },
                        {
                            "url":"http://pb1.pstatp.com/list/300x196/36f700099777e8103c00.webp"
                        }
                    ],
                    "width":640
                },
                "publish_time":1503199859,
                "read_count":62146,
                "repin_count":4151,
                "rid":"201708222051210100080430747122C9",
                "share_count":12896,
                "share_url":"http://m.zijiecdn.com/a6456194233832309262/?iid=13142832814&app=news_article",
                "show_portrait":false,
                "show_portrait_article":false,
                "source":"蘑菇头视频",
                "source_icon_style":2,
                "source_open_url":"sslocal://profile?refer=video&uid=66754998204",
                "tag":"news",
                "tag_id":6456194233832310000,
                "tip":0,
                "title":"牛人改编《朋友的酒》制作的蘑菇头视频《减肥歌》，听完太扎心！",
                "ugc_recommend":{
                    "activity":"",
                    "reason":""
                },
                "url":"http://toutiao.com/group/6456194233832309262/",
                "user_info":{
                    "avatar_url":"http://p3.pstatp.com/thumb/3642000b7e3fc2fb7846",
                    "description":"专注蘑菇头表情视频制作和分享！希望能带给大家更多的快乐！",
                    "follow":false,
                    "follower_count":0,
                    "name":"蘑菇头视频",
                    "user_id":66754998204,
                    "user_verified":false
                },
                "user_repin":0,
                "user_verified":0,
                "verified_content":"",
                "video_detail_info":{
                    "detail_video_large_image":{
                        "height":326,
                        "uri":"video1609/36f700099777e8103c00",
                        "url":"http://p3.pstatp.com/video1609/36f700099777e8103c00",
                        "url_list":[
                            {
                                "url":"http://p3.pstatp.com/video1609/36f700099777e8103c00"
                            },
                            {
                                "url":"http://pb9.pstatp.com/video1609/36f700099777e8103c00"
                            },
                            {
                                "url":"http://pb1.pstatp.com/video1609/36f700099777e8103c00"
                            }
                        ],
                        "width":580
                    },
                    "direct_play":1,
                    "group_flags":32832,
                    "show_pgc_subscribe":1,
                    "video_id":"b9cea0ee31064cd8aedf2cdf5902d7ee",
                    "video_preloading_flag":1,
                    "video_type":0,
                    "video_watch_count":150841,
                    "video_watching_count":0
                },
                "video_duration":175,
                "video_id":"b9cea0ee31064cd8aedf2cdf5902d7ee",
                "video_play_info":{
                    "status":10,
                    "message":"success",
                    "video_duration":175.1,
                    "validate":"0",
                    "enable_ssl":false,
                    "poster_url":"http://p3.pstatp.com/origin/36f80006dd519662f5d3",
                    "original_play_url":{
                        "backup_url":"http://voffline.pstatp.com/audit/m/ffbb000020f6c80ba8fc/",
                        "main_url":"http://voffline.pstatp.com/audit/m/ffbb000020f6c80ba8fc/"
                    },
                    "video_list":{
                        "video_1":{
                            "definition":"360p",
                            "vtype":"mp4",
                            "vwidth":640,
                            "vheight":360,
                            "bitrate":60974,
                            "logo_name":"xigua",
                            "coded_format":"h264",
                            "size":2880180,
                            "main_url":"aHR0cDovL3YxLXR0Lml4aWd1YS5jb20vYjhhY2QyOTVkZWY1NmVjZDdiMzYzMmIxMTA4ODdhZjIvNTk5YzI4Y2EvdmlkZW8vbS8yMjBmY2U2NWM5YjBmZDc0N2I2ODgwZmQxMjgxODVkM2FkYTExNGY1NTcwMDAwN2I2OTJiN2EzNmFhLw==",
                            "backup_url_1":"aHR0cDovL3Y3LnBzdGF0cC5jb20vOGY2ODU3YWE1MmZlODQwMmQ2ZTBjODU1YjI1MTQ3YTUvNTk5YzI4Y2EvdmlkZW8vbS8yMjBmY2U2NWM5YjBmZDc0N2I2ODgwZmQxMjgxODVkM2FkYTExNGY1NTcwMDAwN2I2OTJiN2EzNmFhLw==",
                            "user_video_proxy":1,
                            "socket_buffer":36584400,
                            "preload_size":327680,
                            "preload_interval":25,
                            "preload_min_step":5,
                            "preload_max_step":10
                        },
                        "video_2":{
                            "definition":"480p",
                            "vtype":"mp4",
                            "vwidth":854,
                            "vheight":480,
                            "bitrate":82513,
                            "logo_name":"xigua",
                            "coded_format":"h264",
                            "size":3351706,
                            "main_url":"aHR0cDovL3YxLXR0Lml4aWd1YS5jb20vZWYzZGNiMmY0MzdkY2NkZDQ4OGFiZGQ3ODg5N2M0OTUvNTk5YzI4Y2EvdmlkZW8vbS8yMjA0MjA1NmU4MTczM2Y0YmNmYmI3M2EzNzE5OGRlYzEyZDExNGY2MGQwMDAwM2FhOTdhMzcxM2VjLw==",
                            "backup_url_1":"aHR0cDovL3Y3LnBzdGF0cC5jb20vMmM1OTY4MTZmYjFkNmM5YWE4NGM5Nzg0MGY3MDdlNzIvNTk5YzI4Y2EvdmlkZW8vbS8yMjA0MjA1NmU4MTczM2Y0YmNmYmI3M2EzNzE5OGRlYzEyZDExNGY2MGQwMDAwM2FhOTdhMzcxM2VjLw==",
                            "user_video_proxy":1,
                            "socket_buffer":49507800,
                            "preload_size":327680,
                            "preload_interval":25,
                            "preload_min_step":5,
                            "preload_max_step":10
                        },
                        "video_3":{
                            "definition":"720p",
                            "vtype":"mp4",
                            "vwidth":960,
                            "vheight":540,
                            "bitrate":110616,
                            "logo_name":"xigua",
                            "coded_format":"h264",
                            "size":3966768,
                            "main_url":"aHR0cDovL3YxLXR0Lml4aWd1YS5jb20vYTU1NDRlZGMwZGQwNWVkMzI1ZGMxYmU0YzQ0OGE3NDYvNTk5YzI4Y2EvdmlkZW8vbS8yMjA0ZDQ1OGNlMGM1ODI0ZGUwYWRhYzIzYzE0OWFmMzU1MTExNGY1OTAwMDAwMWY1NzE0NjI0MzRmLw==",
                            "backup_url_1":"aHR0cDovL3Y3LnBzdGF0cC5jb20vYTdiN2MyZmM1Mjk0ODBjNDU3NTU5NWMwNTU3ZDE2NTUvNTk5YzI4Y2EvdmlkZW8vbS8yMjA0ZDQ1OGNlMGM1ODI0ZGUwYWRhYzIzYzE0OWFmMzU1MTExNGY1OTAwMDAwMWY1NzE0NjI0MzRmLw==",
                            "user_video_proxy":1,
                            "socket_buffer":66369600,
                            "preload_size":327680,
                            "preload_interval":25,
                            "preload_min_step":5,
                            "preload_max_step":10
                        }
                    },
                    "dns_info":{

                    }
                },
            "video_style":8
        },
        "code":""
    }
    ],
    "tips": {
        "display_info": "今日头条推荐引擎有8条更新",
        "open_url": "",
        "web_url": "",
        "app_name": "今日头条",
        "package_name": "",
        "display_template": "今日头条推荐引擎有%s条更新",
        "type": "app",
        "display_duration": 2,
        "download_url": ""
    }
}
```

#### 2.视频-2

![](img/video/视频-2.png)

返回数据示例：

```
{
    "abstract":"（本文由毒舌电影原创：dsmovie）作为一个内心细腻的女生。老实说，下面说的这部作品，是表妹今年看过最好的爱情片，一点不夸张。尽管它只有两分钟。它叫《方块》（Cube），是一部动画短片。片子用简单的圆球和方块，映射出为爱疯狂的痴男怨女。",
    "action_extra":{
        "channel_id":3431225546
    },
    "action_list":[
        {
            "action":1,
            "desc":"",
            "extra":{

            }
        },
        {
            "action":3,
            "desc":"",
            "extra":{

            }
        },
        {
            "action":7,
            "desc":"",
            "extra":{

            }
        },
        {
            "action":9,
            "desc":"",
            "extra":{

            }
        }
    ],
    "aggr_type":1,
    "allow_download":false,
    "article_sub_type":0,
    "article_type":0,
    "article_url":"http://toutiao.com/group/6425939369212182785/",
    "ban_comment":0,
    "behot_time":1503467025,
    "bury_count":56,
    "cell_flag":11,
    "cell_layout_style":1,
    "cell_type":0,
    "comment_count":728,
    "cursor":1503467025999,
    "digg_count":1795,
    "display_url":"http://toutiao.com/group/6425939369212182785/",
    "filter_words":[
        {
            "id":"8:0",
            "is_selected":false,
            "name":"看过了"
        },
        {
            "id":"9:1",
            "is_selected":false,
            "name":"内容太水"
        },
        {
            "id":"5:1289497126",
            "is_selected":false,
            "name":"拉黑作者:Sir电影"
        },
        {
            "id":"6:2433578",
            "is_selected":false,
            "name":"不想看:爱情片"
        }
    ],
    "forward_info":{
        "forward_count":141
    },
    "gallary_image_count":2,
    "group_flags":32832,
    "group_id":6425939369212183000,
    "has_image":true,
    "has_m3u8_video":false,
    "has_mp4_video":0,
    "has_video":true,
    "hot":0,
    "ignore_web_transform":1,
    "is_subject":false,
    "item_id":6426130272919487000,
    "item_version":0,
    "keywords":"爱情片,演员,电影,动画短片,为爱疯狂,方块",
    "large_image_list":[
        {
            "height":326,
            "uri":"video1609/22d2000467f35aadaa6b",
            "url":"http://p1.pstatp.com/video1609/22d2000467f35aadaa6b",
            "url_list":[
                {
                    "url":"http://p1.pstatp.com/video1609/22d2000467f35aadaa6b"
                },
                {
                    "url":"http://pb3.pstatp.com/video1609/22d2000467f35aadaa6b"
                },
                {
                    "url":"http://pb9.pstatp.com/video1609/22d2000467f35aadaa6b"
                }
            ],
            "width":580
        }
    ],
    "level":0,
    "like_count":1795,
    "log_pb":{
        "impr_id":"20170823135345010008019217457313"
    },
    "media_info":{
        "avatar_url":"http://p5a.pstatp.com/large/2c65000be73f5b7c6060",
        "follow":false,
        "is_star_user":false,
        "media_id":3348910754,
        "name":"Sir电影",
        "recommend_reason":"",
        "recommend_type":0,
        "user_id":3348869475,
        "user_verified":true,
        "verified_content":""
    },
    "media_name":"Sir电影",
    "middle_image":{
        "height":360,
        "uri":"list/22d2000467f35aadaa6b",
        "url":"http://p1.pstatp.com/list/300x196/22d2000467f35aadaa6b.webp",
        "url_list":[
            {
                "url":"http://p1.pstatp.com/list/300x196/22d2000467f35aadaa6b.webp"
            },
            {
                "url":"http://pb3.pstatp.com/list/300x196/22d2000467f35aadaa6b.webp"
            },
            {
                "url":"http://pb9.pstatp.com/list/300x196/22d2000467f35aadaa6b.webp"
            }
        ],
        "width":640
    },
    "publish_time":1496200048,
    "read_count":115684,
    "repin_count":20287,
    "rid":"20170823135345010008019217457313",
    "share_count":28085,
    "share_url":"http://m.zijiecdn.com/a6425939369212182785/?iid=13142832814&app=news_article",
    "show_portrait":false,
    "show_portrait_article":false,
    "source":"Sir电影",
    "source_icon_style":6,
    "source_open_url":"sslocal://profile?refer=video&uid=3348869475",
    "tag":"news_entertainment",
    "tag_id":6425939369212183000,
    "tip":0,
    "title":"今年最好的爱情片，尽管只有2分钟",
    "ugc_recommend":{
        "activity":"",
        "reason":"电影评论人"
    },
    "url":"http://toutiao.com/group/6425939369212182785/",
    "user_info":{
        "avatar_url":"http://p3.pstatp.com/thumb/2c65000be73f5b7c6060",
        "description":"坚持原创，只说真话，有节操有情怀的影视自媒体",
        "follow":false,
        "follower_count":0,
        "name":"Sir电影",
        "user_auth_info":{
            "auth_type":"0",
            "auth_info":"电影评论人"
        },
        "user_id":3348869475,
        "user_verified":true,
        "verified_content":"电影评论人"
    },
    "user_repin":0,
    "user_verified":1,
    "verified_content":"电影评论人",
    "video_detail_info":{
        "detail_video_large_image":{
            "height":326,
            "uri":"video1609/22d2000467f35aadaa6b",
            "url":"http://p1.pstatp.com/video1609/22d2000467f35aadaa6b",
            "url_list":[
                {
                    "url":"http://p1.pstatp.com/video1609/22d2000467f35aadaa6b"
                },
                {
                    "url":"http://pb3.pstatp.com/video1609/22d2000467f35aadaa6b"
                },
                {
                    "url":"http://pb9.pstatp.com/video1609/22d2000467f35aadaa6b"
                }
            ],
            "width":580
        },
        "direct_play":1,
        "group_flags":32832,
        "show_pgc_subscribe":1,
        "video_id":"a8ee6a1d75ef41b58d7ef3399af0b7fb",
        "video_preloading_flag":1,
        "video_type":0,
        "video_watch_count":476611,
        "video_watching_count":0
    },
    "video_duration":115,
    "video_id":"a8ee6a1d75ef41b58d7ef3399af0b7fb",
    "video_play_info":{
        "status":10,
        "message":"success",
        "video_duration":115.01,
        "validate":"0",
        "enable_ssl":false,
        "poster_url":"http://p3.pstatp.com/origin/23a7000ceff57a1da179",
        "original_play_url":{
            "backup_url":"http://voffline.pstatp.com/audit/m/79fa000003b6e47efe5f/",
            "main_url":"http://voffline.pstatp.com/audit/m/79fa000003b6e47efe5f/"
        },
        "video_list":{
            "video_1":{
                "definition":"360p",
                "vtype":"mp4",
                "vwidth":640,
                "vheight":360,
                "bitrate":22838,
                "logo_name":"",
                "coded_format":"h264",
                "size":1294364,
                "main_url":"aHR0cDovL3Y2LXR0Lml4aWd1YS5jb20vdmlkZW8vbS8yMjBhMzMyOThlYTI5ZmE0NmJkODI4ODZkYzBmNjZhZjNiZjExNDdiOTIwMDAwMGE2NDBhNGEwOTMyLz9FeHBpcmVzPTE1MDM0NzEyMjYmQVdTQWNjZXNzS2V5SWQ9cWgwaDlUZGNFTW9TMm9QajdhS1gmU2lnbmF0dXJlPU1UJTJGTFI3U3UxZ0Y1c1NSdU5EazlsVzdVUTVjJTNE",
                "backup_url_1":"aHR0cDovL3Y3LnBzdGF0cC5jb20vYWM4Yjk2YjViOTAzYWRiYzM4NDIwMTgwZjcwYTZlZWUvNTk5ZDE4NmEvdmlkZW8vbS8yMjBhMzMyOThlYTI5ZmE0NmJkODI4ODZkYzBmNjZhZjNiZjExNDdiOTIwMDAwMGE2NDBhNGEwOTMyLw==",
                "user_video_proxy":1,
                "socket_buffer":13702800,
                "preload_size":327680,
                "preload_interval":25,
                "preload_min_step":5,
                "preload_max_step":10
            },
            "video_2":{
                "definition":"480p",
                "vtype":"mp4",
                "vwidth":854,
                "vheight":480,
                "bitrate":33462,
                "logo_name":"",
                "coded_format":"h264",
                "size":1447708,
                "main_url":"aHR0cDovL3Y2LXR0Lml4aWd1YS5jb20vdmlkZW8vbS8yMjA2MGQ0NDRjNTVjMzU0YmU5OTU0Mzc1MWY4ZGQ0NWJhYTExNDdiNGYwMDAwMmNiYjczMjVlMDk1Lz9FeHBpcmVzPTE1MDM0NzEyMjYmQVdTQWNjZXNzS2V5SWQ9cWgwaDlUZGNFTW9TMm9QajdhS1gmU2lnbmF0dXJlPXhtaGFuT1I1JTJCNUxUSUpudnpuWFlCb1NPbHhVJTNE",
                "backup_url_1":"aHR0cDovL3Y3LnBzdGF0cC5jb20vNDI0MzM2NDA2MDNjMGY2ZDNlNTA4MzAxYjVjYjg2MzMvNTk5ZDE4NmEvdmlkZW8vbS8yMjA2MGQ0NDRjNTVjMzU0YmU5OTU0Mzc1MWY4ZGQ0NWJhYTExNDdiNGYwMDAwMmNiYjczMjVlMDk1Lw==",
                "user_video_proxy":1,
                "socket_buffer":20077200,
                "preload_size":327680,
                "preload_interval":25,
                "preload_min_step":5,
                "preload_max_step":10
            },
            "video_3":{
                "definition":"720p",
                "vtype":"mp4",
                "vwidth":1280,
                "vheight":720,
                "bitrate":78996,
                "logo_name":"",
                "coded_format":"h264",
                "size":2101077,
                "main_url":"aHR0cDovL3Y2LXR0Lml4aWd1YS5jb20vdmlkZW8vbS8yMjAxZmM1ZDNiZGIwMzg0OWU3YmM5ODFiMDhhYWY5NDQ1NjExNDdiNDMwMDAwMzc3MTU3ZGIzMTQ4Lz9FeHBpcmVzPTE1MDM0NzEyMjYmQVdTQWNjZXNzS2V5SWQ9cWgwaDlUZGNFTW9TMm9QajdhS1gmU2lnbmF0dXJlPU5WNEV3WFNWR1MwTm1WS1dFTWN5eWNXZ0VGdyUzRA==",
                "backup_url_1":"aHR0cDovL3Y3LnBzdGF0cC5jb20vZmViMzNkN2ZhNjBlNTA4ZTBiYjZhYzA2ZmQ5M2IxMDIvNTk5ZDE4NmEvdmlkZW8vbS8yMjAxZmM1ZDNiZGIwMzg0OWU3YmM5ODFiMDhhYWY5NDQ1NjExNDdiNDMwMDAwMzc3MTU3ZGIzMTQ4Lw==",
                "user_video_proxy":1,
                "socket_buffer":47397600,
                "preload_size":327680,
                "preload_interval":25,
                "preload_min_step":5,
                "preload_max_step":10
            }
        },
        "dns_info":{

        }
    },
    "video_style":8
}
```

#### 3.视频-广告-1

![](img/video/广告-视频-1.png)

返回数据示例：

```
{
    "abstract":"",
    "ad_id":64527492755,
    "allow_download":false,
    "app_name":"群雄逐鹿",
    "appleid":"1250335946",
    "article_sub_type":0,
    "article_type":0,
    "ban_comment":0,
    "behot_time":1503468170,
    "bury_count":0,
    "cell_flag":10,
    "cell_layout_style":1,
    "cell_type":10,
    "comment_count":0,
    "cursor":1503468170999,
    "description":"手机里惟一一个可以玩一辈子的游戏",
    "digg_count":0,
    "display_type":2,
    "download_url":"https://itunes.apple.com/cn/app/id1250335946",
    "expire_seconds":313549757,
    "filter_words":[
        {
            "id":"1:1",
            "is_selected":false,
            "name":"应用下载"
        },
        {
            "id":"1:65",
            "is_selected":false,
            "name":"移动游戏"
        },
        {
            "id":"1:224",
            "is_selected":false,
            "name":"经营策略"
        },
        {
            "id":"4:2",
            "is_selected":false,
            "name":"看过了"
        }
    ],
    "has_m3u8_video":false,
    "has_mp4_video":0,
    "has_video":false,
    "hot":0,
    "id":64527492755,
    "ignore_web_transform":1,
    "image":{
        "height":450,
        "uri":"32f1000afea86a12e55c",
        "url":"http://p3.pstatp.com/origin/32f1000afea86a12e55c",
        "url_list":[
            {
                "url":"http://p3.pstatp.com/origin/32f1000afea86a12e55c"
            }
        ],
        "width":800
    },
    "is_subject":false,
    "item_version":0,
    "label":"广告",
    "label_style":3,
    "level":0,
    "log_extra":{
        "rit":1,
        "convert_id":64468219313,
        "req_id":"20170823140254010008035070132CF0",
        "ad_price":"WZwbPgAAZAJZnBs-AABkAplUjxSKO2KUV6Nf-g"
    },
    "log_pb":{
        "impr_id":"20170823140254010008035070132CF0"
    },
    "rate":-1,
    "raw_ad_data":{

    },
    "read_count":0,
    "rid":"20170823140254010008035070132CF0",
    "share_count":0,
    "show_portrait":false,
    "show_portrait_article":false,
    "source_icon_style":3,
    "sub_title":"经典三国游戏手机版",
    "tip":0,
    "title":"手机里惟一一个可以玩一辈子的游戏",
    "type":"app",
    "user_repin":0,
    "user_verified":0,
    "verified_content":"",
    "video_channel_ad_type":1,
    "video_style":0
}
```

#### 4.视频-广告-2

![](img/video/广告-视频-2.png)

返回数据示例：

```

    "abstract":"国外ios单日下载排名前列！惊爆全球的手游！",
    "action_list":[
        {
            "action":1,
            "desc":"",
            "extra":{

            }
        },
        {
            "action":3,
            "desc":"",
            "extra":{

            }
        },
        {
            "action":7,
            "desc":"",
            "extra":{

            }
        },
        {
            "action":9,
            "desc":"",
            "extra":{

            }
        }
    ],
    "ad_button":{
        "app_name":"狂暴之翼3D",
        "appleid":"1112060888",
        "button_text":"点击下载",
        "click_track_url":"",
        "description":"国外ios单日下载排名前列！惊爆全球的手游！",
        "display_type":1,
        "download_url":"https://itunes.apple.com/cn/app/kuang-bao-zhi-yi-3d-xuan-zhanarpg/id1112060888?l=zh\u0026ls=1\u0026mt=8",
        "hide_if_exists":0,
        "id":62917878859,
        "open_url":"",
        "package":"",
        "source":"狂暴之翼3D",
        "track_url":"",
        "type":"app",
        "ui_type":1,
        "web_title":"狂暴之翼3D",
        "web_url":"http://api.snssdk.com/2/ad/62917878859/"
    },
    "ad_id":62917878859,
    "ad_label":"广告",
    "aggr_type":1,
    "allow_download":false,
    "article_sub_type":0,
    "article_type":0,
    "article_url":"http://toutiao.com/item/6438821830684836097/",
    "ban_comment":0,
    "behot_time":1503468535,
    "bury_count":23,
    "cell_flag":74,
    "cell_layout_style":1,
    "cell_type":0,
    "comment_count":0,
    "cursor":1503468535999,
    "digg_count":10,
    "display_url":"http://toutiao.com/item/6438821830684836097/",
    "expire_seconds":310875955,
    "filter_words":[
        {
            "id":"1:1",
            "is_selected":false,
            "name":"应用下载"
        },
        {
            "id":"1:65",
            "is_selected":false,
            "name":"移动游戏"
        },
        {
            "id":"1:223",
            "is_selected":false,
            "name":"角色扮演"
        },
        {
            "id":"4:2",
            "is_selected":false,
            "name":"看过了"
        }
    ],
    "forward_info":{
        "forward_count":0
    },
    "group_flags":36928,
    "group_id":6438821830684836000,
    "has_m3u8_video":false,
    "has_mp4_video":0,
    "has_video":true,
    "hot":0,
    "ignore_web_transform":1,
    "is_subject":false,
    "item_id":6438821830684836000,
    "item_version":0,
    "label":"广告",
    "label_style":3,
    "large_image_list":[
        {
            "height":360,
            "uri":"large/2e69000da191d307dcb3",
            "url":"http://p3.pstatp.com/large/w640/2e69000da191d307dcb3.webp",
            "url_list":[
                {
                    "url":"http://p3.pstatp.com/large/w640/2e69000da191d307dcb3.webp"
                },
                {
                    "url":"http://pb9.pstatp.com/large/w640/2e69000da191d307dcb3.webp"
                },
                {
                    "url":"http://pb1.pstatp.com/large/w640/2e69000da191d307dcb3.webp"
                }
            ],
            "width":640
        }
    ],
    "level":0,
    "like_count":10,
    "log_extra":{
        "rit":1,
        "convert_id":59455794478,
        "req_id":"20170823140904010008071166144F33",
        "ad_price":"WZwa4AAOQJ5ZnBrgAA5Anm3Q6TVhTN_Xg1Q9GQ"
    },
    "log_pb":{
        "impr_id":"20170823140904010008071166144F33"
    },
    "natant_level":2,
    "publish_time":1499155031,
    "raw_ad_data":{

    },
    "read_count":206231,
    "repin_count":22,
    "rid":"20170823140904010008071166144F33",
    "share_count":31,
    "share_url":"http://toutiao.com/a6438821830684836097/?iid=13142832814\u0026app=news_article",
    "show_portrait":false,
    "show_portrait_article":false,
    "source":"狂暴之翼3D",
    "source_icon_style":3,
    "source_open_url":"sslocal://search?from=channel_source\u0026keyword=%E7%8B%82%E6%9A%B4%E4%B9%8B%E7%BF%BC3D",
    "tag":"ad",
    "tag_id":6438821830684836000,
    "tip":0,
    "title":"国外ios单日下载排名前列！惊爆全球的手游！",
    "ugc_recommend":{
        "activity":"",
        "reason":""
    },
    "url":"http://toutiao.com/item/6438821830684836097/",
    "user_repin":0,
    "user_verified":0,
    "verified_content":"",
    "video_detail_info":{
        "detail_video_large_image":{
            "height":326,
            "uri":"video1609/2b980002fc24308d9ada",
            "url":"http://p3.pstatp.com/video1609/2b980002fc24308d9ada",
            "url_list":[
                {
                    "url":"http://p3.pstatp.com/video1609/2b980002fc24308d9ada"
                },
                {
                    "url":"http://pb9.pstatp.com/video1609/2b980002fc24308d9ada"
                },
                {
                    "url":"http://pb1.pstatp.com/video1609/2b980002fc24308d9ada"
                }
            ],
            "width":580
        },
        "direct_play":1,
        "group_flags":36928,
        "show_pgc_subscribe":1,
        "video_id":"dbf24bf46d5241bf9d231b6b25593bd7",
        "video_preloading_flag":1,
        "video_type":0,
        "video_watch_count":191308,
        "video_watching_count":0
    },
    "video_duration":15,
    "video_id":"dbf24bf46d5241bf9d231b6b25593bd7",
    "video_style":8
}
```