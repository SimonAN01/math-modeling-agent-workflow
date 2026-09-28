---
allowed-tools: Bash(*), Read, Write, Edit, Grep, Glob, Agent, WebSearch, WebFetch

name: 5writing
description: "数学建模竞赛论文撰写阶段，支持 Typst 和 LaTeX 双引擎。根据 ANALYSIS_MODELING_REPORT.md、RESULTS_REPORT.md 和 figures/*.pdf 选择比赛模板、排版引擎、组织章节，并在论文正文中按章节直接插入图表。"
---

# 竞赛论文撰写（Typst / LaTeX）

本 skill 承接 `3coding-visual` 和 `4drawio`。前序阶段只提供真实数据、图表 PDF 和记录文件；本阶段负责选择比赛模板和排版引擎、组织论文结构，并决定每张图表放入哪个章节。

## 写作专项检查

先从 `RESULTS_REPORT.md` 和 `reports/CLAIM_EVIDENCE_LEDGER.md` 确定可写的主张，再安排图表和章节。图表、公式与正文衔接按 `../math-modeling-text-object-integration/SKILL.md` 检查；三线表按 `../math-modeling-three-line-tables/SKILL.md` 检查类型、列设计、统计口径和最佳值标记；全文叙事按 `../paper-launch-polish/SKILL.md` 检查核心贡献、证据与局限。只加载当前确实需要的专项技能，不为了套用模板改动事实、数值或比赛格式。

写作修改涉及模型结论或数值时，先回到结果记录核对，更新受影响的证据台账和图表计划。摘要在正文与结果稳定后反写。

**Typst 引擎**下可调用 typst-author skill 学习 typst 写法；**LaTeX 引擎**参考本文件末尾的"LaTeX 写作要点"小节。

## 数学建模规范参考

如需领域判断，读取 `../_references/math_modeling_norms.md` 中的“论文写作”“图表与可视化”和“非数据图工具选择”小节。该文件只作为规范知识库，论文结构仍按比赛模板和当前赛题内容决定。

## 指定模板优先与版式对齐

用户指定的模板优先于本技能内置模板和通用格式建议。沿用现有工程时先比较原模板 `.cls/.sty`、主文件及示例 PDF，不重新初始化项目或覆盖用户内容。

1. 在 `plan.md` 记录模板绝对路径及用户例外要求。对比文本时先消除换行符差异，核对实际生效的中文/西文字体、字号、行距、段间距、标题间距、页边距和摘要环境。特别检查主文件中的 `\linespread`、`\setstretch`、`\fontsize` 是否覆盖类文件。
2. 不得为了把摘要塞进一页、凑足正文页数或未经核实的格式说法改变这些参数。用户允许摘要跨页时自然分页；摘要篇幅由方法和结果的完整性决定，不靠缩字号或空泛扩写调整。页数分别统计，不把整篇 PDF 当作正文。
3. 缺失字体时检索本地真实文件并核对字体内部 family/PostScript 名称；需要下载时保留来源和校验值。`fc-match` 返回替代字体不等于所需字体存在，例如 Noto Sans Lisu 不是中文隶书 LiSu。严格对齐时必须解决真实字体依赖，不得静默使用楷体替代隶书。缺字未解决须如实标记未完成，仍可继续独立的内容修订。
4. 尽量保持原版类文件不变；必要兼容处理放在工程主文件中并记录差异。编译后检查 PDF 嵌入字体和摘要、正文、标题样页，不能仅以编译成功判断一致。
5. 合并过细标题时先检查模板的 `\paragraph` 定义。它可能是行内标题，不能直接用来实现独立占行的小标题；对标题尾字与正文首字的间距进行 PDF 目视检查。需要独立段首提示时使用不编号、独立占行的加粗标题，在项目中明确定义换行，不擅改原版类文件。统一检查标题尾字与正文首字的粘连、重叠及异常断行，并避免标题孤立在页底；抽查代表性 PDF 样页后才标记排版完成。
6. 将模板对比、确有必要的例外和验收结果写入项目报告。编译日志写入项目专用目录，不使用多个项目共用的固定 `/tmp/paper_pass*.log`，避免读取其他论文日志造成误判。

