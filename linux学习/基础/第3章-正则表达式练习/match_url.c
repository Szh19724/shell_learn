/*
 * 第3章 课后作业：编写一个 C 程序，匹配字符串中的网址
 * 目标格式：www.xxxxxx.xxx.com/cn/xyz
 *
 * 编译：gcc -Wall -Wextra -o match_url match_url.c
 * 运行：./match_url "文本里有 www.example.site.com/cn/index 这样的网址"
 *       ./match_url < some.txt          （从标准输入读取，支持多行）
 *
 * 涉及本章的 POSIX 正则 API（<regex.h>）：
 *   regcomp   编译正则表达式
 *   regexec   执行匹配
 *   regerror  把错误码解析成错误信息
 *   regfree   释放编译后的正则
 *
 * 返回值：0=找到网址，2=没找到，1=出错
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <regex.h>

/*
 * 网址规则（ERE，配合 REG_EXTENDED）：
 *   www\.                  固定前缀 www.
 *   [A-Za-z0-9-]+          一段主机名（字母/数字/连字符）
 *   (\.[A-Za-z0-9-]+)+     再来至少一段，如 .site.com
 *   /cn(/[A-Za-z0-9-]+)+   /cn 开头的路径，至少一级，如 /cn/xyz、/cn/api/v2
 *
 * 若要求 www 后必须是"三段"域名（www.xxxxxx.xxx.com），
 * 把 (\\.[A-Za-z0-9-]+)+ 改成 (\\.[A-Za-z0-9-]+){2,} 即可。
 */
#define URL_PATTERN "www\\.[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)+/cn(/[A-Za-z0-9-]+)+"

/* 把 regcomp/regexec 的错误码解析成可读的错误信息 */
static void print_regerror(const char *stage, int errcode, const regex_t *preg)
{
    char errbuf[256];
    regerror(errcode, preg, errbuf, sizeof errbuf);
    fprintf(stderr, "%s 失败：%s\n", stage, errbuf);
}

/* 一次性把 fp（通常是 stdin）的全部内容读进内存，返回的字符串需 free */
static char *read_all(FILE *fp)
{
    size_t cap = 256, len = 0;
    char *buf = malloc(cap);
    if (buf == NULL)
        return NULL;
    for (;;) {
        if (len + 1 >= cap) {              /* 空间不够就翻倍 */
            char *tmp = realloc(buf, cap * 2);
            if (tmp == NULL) {
                free(buf);
                return NULL;
            }
            buf = tmp;
            cap *= 2;
        }
        size_t n = fread(buf + len, 1, cap - len - 1, fp);
        len += n;
        if (n == 0)                        /* EOF 或读取出错 */
            break;
    }
    buf[len] = '\0';
    return buf;
}

int main(int argc, char *argv[])
{
    regex_t preg;
    regmatch_t match[1];        /* 只有 1 个模式（没有子模式），所以数组大小为 1 */
    char *text = NULL;
    const char *cur;
    int ret, count = 0;

    /* 1. 编译：REG_EXTENDED 表示使用扩展正则语法（+ * ? { } ( ) 直接用） */
    ret = regcomp(&preg, URL_PATTERN, REG_EXTENDED);
    if (ret != 0) {
        print_regerror("regcomp", ret, &preg);
        return 1;               /* 编译失败，preg 不能 regfree */
    }

    /* 2. 准备母串：有命令行参数就拼接参数，否则读标准输入 */
    if (argc > 1) {
        size_t need = 1;
        for (int i = 1; i < argc; i++)
            need += strlen(argv[i]) + 1;
        text = malloc(need);
        if (text != NULL) {
            text[0] = '\0';
            for (int i = 1; i < argc; i++) {
                strcat(text, argv[i]);
                if (i + 1 < argc)
                    strcat(text, " ");
            }
        }
    } else {
        text = read_all(stdin);
    }
    if (text == NULL) {
        perror("malloc");
        regfree(&preg);
        return 1;
    }

    /*
     * 3. 循环匹配：regexec 默认从字符串任意位置找（不是从行首找）。
     *    每次命中后把游标移到本次匹配的结尾，继续向后找，
     *    这样可以找出母串中所有的网址。
     *    match[0] 是整个模式的匹配范围（rm_so 起始下标 ~ rm_eo 结束下标），
     *    match[0].rm_so/rm_eo 都是"相对当前游标 cur 的偏移"。
     */
    cur = text;
    while (*cur != '\0' && regexec(&preg, cur, 1, match, 0) == 0) {
        printf("匹配到网址: %.*s   (偏移: %ld)\n",
               (int)(match[0].rm_eo - match[0].rm_so),
               cur + match[0].rm_so,
               (long)match[0].rm_so);
        cur += match[0].rm_eo;
        if (match[0].rm_eo <= 0)        /* 防御：零长度匹配时至少前进 1 字节 */
            cur++;
        count++;
    }

    if (count == 0)
        printf("没有找到符合条件的网址\n");
    else
        printf("共找到 %d 个网址\n", count);

    /* 4. 清理：先释放母串，再 regfree 释放编译后的正则 */
    free(text);
    regfree(&preg);
    return count > 0 ? 0 : 2;
}
