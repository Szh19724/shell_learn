#!/usr/bin/env bash
# =============================================================================
# 第3章 正则表达式 · 练习3：匹配网址（课后作业的 shell 热身版）
#
# 作业原文：编写一个 C 程序，匹配字符串中的网址 www.xxxxxx.xxx.com/cn/xyz
# 这里先用 grep/sed 把规则写熟，再去写 C 版本（match_url.c）。
#
# 用法：
#   1. 把每题 cmd='___' 中的 ___ 换成你的命令
#   2. 运行：bash 03-网址匹配练习.sh
#
# 演示模式：bash 03-网址匹配练习.sh --demo
# =============================================================================

USE_ANSWER=0
[ "${1:-}" = "--demo" ] && USE_ANSWER=1

pass=0; fail=0; skip=0

TEXT=$(cat <<'EOF'
公司主页：www.example.site.com/cn/index
镜像站：www.mirror-org.net/cn/download
文档：www.docs.example.io/cn/api/v2
只有域名没有路径：www.example.site.com
英文路径：www.example.site.com/en/index
非 www 开头：home.example.site.com/cn/index
ftp 下载：ftp://files.example.com/cn/xyz
干扰项：IP 192.168.31.1、端口 8080、时间 08:15:01
EOF
)

# 网址规则（ERE）：
#   www\.                 固定前缀 www.
#   [A-Za-z0-9-]+         一段主机名（字母/数字/连字符，如 example、mirror-org）
#   (\.[A-Za-z0-9-]+)+    再来至少一段（如 .site.com）
#   /cn(/[A-Za-z0-9-]+)+  /cn 开头的路径，至少一级（如 /cn/index、/cn/api/v2）
# 若要求 www 后必须三段域名（www.xxxxxx.xxx.com），把 + 写成 {2,}
URL_RE='www\.[A-Za-z0-9-]+(\.[A-Za-z0-9-]+)+/cn(/[A-Za-z0-9-]+)+'

norm() {
    printf '%s\n' "$1" | sed -e 's/[[:space:]]\{1,\}/ /g' -e 's/^ //' -e 's/ $//'
}

# 判题函数：
#   run "题目描述" "你的命令" "参考命令" "期望输出"
run() {
    local desc="$1" cmd="$2" ans="$3" expected="$4"
    [ "$USE_ANSWER" = 1 ] && cmd="$ans"
    if [ -z "$cmd" ] || [ "$cmd" = "___" ]; then
        echo "[未作答] $desc"
        echo "         参考命令: $ans"
        skip=$((skip + 1))
        return
    fi
    local actual
    actual=$(eval "$cmd" 2>&1)
    if [ "$(norm "$actual")" = "$(norm "$expected")" ]; then
        echo "[通过] $desc"
        pass=$((pass + 1))
    else
        echo "[失败] $desc"
        echo "       你的输出: $(norm "$actual" | head -5 | tr '\n' '|')"
        echo "       期望输出: $(norm "$expected" | tr '\n' '|')"
        echo "       参考命令: $ans"
        fail=$((fail + 1))
    fi
}

echo "===== 练习3：匹配网址（作业热身） ====="
echo "----- 样例文本 -----"
printf '%s\n' "$TEXT"
echo "--------------------"

# ---------------------------------------------------------------------------
# 练习1：用 grep -oE 提取所有网址
# 参考答案: printf '%s\n' "$TEXT" | grep -oE "$URL_RE"
# ---------------------------------------------------------------------------
cmd='___'
run "1.1 提取样例文本里所有网址（应得到 3 个）" "$cmd" \
    'printf "%s\n" "$TEXT" | grep -oE "$URL_RE"' \
    'www.example.site.com/cn/index
www.mirror-org.net/cn/download
www.docs.example.io/cn/api/v2'

# ---------------------------------------------------------------------------
# 练习2：数一数有几个网址（grep -o | wc -l）
# 参考答案: printf '%s\n' "$TEXT" | grep -oE "$URL_RE" | wc -l
# ---------------------------------------------------------------------------
cmd='___'
run "2.1 统计网址个数" "$cmd" \
    'printf "%s\n" "$TEXT" | grep -oE "$URL_RE" | wc -l' \
    '3'

# ---------------------------------------------------------------------------
# 练习3：只打印"含有网址"的行号（grep -n，再用 cut 取冒号前面）
# 参考答案: printf '%s\n' "$TEXT" | grep -nE "$URL_RE" | cut -d: -f1
# 负面样本说明：
#   第4行只有域名没有 /cn/ 路径   → 不算
#   第5行路径是 /en/ 不是 /cn/    → 不算
#   第6行不是 www. 开头           → 不算
#   第7行是 ftp:// 不是 www.      → 不算
# ---------------------------------------------------------------------------
cmd='___'
run "3.1 打印含网址的行号（1、2、3）" "$cmd" \
    'printf "%s\n" "$TEXT" | grep -nE "$URL_RE" | cut -d: -f1' \
    '1
2
3'

# ---------------------------------------------------------------------------
# 练习4：用 sed 把网址统一替换成 [LINK]，再数一数替换了几行
# 参考答案: printf '%s\n' "$TEXT" | sed -E "s@$URL_RE@[LINK]@g" | grep -c '\[LINK\]'
# ---------------------------------------------------------------------------
cmd='___'
run "4.1 把网址替换成 [LINK] 后，含 [LINK] 的行数应为 3" "$cmd" \
    'printf "%s\n" "$TEXT" | sed -E "s@$URL_RE@[LINK]@g" | grep -c "\[LINK\]"' \
    '3'

echo "----------------------------------------"
echo "通过 $pass，失败 $fail，未作答 $skip"
[ "$fail" -gt 0 ] && exit 1
exit 0