## 提交 PDF 文件名

数学建模竞赛提交 PDF 按“题号＋队伍编号”命名：`<A–F 大写题号><队伍编号>.pdf`，例如 `C26000010001.pdf`。从用户已提供的信息或项目报名信息确定题号、队伍编号，记录到 `plan.md`；缺失时不编造。编译脚本的最终输出、提交目录和打包入口使用同一名称，不将 `main.pdf`、`论文.pdf` 作为交付文件。LaTeX 使用 `-jobname` 时，BibTeX 同步使用该 jobname；Typst 直接指定输出路径。保留主源文件名不影响交付命名。新项目若有用户明确指定的不同命名要求，按其要求执行。

## 模板族

本技能内捆绑的模板位于：

```text
templates/zh/<竞赛>/main.typ         # Typst 模板
templates/zh/<竞赛>-latex/main.tex   # LaTeX 模板
templates/en/<竞赛>/main.typ         # Typst 模板
templates/en/<竞赛>-latex/main.tex   # LaTeX 模板
```

**LaTeX 模板覆盖范围**：所有中文模板和英文模板均已提供 LaTeX 版本（`-latex` 后缀），使用 xelatex 编译。

支持的中文模板（Typst + LaTeX 双版本）：

```text
apmcm, changsanjiao, cumcm, default, diangongbei, dongsansheng,
huashubei, huaweibei, huazhongbei, mathorcup, mcm, shuweibei, stats, wuyibei
```

华为杯、华中杯、五一杯统一使用 `huaweibei`、`huazhongbei`、`wuyibei` 作为模板。

支持的英文模板（Typst + LaTeX 双版本）：

```text
apmcm, default, mcm
```

论文中的所有数值图表结论必须来自 `reports/RESULTS_REPORT.md` 或 `figures/*`。不得编造、估算或使用不同的四舍五入方式。


## 工作流

### 步骤 0：确定排版引擎

**撰写论文前必须让用户选择排版引擎。** 引擎决定后续所有步骤（模板路径、章节文件扩展名、图片插入语法、编译命令），选错会导致整篇论文格式错误。

使用当前智能体平台的交互提问能力向用户询问：“撰写论文使用哪种排版引擎？”

- 选项 1：LaTeX（xelatex 编译，数学建模竞赛主流，模板已全部就绪）— 推荐选项放第一位
- 选项 2：Typst（typst 编译；平台有对应 Typst 专项能力时再调用）

询问前先读取 `plan.md` 的"用户偏好 → 排版引擎"字段作为预选项：
- 若 plan.md 已记录引擎选择，直接沿用；仅当用户提出新要求或现有项目文件与记录冲突时再询问。
- 若 plan.md 不存在或未记录引擎选择，直接询问用户选择。
- 若用户未明确指定或跳过，**默认使用 LaTeX**。

根据确定的引擎选择对应模板族：

- **Typst 引擎**：使用 `templates/<lang>/<竞赛>/main.typ`；平台有对应 Typst 专项能力时调用。编译命令 `typst compile main.typ`。
- **LaTeX 引擎**：使用 `templates/<lang>/<竞赛>-latex/main.tex`，xelatex 编译（中文和英文均需跑两遍解决交叉引用）。编译命令 `xelatex -interaction=nonstopmode main.tex`（执行两次）。
  模板自带 `compile.sh` 就直接用它。**若模板带 `.bst` + `.bib`（华为杯即如此），必须走四趟
  `xelatex → bibtex → xelatex → xelatex`**，漏掉 bibtex 那趟引用会静默变成 `[?]`，
  而 xelatex 不报错。

**后续步骤中的所有代码示例、文件扩展名、图片插入语法都必须按所选引擎选择对应版本，不要混用。**

### 步骤 1：选择语言和模板


