# drone-lftp

drone插件，用于服务器间文件传输

## Feature
- []支持源文件使用通配符模式.
- []支持将文件发送到多个主机.
- []支持将文件夹发送到多个主机上的多个目标文件夹.
- []支持ssh-key和绝对路径上加载key

## e.g. 推荐配置
```
pipeline:
  deploy:
    image: cschlosser/drone-ftps
    secrets: [ LFTP_HOST, LFTP_PORT, LFTP_USERNAME, LFTP_PASSWORD, LFTP_TARGET ]
    source:　/mysite
```
## e.g. 全功能配置
```
pipeline:
  deploy:
    image: zero/drone-sftp
    host: example.com:21
    username: drone
    # 多种模式可选，默认为sftp；[ ftp, sftp, http, https, hftp ]
    mode: sftp
    # 目标路径
    target: /www/mysite
    # 源文件路径
    source: /mysite
    # 忽略的文件or目录，可使用通配符
    exclude:
      - ^\.git/$
      - ^\.gitignore$
      - ^\.drone.yml$
    # 上传的文件or目录，可使用通配符
    include:
      - ^*.css$
      - ^*.js$
      - ^*.html$
```
## secret
```
// ip
LFTP_HOST
// 端口
LFTP_PORT
// 用户名
LFTP_USERNAME
// 密码
LFTP_PASSWORD
// 目标路径
LFTP_TARGET
```

## test
```
$ make test
```

## build
构建docker镜像
```
$ make docker
```

## 相关文献
[lftp操作](http://fedoralog.blog.sohu.com/30894375.html)