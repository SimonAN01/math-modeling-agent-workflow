---
name: 1start-mathmodel
description: "数学建模竞赛工作流入口。用于启动完整建模流程：询问用户偏好，生成 plan.md 和 todo.md，并按阶段调用赛题分析、建模、代码与图表、流程图、论文撰写、验证验收等 skills。"
---

# 数学建模工作流

本 skill 是数学建模竞赛项目的总控入口。它不替代后续阶段 skill，而是负责启动流程、询问偏好、记录决策、生成计划，并按顺序调用各阶段 skill。

## 阶段门禁与回退

按 `references/workflow-gates.md` 检查每一阶段的可审查产物。阶段顺序是默认推进方向，不是单向流水线：发现题意、模型、结果或图示错误时，回到产生问题的阶段，更新受影响的下游文件后再验收。只重跑有依赖的子问题。

在 `plan.md` 记录当前采用的结果版本与论文引擎；在 `todo.md` 记录当前门禁状态。创建 `reports/CLAIM_EVIDENCE_LEDGER.md` 与 `reports/FIGURE_TABLE_PLAN.md` 的简洁表头，分别追踪论文主张和图表。已有项目若存在等价台账，沿用现有文件，不重复创建。

辅助技能按实际任务选用：`4drawio` 处理流程图时读 `adaptive-academic-flowchart`，处理算法机制图时读 `sci-algorithm-drawio`；`5writing` 处理图表公式衔接、三线表和论文叙事时分别读 `math-modeling-text-object-integration`、`math-modeling-three-line-tables`、`paper-launch-polish`。这些技能提供专项规则，不增加固定阶段，也不覆盖比赛模板或用户要求。

## 数学建模规范参考

如需领域判断，读取 `../_references/math_modeling_norms.md`。该文件只提供数学建模基本规范和防错知识，不改变本 skill 的阶段顺序和产出约定。

## 用户指定模板的继承约定

用户提供模板目录、示例 PDF 或明确要求沿用某模板时，记录其绝对路径、排版引擎、示例入口和版式要求到 `plan.md`，交给 `5writing`、`6verity` 继承。此时技能内置模板仅作后备，不覆盖用户模板。

- 正文与摘要的字体、字号、行距、段间距、标题间距、页边距以指定模板的实际生效设置为准；检查类文件和主文件的叠加效果，不能只凭模板名称判断已对齐。
- 不得为压缩摘要、凑正文页数或依据未经核验的“通用规定”覆盖模板。用户已确定的偏好持续有效，不重复索要确认。
- 缺字体先检查真实字体家族及安装来源；禁止静默用近似字体替换后声称一致。用户要求严格对齐时，缺字体属于尚未解决的排版问题，安装所需字体并核验后再验收。
- 验收记录应包含模板差异、字体来源与 PDF 实际嵌入字体、样页目视对比，以及正文/摘要/参考文献/附录各自页数。正文目标不含前后置部分，不能通过擅改行距凑页数。
- 减少三级标题时，不得直接将其批量替换为 `\paragraph` 后假定版式不变；先检查指定模板是否将该命令定义为行内标题。用户需要独立提示时，采用不编号、独立占行的加粗标题，具体实现由 `5writing` 负责，保留原模板类文件。编译后检查标题尾字和正文首字有无粘连、重叠、断行异常，并确认提示标题不会孤立在页底。将此项列入项目排版待办与验收记录。

## 提交 PDF 文件名

数学建模竞赛提交 PDF 按“题号＋队伍编号”命名：`<A–F 大写题号><队伍编号>.pdf`，例如 `C26000010001.pdf`。从用户已提供的信息或项目报名信息确定题号、队伍编号，记录到 `plan.md`；缺失时不编造。编译脚本的最终输出、提交目录和打包入口使用同一名称，不将 `main.pdf`、`论文.pdf` 作为交付文件。LaTeX 使用 `-jobname` 时，BibTeX 同步使用该 jobname；Typst 直接指定输出路径。保留主源文件名不影响交付命名。新项目若有用户明确指定的不同命名要求，按其要求执行。

## 必须产出

在当前工作目录中创建或更新以下文件：

- `plan.md`：整体流程方案、建模方向、阶段顺序、预期产物和风险控制。
- `todo.md`：具体待办事项列表，记录每个阶段的任务和状态。

## 工作流

### 1. 询问用户偏好

在规划前，只询问会实质影响流程的问题。问题要少而关键。使用当前智能体平台可用的提问能力；若平台不能交互提问，则采用用户已给出的偏好并在 `plan.md` 标注未确认项。

优先询问（按重要性排序）：

1. **排版引擎**：Typst 还是 LaTeX？— 决定 5writing 使用哪套模板和编译命令。两套引擎均覆盖全部模板（14 中 + 3 英）。Typst 使用 `typst` 命令编译；LaTeX 使用 `xelatex` 命令编译（需跑两遍解决交叉引用）。
2. **竞赛类型**：国赛/华为杯/华中杯/MCM/...— 决定模板选择，见 5writing 的模板族清单。
3. **论文语言**：中文/英文 — MCM/ICM/COMAP 强制英文，其他默认中文。
4. **子问题数量是否已知**：影响章节文件生成数量。若未知，由 2analysis-modeling 阶段根据题面确定。