除非用户明确要求中文，否则 MCM/ICM/COMAP 一律使用英文。所有中文竞赛名称使用中文。

模板键示例（Typst 引擎）：

```text
长三角 -> zh/changsanjiao
APMCM 英文版 -> en/apmcm
全国赛/国赛/CUMCM -> zh/cumcm
统计建模 -> zh/stats
MCM/ICM/COMAP -> en/mcm
```

模板键示例（LaTeX 引擎）：

```text
全国赛/国赛/CUMCM -> zh/cumcm-latex
MCM/ICM/COMAP -> en/mcm-latex
```

### 步骤 2：准备模板

用以下命令检查捆绑模板是否可访问（`SKILL_DIR` 为本 skill 所在目录）：

**Typst 模板**：

```bash
ls "$SKILL_DIR/templates/zh/<竞赛>/main.typ" 2>/dev/null && echo "OK" || echo "MISSING"
```

- **文件存在（OK）**：直接将 `templates/zh/<竞赛>/` 整目录复制到 `paper/`。这些模板是自包含入口文件，不依赖额外共享样式文件。
- **文件不存在（MISSING）**：说明 skill 未完整安装或在沙箱中，此时依照本 SKILL.md 步骤 3 列出的对应节文件结构，从零重建最小可编译 Typst 框架，并在 `paper/` 内注明"重建自 default 结构"。

用户未指定模板时，存在匹配的内置模板则不从零重建；用户指定模板时，按上面的版式对齐约定执行。

**LaTeX 模板**：

```bash
ls "$SKILL_DIR/templates/zh/<竞赛>-latex/main.tex" 2>/dev/null && echo "OK" || echo "MISSING"
```

- **文件存在（OK）**：将 `templates/zh/<竞赛>-latex/` 整目录复制到 `paper/`。
- **文件不存在（MISSING）**：说明 skill 未完整安装或在沙箱中，此时依照本 SKILL.md 步骤 3 列出的对应节文件结构，从零重建最小可编译 LaTeX 框架，并在 `paper/` 内注明"重建自 default-latex 结构"。


### 步骤 3：构建图表规划

在写正文各节之前，根据 `figures/*.pdf`、`reports/RESULTS_REPORT.md`，以及 `reports/DRAWIO_REPORT.md`（如果存在）构建图表规划：

```text
图表规划
fig_roadmap.pdf -> 引言/问题重述
fig_flow_q1.pdf -> 问题一模型构建
fig_flow_q2.pdf -> 问题二模型构建
fig_pipeline.pdf -> 数据预处理/方法节
结果图 -> 对应的结果节
```

**图片路径的基准，两种引擎完全不同 —— 这是最容易写错的地方。**

- **Typst**：相对**写出该行的文件**解析。`paper/main.typ` 里写 `../figures/xxx.pdf`，
  `paper/sections/*.typ` 里写 `../../figures/xxx.pdf`。
- **LaTeX**：`\includegraphics` 的路径相对**主文件 `main.tex` 所在目录**解析，
  **与写出该行的 section 文件无关**。所以在 `paper/sections/*.tex` 里也要按 `main.tex`
  的位置算路径，**不能**照搬 Typst 的 `../../figures/`。

LaTeX 更稳妥的做法是在 `main.tex` 里设好搜索前缀，各 section 里只写裸文件名：

```latex
% main.tex
\graphicspath{{figures/}{../figures/}{../../figures/}}
```

```latex
% paper/sections/5_problem1.tex —— 只写裸文件名
\begin{figure}[H]
  \centering
  \includegraphics[width=0.85\textwidth]{fig_q1_error_dist.pdf}
  \caption{问题一预测误差分布}
  \label{fig:q1_error}
\end{figure}
```

> **实测警告**：`\includegraphics{../../figures/xxx.pdf}` 在「`paper/` + 项目根 `figures/`」
> 这种布局下**会碰巧成功**——因为 `\graphicspath` 的前缀 `figures/` 与路径里的 `../../`
> **正好相抵消**：`paper/figures/` 退两级又回到项目根，再进 `figures/` 就命中了。
> 这是巧合，不是设计：目录层级一换（比如图片放在 `paper/figures/`）就断，
> 而且报的是 `Unable to load picture or PDF file`，不会自动回退。
> **统一写裸文件名 + 在 `main.tex` 里配 `\graphicspath`，别依赖这种抵消。**

