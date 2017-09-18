#coding:utf-8
import urlparse
import random
import binascii

def right_shift(val, n): # 校验出来的值可能小于 0
    return val >> n if val >= 0 else (val + 0x100000000) >> n

video_id = '36dacfe510cb470c83e57ac88b38ba0b'
url = 'http://i.snssdk.com/video/urls/v/1/toutiao/mp4/%s' % video_id # 需要处理的 url
r = str(random.random())[2:] # 随机数可以不做处理
#r = str(random.random()) # 这样写也可以
# 获取
n = urlparse.urlparse(url).path + '?r=' + r
c = binascii.crc32(n)
s = right_shift(c, 0)

print 'url+' + url
print 'r=' + r
print 'n=' + n
print 'c=' + str(c)
print 's=' + str(c)

real_url = 'http://i.snssdk.com/video/urls/v/1/toutiao/mp4/' + video_id + '?r=' + r + '&s='+ str(s)

print 'real_url=' + real_url

