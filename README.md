# drone-lftp

drone插件，用于服务器间文件传输

## Feature
- []支持源文件路径使用通配符模式.
- []支持将文件发送到多个主机.
- []支持将文件夹发送到多个主机上的多个目标文件夹.
- []支持ssh-key和绝对路径上加载key
- []指定上传一组文件or目录
- []指定忽略上传一组文件or目录

## e.g. 推荐配置
```
pipeline:
  deploy:
    image: cschlosser/drone-ftps
    secrets: [ LFTP_HOST, LFTP_PORT, LFTP_USERNAME, LFTP_PASSWORD, LFTP_TARGET ]
    source:　dist
```
## e.g. 全功能配置
```
pipeline:
  deploy:
    image: zero/drone-sftp
    host: example.com
    port: 21
    username: drone
    # 多种模式可选，默认为sftp；[ ftp, sftp, http, https, hftp ]
    mode: sftp
    # 源文件路径，默认为当前目录
    source: dist
    # 目标路径，必须为绝对路径
    target: /www/mysite
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
// ip or domain
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
$ docker run --rm \
  -e LFTP_DEBUG=true \
  -e LFTP_HOST=127.0.0.1 \
  -e LFTP_PORT=22 \
  -e LFTP_USERNAME=root \
  -e LFTP_PASSWORD=password \
  -e LFTP_SOURCE=test/dist \
  -e LFTP_TARGET=/www/dist \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  zero/drone-lftp
```

## build
构建docker镜像
```
$ make docker
```

## 相关文献
[drone官方插件demo](http://docs.drone.io/creating-custom-plugins-bash/)
[lftp操作](http://fedoralog.blog.sohu.com/30894375.html)
[基本操作](https://www.cnblogs.com/LJ-fish/archive/2010/03/15/1686607.html)
[增量备份](http://www.169it.com/blog_article/766419848.html)

[drone-scp](https://github.com/appleboy/drone-scp)
[drone-ftps](https://github.com/christophschlosser/drone-ftps)