**Typst 引擎**图片插入：

```typst
#figure(
  image("../../figures/fig_q1_error_dist.pdf", width: 85%),
  caption: [问题一预测误差分布],
)
```

英文论文使用英文图注。**图内不要写标题**，标题交给 `caption`，否则与图题重复。

### 步骤 4：撰写各节

**以下章节文件名按所选引擎使用 `.typ`（Typst）或 `.tex`（LaTeX）扩展名。** 例如 Typst 引擎用 `1_restatement.typ`，LaTeX 引擎用 `1_restatement.tex`。文件名主体保持一致。

中文数学建模通用模板各节文件（`changsanjiao`、`diangongbei`、`huashubei`、`mathorcup`、`wuyibei`）：

```text
1_restatement.typ  - 问题重述与分析
2_analysis.typ     - 数据理解与总体思路
3_assumptions.typ  - 模型假设
4_symbols.typ      - 符号说明
5_problem1.typ     - 问题一建模与求解
6_problem2.typ     - 问题二建模与求解
7_problem3.typ     - 问题三建模与求解
...         - 根据题目调整问题数量  
8_evaluation.typ   - 灵敏度分析、模型评价与推广
A_code.typ         - 附录代码
```

国赛/华中杯/华为杯（`cumcm`、`huazhongbei`、`huaweibei`）按以下章节结构：

```text
1_restatement.typ
2_analysis.typ
3_assumptions.typ
4_symbols.typ
5_problem1.typ
6_problem2.typ
7_problem3.typ
...        - 根据题目调整问题数量
8_sensitivity.typ
9_evaluation.typ
A_code.typ
```

东三省模板（`dongsansheng`）额外使用单独摘要文件：

```text
abstract.typ
1_restatement.typ
2_analysis.typ
3_assumptions.typ
4_symbols.typ
5_problem1.typ
6_problem2.typ
7_problem3.typ
...       - 根据题目调整问题数量
8_evaluation.typ
A_code.typ
```

数维杯模板（`shuweibei`）保留原 LaTeX 的示例入口命名：

```text
Abstract.typ
Introduction.typ
2_analysis.typ
3_assumptions.typ
4_symbols.typ
5_problem1.typ
6_problem2.typ
7_problem3.typ
...      - 根据题目调整问题数量
8_evaluation.typ
Appendices1.typ
A_code.typ
```

中文默认模板（`default`）：

```text
1_restatement.typ
2_assumptions.typ
3_symbols.typ
4_problem1.typ
5_problem2.typ
6_problem3.typ
...      - 根据题目调整问题数量
7_sensitivity.typ
8_evaluation.typ
A_code.typ
```

中文统计建模各节文件：

```text
1_introduction.typ
2_method.typ
3_data.typ
4_analysis.typ
5_results.typ
6_conclusion.typ
A_code.typ
```

英文 MCM/APMCM 各节文件（`en/mcm`、`en/apmcm`、`zh/mcm`、`zh/apmcm`）：

```text
1_introduction.typ
2_assumptions.typ
3_model_design.typ
4_solution.typ
5_sensitivity.typ
6_strengths_weaknesses.typ
7_conclusions.typ
A_code.typ
```

**LaTeX 模板章节文件**（对应 `-latex` 后缀模板，结构与 Typst 版本一一对应）：

国赛 LaTeX 模板（`zh/cumcm-latex`，对应 `cumcm` Typst 版本）：

```text
1_restatement.tex
2_analysis.tex
3_assumptions.tex
4_symbols.tex
5_problem1.tex
6_problem2.tex
7_problem3.tex
8_sensitivity.tex
9_evaluation.tex
A_code.tex
```

