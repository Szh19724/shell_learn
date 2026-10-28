# 第3章 课后作业 Makefile
# 用法：make        编译
#       make test   用样例跑一遍
#       make clean  清理

CC     := gcc
CFLAGS := -Wall -Wextra -O2

TARGET := match_url
SRC    := match_url.c

all: $(TARGET)

$(TARGET): $(SRC)
	$(CC) $(CFLAGS) -o $@ $<

test: $(TARGET)
	@echo "--- 应命中 3 个网址 ---"
	./$(TARGET) "官网 www.example.site.com/cn/index，镜像 www.mirror-org.net/cn/download，文档 www.docs.example.io/cn/api/v2"
	@echo "--- 只有域名/路径不对/不是www开头 → 应无匹配（退出码 2）---"
	-./$(TARGET) "只有域名 www.example.site.com 英文路径 www.example.site.com/en/index 非www home.example.site.com/cn/index" ; true

clean:
	rm -f $(TARGET)

.PHONY: all test clean
