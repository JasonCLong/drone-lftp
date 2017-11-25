# drone-sftp

drone插件，用于ssh传输文件

## Feature
- []Support wildcard pattern on source list.
- []Support send files to multiple host.
- []Support send files to multiple target folder on host.
- []Support load ssh key from absolute path or raw body.

## e.g. 推荐配置
```
pipeline:
  deploy:
    image: cschlosser/drone-ftps
    secrets: [ SFTP_HOST, SFTP_PORT, SFTP_USERNAME, SFTP_PASSWORD, SFTP_DEST_DIR ]
    src_dir:　/mysite
```
## e.g. 全功能配置
```
pipeline:
  deploy:
    image: zero/drone-sftp
    host: example.com:21
    username: drone
    secure: true
    // 目标路径
    dest_dir: /www/mysite
    // 源文件路径
    src_dir: /mysite
    // 忽略的文件or目录，可使用通配符
    exclude:
      - ^\.git/$
      - ^\.gitignore$
      - ^\.drone.yml$
    // 上传的文件or目录，可使用通配符
    include:
      - ^*.css$
      - ^*.js$
      - ^*.html$
```
## secret
// ip
SFTP_HOST
// 端口
SFTP_PORT
// 用户名
SFTP_USERNAME
// 密码
SFTP_PASSWORD
// 目标路径
SFTP_DEST_DIR

## test
```
$ make test
```

## build
构建docker镜像
```
$ make docker
```