MCM/ICM LaTeX 模板（`en/mcm-latex`）：

```text
1_introduction.tex
2_assumptions.tex
3_model_design.tex
4_solution.tex
5_sensitivity.tex
6_strengths_weaknesses.tex
7_conclusions.tex
A_code.tex
```

其余 LaTeX 模板（`changsanjiao-latex`、`default-latex`、`huashubei-latex`、`mathorcup-latex`、`wuyibei-latex`、`huazhongbei-latex`、`huaweibei-latex`、`diangongbei-latex`、`dongsansheng-latex`、`shuweibei-latex`、`stats-latex`、`apmcm-latex`、`mcm-latex`、`en/apmcm-latex`、`en/default-latex`）的章节文件命名与上述结构类似，以 `main.tex` 中 `\input{}` 引用的文件名为准。

英文默认模板（`en/default`）：

```text
1_introduction.typ
2_assumptions.typ
3_notations.typ
4_model.typ
5_sensitivity.typ
6_evaluation.typ
7_conclusions.typ
A_code.typ
```

**正文写作应使用连贯的学术段落。避免在最终论文中出现工作流内部名称，如 `reports/`、`figures/` 或智能体平台的规则文件名。**

### 步骤 5：参考文献

只使用真实存在的参考文献。文件名按引擎选择：Typst 用 `paper/references.typ`，LaTeX 用 `paper/references.tex`。

**Typst 引擎**：

```typst
#set enum(numbering: "[1]")
#enum[
  作者. 题名[J]. 期刊名, 年份, 卷(期): 页码.
  Author. "Title." Journal or Conference, year.
]
```

正文上标引用：`相关研究已用于物流网络优化#super("[1]")。`

**LaTeX 引擎——先看模板有没有自带文献机制，有就一定要用它。**

竞赛模板常自带 `gmcm.bst`（华为杯即如此，实为 `gbt7714-unsrt.bst`）和一个
`reference.bib`。**这是模板作者指定的机制，优先于手工录入**：手工写 `thebibliography`
虽然也能编译，但格式、编号、排序全要自己维护，且与模板不一致。

```latex
% main.tex：\bibliographystyle 与 \bibliography 的路径相对主文件
\bibliographystyle{gmcm}
\bibliography{reference}
```

`references.tex` 里就放上面两行，文献条目写进 `reference.bib`，正文用 `\cite{键}`。
**编译链必须变成四趟**，官方模板的 `makefiles.sh` 就是这么做的：

```bash
xelatex -interaction=nonstopmode main.tex
bibtex main                        # 漏掉这趟就不会生成 main.bbl，引用全变 [?]
xelatex -interaction=nonstopmode main.tex
xelatex -interaction=nonstopmode main.tex
```

两个静默失败点，务必加进编译脚本的检查：`bibtex` 只收录**被 `\cite` 过**的条目
（未引用的条目不会出现在 PDF 里，容易误以为写错了）；漏跑 `bibtex` 时 `\cite` 渲染成
`[?]`，而 xelatex **不报错**。

**位置：参考文献必须排在附录之前**，即 `正文 → \input{references} → 附录`。放到附录
后面是常见错误。

中文文献条目要带 `language = {chinese}`，否则 GB/T 7714 的「等」会被渲染成「et al」。

模板没有自带 `.bst` 时才手工录入：

```latex
\begin{thebibliography}{99}
  \bibitem{ref1} 作者. 题名[J]. 期刊名, 年份, 卷(期): 页码.
  \bibitem{ref2} Author. "Title." Journal, year.
\end{thebibliography}
```

正文引用用 `\cite{ref1}` 或 `\cite{ref1,ref2}`。

### 步骤 6：最后撰写摘要或总结

在所有章节完成后撰写中文摘要或英文 Summary Sheet。必须包含每个子问题的方法和精确的数值结果。

## 华为杯（GMCMthesis）专用规范

**华为杯用官方 GMCMthesis 类，不要自己搓 ctexart。** 本 skill 的
`templates/zh/huaweibei-latex/` 已是官方模板（含 2026 年新版封面图），
整目录复制到 `paper/` 即可，不要重写 `main.tex` 的骨架。

