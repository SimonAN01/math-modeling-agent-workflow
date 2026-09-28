#!/usr/bin/env bash
# 编译论文。
# 编译链照抄官方模板的 makefiles.sh：xelatex -> bibtex -> xelatex -> xelatex
#   - bibtex 那一趟是必需的：参考文献走 \bibliographystyle{gmcm} + \bibliography{reference}，
#     漏掉 bibtex 就不会生成 main.bbl，正文引用会全部变成 [?]。
#   - 最后两趟 xelatex 用于收殓目录、交叉引用和参考文献编号。
set -euo pipefail
cd "$(dirname "$0")/paper"

xelatex -interaction=nonstopmode main.tex > /tmp/paper_pass1.log 2>&1 || true
bibtex main > /tmp/paper_bibtex.log 2>&1 || true
xelatex -interaction=nonstopmode main.tex > /tmp/paper_pass2.log 2>&1 || true
xelatex -interaction=nonstopmode main.tex > /tmp/paper_pass3.log 2>&1 || true

if grep -qE "^! " /tmp/paper_pass3.log; then
  echo "编译有错误："
  grep -E "^! " /tmp/paper_pass3.log | head -10
  exit 1
fi

# 引用未解析（[?]）是静默失败，必须显式报警
if grep -qE "Citation .* undefined" /tmp/paper_pass3.log; then
  echo "警告：有未解析的引用（会渲染成 [?]）——检查 main.bbl 是否生成、\\cite 的键是否存在于 reference.bib"
  grep -E "Citation .* undefined" /tmp/paper_pass3.log | sort -u | head -10
fi

if grep -qE "Empty bibliography|I found no \\\\citation" /tmp/paper_bibtex.log; then
  echo "提示：本次没有任何 \\cite，参考文献为空。"
fi

echo "编译成功 -> $(pwd)/main.pdf"
