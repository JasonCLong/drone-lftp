test: main.sh
	docker run --rm \
  -e SFCP_HOST example.com \
  -e SFCP_PORT 22 \
  -e SFCP_USERNAME xxxxxxx \
  -e SFCP_PASSWORD "xxxxxxx"
  -e SFCP_SRC SOURCE_FILE_LIST \
  -e SFCP_DEST TARGET_FOLDER_PATH \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  zero/drone-sfcp

build: Dockerfile
	docker build -t drone-sftp:1.0 .