### 官方用法清单——照抄 `example.tex`，别自己发挥

| 事项 | 正确做法 | 常见错法 |
| --- | --- | --- |
| 封面 | `\title` + `\baominghao` + `\schoolname` + `\membera/b/c` + `\maketitle` | 自己写 `\begin{center}...\end{center}` 封面 |
| 摘要 | `\begin{abstract} ... \keywords{...} \end{abstract}` | 手工排「摘要」二字 |
| 目录 | `\maketoc`（cls 里的壳 = `\phantomsection` + `\pdfbookmark[1]{目~录}{contents}` + `\tableofcontents`） | `\tableofcontents`（丢掉 PDF 书签） |
| 附录 | `\begin{appendices}` + `\section{...}` → 自动渲染「附录 A」；子节配 `\renewcommand{\thesubsection}{A\thinskip.\thinskip\arabic{subsection}}` → A.1 | 手写 `\section*{附录：源程序}` + `\addcontentsline`（没有「附录X」编号） |
| 参考文献 | `\bibliographystyle{gmcm}` + `\bibliography{reference}`，**排在附录之前** | 手搓 `thebibliography` |
| 编译 | `xelatex → bibtex → xelatex → xelatex` | 只跑两遍 xelatex（引用全变 `[?]`） |

### 类文件自带的能力，直接用

**12 个定理类环境**（中文标签已由 cls 设好，别自己 `\newtheorem`）：

```latex
definition  theorem  lemma  corollary  assumption  conjecture
axiom  principle  problem  example  proof  solution
```

```latex
\begin{assumption}
  忽略【某因素】对结果的影响。
\end{assumption}
```

**算法环境**（`\Require`/`\Ensure` 已被模板改成「输入:」「输出:」）：

```latex
\begin{algorithm}[H]
  \caption{【算法名】}
  \begin{algorithmic}[1]
    \Require 【输入】  \Ensure 【输出】
    \State 【步骤】
  \end{algorithmic}
\end{algorithm}
```

**表 / 式 / 图 一律按节编号。** cls 里 `\thetable`、`\theequation`、`\thefigure`
都定义成 `\arabic{section}.\arabic{...}`——第 5 节的第一个表就是「表 5.1」，
第一式就是 (5.1)。交叉引用一律用 `\ref{}` 让 LaTeX 自己算，**不要手写编号**。

### Linux / macOS 适配

官方原版有两处只在 Windows 成立，本模板已处理一处、另一处需按环境选：

- `\lishu`（隶书）：按用户模板的真实字体要求检查 LiSu。不能默认把楷体兜底视为版式一致；严格对齐时安装并验证隶书，且检查 PDF 中实际使用的字体。
- `fontset`：模板默认 `fontset=windows`，需要 SimSun / SimHei / KaiTi / FangSong
  四种真品字体。装不了就改成 `fontset=mac`（Songti SC / Heiti SC / Kaiti SC）
  或删掉该选项走 ctex 默认（fandol，字形与官方有出入，仅作应急）。

### 封面图不要替换

2026 年官方格式变化之一就是**「论文前两页 Logo 和 Title 替换」**。
`figures/logo.pdf`（西安交通大学等四家 logo）与 `figures/title.pdf` 是随模板下发的
新版，**不要用自己找的图覆盖**，也不要删。

## LaTeX 写作要点

以下要点供 **LaTeX 引擎**使用。Typst 引擎按其语法和项目模板执行；平台若有 Typst 专项能力可按需使用。

### 编译命令

```bash
# 中文模板（xelatex，跑两遍解决交叉引用）
xelatex main.tex && xelatex main.tex

# 英文模板（xelatex，同样跑两遍）
xelatex main.tex && xelatex main.tex
```

### 文档结构