将用户的选择记录到 `plan.md` 的"方案"小节中。


### 2. 制定方案

按以下结构编写 `plan.md`：

```markdown
# 方案

要依次调用这些 skill，按照里面要求完成任务。

用户偏好：
- 排版引擎：<Typst / LaTeX>
- 竞赛类型：<国赛 / 华为杯 / MCM / ...>
- 论文语言：<中文 / 英文>
- 子问题数量：<已知 N 个 / 待分析确定>

workflow:
   step      skills
1. 赛题分析与建模设计 - `2analysis-modeling`
2. 编程实现和图表生成 - `3coding-visual`
3. 流程与架构图绘制 - `4drawio`
4. 竞赛论文撰写 - `5writing`
5. 验证和验收 - `6verity`
```

## 项目目录结构

各阶段按此骨架创建和填充文件：

```text
.
├── plan.md                      # 1: 本文件
├── todo.md                      # 1: 待办事项
├── reports/                     # 各阶段文档报告
│   ├── ANALYSIS_MODELING_REPORT.md  # 1: 赛题分析-建模报告（2analysis-modeling）
│   ├── RESULTS_REPORT.md            # 2: 结果报告（3coding-visual）
│   ├── DRAWIO_REPORT.md             # 3: 非数据图说明（4drawio）
│   ├── VERIFY_REPORT.md             # 5: 验收报告（6verity）
├── code/                        # 2: 代码（3coding-visual）
│   ├── problem1.py
│   ├── problem2.py
│   ├── problem3.py               # 问题的数量应该更具题目动态调整
│   ├── ... 
│   └── utils.py
├── results/                     # 2: 结果记录（3coding-visual）
├── figures/                     # 2+3: 所有图表（3coding-visual + 4drawio）
│   ├── *.pdf                    #     数据图 + 非数据图 PDF
│   ├── *.drawio                 #     非数据图源文件
├── paper/                       # 4: 论文（5writing）
│   ├── main.typ / main.tex      #     论文主文件（按用户选择的引擎）
│   └── sections/                #     各节文件（.typ 或 .tex）
```

方案必须明确每个阶段由哪个下游 skill 负责，以及该阶段应产出什么文件。

### 3. 生成待办

将 `todo.md` 写成阶段性 checklist，格式如下：

```markdown
# 待办事项

- [ ] 1. 赛题分析与建模设计 - `2analysis-modeling`
- [ ] 2. 编程实现和图表生成 - `3coding-visual`
- [ ] 3. 流程与架构图绘制 - `4drawio`
- [ ] 4. 竞赛论文撰写 - `5writing`
- [ ] 5. 验证和验收 - `6verity`
```

每完成一个阶段，都要更新 `todo.md` 中对应任务的状态。

### 4. 依次执行阶段

按以下顺序调用下游 skills：

| 阶段 | Skill | 作用 | 主要产物 |
| --- | --- | --- | --- |
| 赛题分析与建模设计 | `2analysis-modeling` | 解析题意、识别变量/约束/数据/评价指标，并建立数学模型、目标函数、约束条件和求解策略。 | `ANALYSIS_MODELING_REPORT.md` |
| 编程实现和图表生成 | `3coding-visual` | 实现可复现代码，运行实验，生成结果表和多种多样的图表。 | `code/`, `results/` ,  `RESULTS_REPORT.md`, `figures/图表` |
| 流程与架构图绘制 | `4drawio` | 在论文确实需要时，绘制方法流程图、架构图和非数据型概念图。 | `figures/*.drawio`, `figures/*.pdf`, `DRAWIO_REPORT.md` |
| 竞赛论文撰写 | `5writing` | 基于分析、建模、代码结果和图表撰写最终竞赛论文，并按章节直接插入图表。 | `paper/` |
| 验证和验收 | `6verity` | 检查可复现性、一致性、产物完整性、格式规范和提交就绪状态。 | `VERIFY_REPORT.md` |

## 阶段边界

- `3coding-visual` 负责生成所有依赖计算结果或实验输出的数据图表。
- `4drawio` 只负责概念图、算法流程图、架构图、路线图等非数据型图示。
- 不要让 `4drawio` 重复绘制 `3coding-visual` 已经生成的统计图或数据图。
- `5writing` 负责决定图表在论文中的位置，并按所选引擎写入图表代码：
  - Typst：`#figure(image("../../figures/xxx.pdf", width: 85%), caption: [...])`
  - LaTeX：`\begin{figure}[H]\centering\includegraphics[width=0.85\textwidth]{../../figures/xxx.pdf}\caption{...}\label{fig:xxx}\end{figure}`
- 不要让 `5writing` 编造数值结论。论文中的数值必须来自 `RESULTS_REPORT.md`、结果表或已生成图表的数据。