```latex
\documentclass[a4paper,12pt]{article}   % 英文
\documentclass[a4paper,12pt]{ctexart}   % 中文

\usepackage{...}   % 宏包加载
\usepackage{graphicx}   % 图片支持
\usepackage{booktabs}   % 三线表
\usepackage{amsmath,amssymb}   % 数学公式
\usepackage{hyperref}   % 交叉引用（需两遍编译）
```

### 图表插入

```latex
% main.tex 里设一次搜索前缀，各 section 里只写裸文件名（见「步骤 3」的说明：
% \includegraphics 的路径基准是 main.tex 所在目录，不是写出该行的 section 文件）
% \graphicspath{{figures/}{../figures/}{../../figures/}}

\begin{figure}[H]
  \centering
  \includegraphics[width=0.85\textwidth]{fig_q1.pdf}
  \caption{图注}
  \label{fig:q1}
\end{figure}

% 三线表
\begin{table}[htbp]
  \centering
  \caption{表注}
  \begin{tabular}{ccc}
    \toprule
    \textbf{列1} & \textbf{列2} & \textbf{列3} \\
    \midrule
    数据 & 数据 & 数据 \\
    \bottomrule
  \end{tabular}
\end{table}
```

### 代码附录

**附录只放「算出论文里数值」的程序，画图脚本一律不放。**（用户硬要求，2026-09-22）

具体：`utils` + 各子问题的**计算**程序进附录；生成流程图 / 示意图 / drawio XML 的脚本
（如 `make_diagrams.py`）**不进**。判断口径就一句话——**它有没有参与算出论文里的数值？**
没有就不进。

理由：这类脚本正文就是 drawio 样式串，例如

```python
"edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;endArrow=classic;dashed=1;exitX=0;exitY=0.5;..."
```

单行可达 **160+ 列**（华为杯版心一行只容 68 列），在附录里每行折成两三行，
满页 `↪` 续行符；对评委是噪音，又不产生任何数值结论。
可复现性不受影响——`.drawio` 源文件在 `figures/` 下、脚本留在 `code/` 下即可。

删掉之后在该处留一句注释说明为什么不放，免得后来者以为漏了。

把代码收进附录用 `\lstinputlisting`。有两个容易踩的点：

**路径基准不同。** `\includegraphics` 受 `\graphicspath` 影响，而 **`\lstinputlisting`
的相对路径是相对主文件（`main.tex`）所在的目录解析的**，不是相对写出该行的 section 文件。
若 `main.tex` 在 `paper/`、代码在 `code/`，从 `paper/sections/A_code.tex` 里应写
`{../code/problem1.py}`——写成 `{../../code/...}` 会指到项目之外。
无论从哪个 section 引用，路径都按主文件算。

**外观优先照抄模板自带的代码环境，别自己发明。** 竞赛模板通常在 cls 里定义
`\lstnewenvironment{Matlab}` / `{Python}`，规定了这套纸的官方代码外观。
**用户明确要求「完全照模板」时，就逐项抄它的样式键**——竞赛模板的作者意图，
不要用自己觉得「更像国赛」的样式去覆盖。

华为杯（gmcmthesis）的 `Python` 环境外观是：

```latex
\lstset{
  language=Python,
  frame=single, framesep=4pt, framerule=0.5pt,   % 细黑实框
  rulecolor=\color{gray!50},
  backgroundcolor=\color{gray!5},                 % 浅灰底
  xleftmargin=10pt, xrightmargin=10pt,
  keywordstyle=\color{pKeyword},                  % 关键字 洋红 #E40080
  stringstyle=\color{pString},                    % 字符串 紫   #9400D1
  commentstyle=\color{pComment},                  % 注释   灰褐 #75715E
  tabsize=4, captionpos=t,
  % 下面几项模板没写，但用 \lstinputlisting 从文件读代码时必须补：
  basicstyle=\linespread{1}\small\ttfamily,
  upquote=true, columns=flexible, extendedchars=true,
  breaklines=true, breakatwhitespace=false, showstringspaces=false,
  postbreak=\mbox{\textcolor{gray}{$\hookrightarrow$}\space},
}
```

文件名写在代码框的标题条上：`\lstinputlisting[language=Python, title=problem1.py]{...}`
（模板里对应 `\begin{Python}{problem1.py}`），**子节标题只写说明，不要再重复文件名**。
外加导言区 `\setCJKmonofont{SimSun}`：代码里的中文走 `\CJKmonofont`（多为仿宋），
改成宋体才与正文一致。

## 从文件读代码 vs 用模板环境

模板的自定义环境是 `\lstnewenvironment`，**代码要写在正文里当 body**；而附录的代码
在 `code/` 下。别把代码复制进 .tex（两处维护必然不同步），改成
`\lstinputlisting` + 把模板的样式键搬进全局 `\lstset`，外观一致而代码只有一份。

**类文件里的 `basicstyle` 只写在自定义环境内部，不作用于全局 `\lstset`。**
漏配的第一后果是代码用**正文字体（比例字体）**排版，列对不齐，完全不像代码。

## 三个不报错、只静默劣化的坑（都实测过）

- **`\linespread{1}` 不能省，且必须写在 `\small` / `\fontsize` 之前。** 多数模板类文件
  设了 `\baselinestretch{1.38}`（gmcmthesis 在 cls 第 197 行），**listings 会原样继承**，
  代码行距就是 1.38 倍，松散得像散文——这是「代码附录看着不对」最常见、也最容易被
  忽略的原因（**肉眼看 PDF 才看得出来，编译不报任何错**）。而 `\fontsize{字号}{行距}`
  的第二个参数会被**当时的 `\baselinestretch` 再乘一遍**，顺序反了等于白设。
  实测：`\linespread{1}` 后每页代码 18 行 → 35 行。
- **`columns=flexible` 要加，不能留默认的 `columns=fixed`。** `fixed` 逐字符按固定宽度
  测量，CJK 是双宽字符，会在中文两侧撑出空缝（`"A中心区"` 渲染成 `" A 中心区 "`）。
  （曾误判它会溢出页边距——实测代码最右 735px、正文右边界 737px，并不溢出。）
- **模板自身的 bug 要检查，别盲抄。** gmcmthesis 的 `Python` 环境里
  `emphstyle=\color{pIdentifier}` 后面**漏了逗号**，导致下一行 `showspaces=false`
  被并进 `emphstyle` 的值里。照抄样式时把逗号补上。

## 版心决定字号，先算再选

`每行可容列数 = (\textwidth − 左右边距) / (0.6 × 字号pt)`，Courier New 字符宽 0.6em。
华为杯版心 469.47pt，减掉模板的 `xleftmargin/xrightmargin=10pt` 后：

| 字号 | 每行可容 | 备注 |
| --- | --- | --- |
| `\small`(10.95pt) | 68 列 | 模板原样；PEP8 的 79 列装不下，约 18% 的行会折行 |
| 9pt | 83 列 | 覆盖 PEP8 79 列，折行降到约 7% |

**先按模板字号排，折行过多再降字号**，并把这个权衡讲给用户听，别默默改。

**自检判据**：对比补 `basicstyle` 前后编译日志里 `courier` 的出现次数。补之前是 **0**
（说明 `\ttfamily` 从未触发，等宽字体压根没加载），补之后附录内嵌 `CourierNewPSMT`。

### 交叉引用

```latex
如图~\ref{fig:q1}所示，...   % 图片引用
式~(\ref{eq:objective}) 给出...   % 公式引用
见第~\pageref{fig:q1} 页   % 页码引用
```

### 数学公式

```latex
行内公式：$f(x) = \sum_{i=1}^n \theta_i \phi_i(x)$

行间公式：
\begin{equation}
  \mathcal{L}(\theta) = \frac{1}{N}\sum_{i=1}^N (y_i - \hat{y}_i)^2
  \label{eq:objective}
\end{equation}
```

### 章节和强调

```latex
\section{问题重述}
\subsection{问题背景}
\textbf{问题一：} xxx   % 对应 Typst 的 #strong
```
