---
name: 3coding-visual
description: "数学建模编程实现与数据图表生成阶段。根据 ANALYSIS_MODELING_REPORT.md 编写可复现代码、运行求解、验证约束、输出 RESULTS_REPORT.md 并生成论文可用的数据驱动图表 PDF。"
---

# 编程实现与数据图表生成

本 skill 承接 `2analysis-modeling`。目标是把 `reports/ANALYSIS_MODELING_REPORT.md` 里的模型和算法落实为可复现程序，跑出可信结果，并生成论文中需要的数据型图表。

每个子问题完成后按 `../1start-mathmodel/references/workflow-gates.md` 的计算门禁检查。关键结果记录输入版本、运行命令、参数、随机种子（适用时）、结果文件字段及校验结论。把可写入论文的主张更新到 `reports/CLAIM_EVIDENCE_LEDGER.md`，把数据图登记到 `reports/FIGURE_TABLE_PLAN.md`；已有等价台账则沿用。只有结果和图表数据可复核时才标为“通过”。

## 数学建模规范参考

如需领域判断，读取 `../_references/math_modeling_norms.md` 中的“题型防错速查”“代码实现与结果”“编码阶段常见错误”和“图表与可视化”小节。该文件只作为规范知识库，不新增本阶段的固定产物。

## 阶段边界

- 本阶段负责：代码、实验运行、结果、结果表、数据驱动图表。
- 本阶段不负责：技术路线图、算法流程图、系统架构图、概念示意图。这些交给 `4drawio`。
- 本阶段不写论文正文，只为 `5writing` 提供可信数值和图表资产。


### Step 1: 代码结构

按 `plan.md` 中"项目目录结构"创建 `code/` 和 `figures/` 骨架，再开始写代码。子问题数不一定是 3，按赛题实际数量调整。


### Step 2: 逐子问题实现

按子问题顺序实现，不要一次性写完不跑。

每个子问题必须完成：

1. 读取所需数据。
2. 实现模型或算法。
3. 验证约束。
4. 输出核心结果。
5. 绘制丰富的图表。
6. 在 `reports/RESULTS_REPORT.md` 中写清楚方法、关键数值和校验结果。

优化类问题必须先保证可行解，再优化目标值。预测类问题必须做训练/验证划分或合理误差评估。评价类问题必须说明指标方向、归一化方法和权重来源。

### Step 3: 结果文件格式


AI 在实现、求解和作图过程中，必须把关键中间过程保存成数据并做好记录，例如清洗后的数据摘要、模型参数、迭代历史、约束检查、灵敏度分析过程、图表所用数据和运行日志。中间数据优先保存到 `figures/` 或 `code/outputs/`，并在 `reports/RESULTS_REPORT.md` 中说明文件用途。

`reports/RESULTS_REPORT.md` 推荐结构：

```markdown
# 计算结果

## 运行环境
## 数据读取与预处理
## 问题一结果
## 问题二结果
## 问题三结果
## 灵敏度分析
## 约束与一致性校验
## 与建模报告的一致性说明
## 可复现运行方式
```

所有数据和图表结果都必须出现在 `reports/RESULTS_REPORT.md` 中引用

### Step 4: 生成数据驱动图表

根据 `reports/ANALYSIS_MODELING_REPORT.md` 和 `reports/RESULTS_REPORT.md` 规划图表，生成 PDF 到 `figures/`。

典型图表：

- 预测类：真实值-预测值对比、误差分布、指标对比。
- 优化类：收敛曲线、成本对比、资源利用率、方案前后对比。
- 评价类：综合得分排序、雷达图、热力图、敏感性曲线。
- 数据理解：分布图、趋势图、相关性图、箱线图。

图表要求：

- **绘图前先 `import mm_style; mm_style.use()`**（工作区 `code/` 下已提供），
  不要手写 `plt.rcParams`，否则每张图风格不一。详见下面的「绘图风格」小节。
- **不要直接写颜色字面量**，一律走 `mm_style.C[n]` 或 `mm_style.palette()`。
- PDF 矢量输出，适合论文。
- 不在图内写大标题，标题交给论文 caption（Typst 的 `caption:` 或 LaTeX 的 `\caption{}`）。
- 中文论文图表使用中文坐标轴和图例；英文论文使用英文。
- 不生成流程图/架构图/路线图。
- **代码与图表文字中禁用 emoji 及 LaTeX 无法渲染的符号。**

#### 字符约束（会影响论文附录）

生成的代码会被 `5writing` 通过 `\lstinputlisting` 原样收入论文附录，因此源文件里的每个字符
都必须能被 LaTeX 渲染。以下字符会触发 `Missing character` 警告，在 PDF 中显示为空白或方框：

| 禁用 | 原因 | 改用 |
| --- | --- | --- |
| `✅` `❌` `⚠` `🔴` 等 emoji | 中英文字体均无此字形 | `[OK]` / `[X]` / `[!]` |
| `℃`（U+2103） | Times New Roman / SimSun 均无 | `°C`（U+00B0，两者都有） |
| `️`（U+FE0F 变体选择符） | 常随 emoji 一起出现，易被漏掉 | 一并删除 |

**注意**：这类字符常出现在状态标记、校验结果表和 docstring 里，是代码的自然写法，
但会一路带进论文附录。生成代码时直接避免，比事后清理省事。

#### 绘图风格：直接用工作区的 `mm_style.py`，不要自己现调

**工作区 `code/` 下已经有 `mm_style.py`，绘图前先调它，不要每次手写 `rcParams`。**

```python
import mm_style
mm_style.use()                     # 用本工作区的默认色系（已按作品分配好）

fig, ax = plt.subplots(figsize=mm_style.FIG_WIDE)
ax.bar(x, y, color=mm_style.C[0], edgecolor="black", linewidth=0.8)
mm_style.save(fig, "fig_q1_error")            # -> ../figures/fig_q1_error.pdf
```

它已封装好字体、字号、图幅、坐标系、导出设置，并提供 `palette()` / `colors(n)` /
`encode(i)` / `sequential_cmap()` / `diverging_cmap()` / `bar_annotate()`。
**手写 `plt.rcParams` 会导致每张图风格不一**，这正是要避免的。

**图幅只用标准尺寸，且与论文里的 `width=` 严格 1:1 对应。**
不要随手 `figsize=(7.5, 3.4)`——figsize 与嵌入宽度不匹配就会被二次缩放，
**字号跟着变，全篇忽大忽小**。实测某测试论文里同是 10pt 的字，最终渲染成
**6.7pt ~ 10.2pt**（差 1.5 倍），原因就是 10 张图各用各的 figsize +
论文里 9 档不同的 `width=`。

| 档位 | figsize | 论文里写 | 用在什么图 |
| --- | --- | --- | --- |
| 通栏 | `FIG_WIDE` (6.5, 3.9) | `width=\textwidth` | 多序列柱状、时间序列 |
| 通栏矮 | `FIG_WIDE_S` (6.5, 3.0) | `width=\textwidth` | 柱状对比、矮热力图 |
| 通栏高 | `FIG_WIDE_TALL` (6.5, 5.0) | `width=\textwidth` | 2×2 多面板 |
| **中档** | `FIG_MID` (4.69, 3.2) | `width=0.72\textwidth` | **独占一行**的横向图 |
| **中档方形** | `FIG_MID_SQ` (4.69, 4.1) | `width=0.72\textwidth` | **独占一行**的散点、方阵热力图 |
| 半栏 | `FIG_HALF` (3.13, 2.6) | `width=0.48\textwidth` | **仅用于真正并排两张** |
| 半栏方形 | `FIG_HALF_SQ` (3.13, 2.95) | `width=0.48\textwidth` | **仅用于真正并排两张** |

**选档位的两条规则**（踩过坑）：

1. **方形图（散点、方阵热力图）不要拉通栏。** 散点图要等比例坐标，
   拉成 6.5in 宽就会变成 6.5×6.1in 的巨图，一张占大半页。用中档。
2. **半栏档只在真正并排两张时用。** 单独摆一张会留一大片空白，
   看起来「图太小」。实测某论文 15 个浮动体**全是单张**，5 张半栏图
   就都孤零零占了一行。
3. **`matplotlib` 的 `plt.subplots` 一次给多张图时**（如 2×2 面板），
   尺寸仍按上表选通栏，不要按单张缩放。

**散点/拟合对比图必须设 `ax.set_aspect("equal", adjustable="box")`**：
否则 x/y 量程不同，「理想拟合线」看起来不是 45°，
「偏离对角线多少」这个判读就失真了。

**两个必须遵守的导出约定**（`mm_style` 已设好，改代码时别破坏）：

- **`savefig.bbox` 必须是 `None`**，不能是 `"tight"`。`"tight"` 按内容裁剪，
  每张图裁掉的空白量不同，嵌入时放大倍率就不同，同样导致字号漂移。
- **`figure.constrained_layout.use = True`**。matplotlib 默认给底部留 11% 高，
  矮图（`FIG_HALF` 只有 2.6in）的 11% = 20.6pt，而「9pt 刻度 + 10pt 轴标签」
  要 ~25pt，**轴标签会溢到图外**，在论文里与 `\caption` 压在一起。
  开了它之后**不要**再手工 `subplots_adjust()` / `tight_layout()`。

风格底子是 `scientific-figure-making`（figures4papers house style），做了三处竞赛适配：

| 适配项 | 原版 | 本工作流 |
| --- | --- | --- |
| 字体 | `["Arial", "Helvetica", "DejaVu Sans"]`（中文全变方框） | 追加 `Noto Sans CJK SC` / `SimHei` |
| 栏宽 | Nature 的 88mm / 180mm | 华为杯版心 **165.6mm**（`FIG_WIDE`/`FIG_HALF` 已按此定） |
| 字号 | `font.size=16`（面向大幅单图） | 基准 10pt（图按版心 1:1 嵌入） |

**本工作区用哪套色系写在 `mm_style.py` 的 `DEFAULT_THEME` 里**，六份作品各一套、
互不雷同（蓝 / 青 / 绿 / 橙红 / 紫 / 酒红），横向对比时一眼能区分。

配色纪律：

- **分类色和顺序色不要混用。** 一个色系 = `main`（主色，作品身份）
  + `accent1` / `accent2`（**两个不同色相**的对比色）。
  `colors()` 返回 `main → accent1 → accent2 → secondary → neutral`，
  **前 3 个分属三个不同色相**。
  **`light[]` 是顺序色阶，只用于热力图/堆叠/填充，不要拿它当分类色**——
  否则 6 条曲线里 4 条同一个色相的深浅，根本分不清。
- **不要把同色相的深浅两档当两个分类色。** 红绿色盲下它们会塌成一个色
  （实测深紫 `#5B2C82` vs 绿 `#2E8B57` 只有 12.5，完全分不出）。
  第 4 条序列的 `secondary` 就是这种情况，**必须配线型/标记**。
- **同一篇论文里的发散色阶只用一种**（`mm_style.diverging_cmap()`）。
  实测 dry run 同时用了 `RdBu_r` 和 `RdYlGn` 两套，观感割裂。
- **不要直接写颜色字面量**（`color="red"`、`color="#6c8ebf"`）——一律走
  `mm_style.C[n]` 或 `palette()`，换色系时一处生效。
- 顺序色阶用 `sequential_cmap()`，别用 `viridis`/`jet` 之类的默认色图。

#### ⚠️ 「灰度可区分」靠的是冗余编码，不是调色板

`math_modeling_norms.md` 要求「颜色要能灰度区分」。**但没有任何分类色板能做到**——
实测各权威色板的灰度最小间距：Okabe-Ito 4.2、ColorBrewer Set2 3.0、
Paired 0.6、Dark2 0.3、Tableau 10 1.6。本套是 10~40，反而更好。

所以这条规范的正确落实方式是**冗余编码**：颜色之外再叠一层
**标记形状 + 线型**（折线）或**填充纹理**（柱状）。
`mm_style` 已提供：

```python
# 折线：一条语句同时套上颜色 + 标记 + 线型
for i, (name, ys) in enumerate(series.items()):
    ax.plot(x, ys, label=name, **mm_style.encode(i))

# 柱状：叠加填充纹理
for k, (name, ys) in enumerate(series.items()):
    ax.bar(x + k*w, ys, w, label=name,
           color=mm_style.C[k], edgecolor="black",
           hatch=mm_style.HATCHES[k])
```

实测：三条曲线在**纯灰度**下依然清晰可辨（实线圆点 / 虚线方块 / 点划线三角）。
**多序列图一律加这层编码**，别只靠颜色。

色盲友好性各套都是达标的（前 3 色实测最小距离 71~99，
超过色盲安全金标准 Okabe-Ito 的 64.1），这一条**不需要**再额外处理。

#### 构图：单图之外的排布（借 `scientific-figure-making` 的思路，但尺寸按版心重定）

`mm_style` 只管**样式**（字体/颜色/线宽/导出），**不管构图**。
单张图之外怎么排——多面板、图例往哪放、y 轴范围怎么定——读
`${AGENT_SKILLS_DIR:-$HOME/.local/share/agent-skills}/scientific-figure-making/references/common-patterns.md`
（若本机装了该 skill；没装就按下面这几条做）。
**只借它的构图思路，样式参数一律用 `mm_style`，不要照抄下面的值**：

| 它的原值 | 为什么不能照抄 |
| --- | --- |
| `font.family=["Arial","Helvetica","DejaVu Sans"]` | 中文全变方框 |
| `font.size = 16` | 图在 165.6mm 版心里字号过大 |
| `figsize=(45, 12)`、`(28, 6)` | 那是大幅单图的尺寸，版心只有 6.5in 宽 |

**按华为杯版心换算过的尺寸**（版心 165.6mm = 6.5in）：

| 用途 | figsize |
| --- | --- |
| 单图通栏 | `mm_style.FIG_WIDE` = (6.5, 3.9) |
| 单图半栏（并排两张） | `mm_style.FIG_HALF` = (3.15, 2.6) |
| 1×2 两面板 | (6.5, 3.0) |
| 1×3 三面板（多指标一行） | (6.5, 2.2) |
| 2×2 四面板 | (6.5, 5.2) |

几个值得吸收的模式：

**① 图例面板**——曲线多时图例很大，放在数据区会压住数据。给它单独一个子图：

```python
# layout="constrained" 必需：图例面板 set_axis_off() 后
# 用 tight_layout() 会报 "Axes not compatible with tight_layout" 且结果不对
fig = plt.figure(figsize=(6.5, 2.2), layout="constrained")
gs = fig.add_gridspec(1, 4, width_ratios=[1, 1, 1, 0.9])
axes = [fig.add_subplot(gs[0, i]) for i in range(3)]
lgax = fig.add_subplot(gs[0, 3]); lgax.set_axis_off()      # 第四格专放图例
...
h, l = axes[0].get_legend_handles_labels()
lgax.legend(h, l, loc="center left", frameon=False, fontsize=9)
```

**② 动态 y 轴范围**——数据都在 85~95 时不要用 0-100，会把差异压平。
按数据范围留一点边距，但**不要小到夸大差异**（数学建模论文要经得起追问）。

**③ 分类柱可隐藏 x 刻度**——x 轴是「方法/条件」且图例已写明时，
`ax.set_xticks([])` 让图更干净。**但**如果 x 是数值区间（如「0-5km」），
刻度必须保留，隐藏会误导。

**④ 柱状一律黑描边**（`edgecolor="black", linewidth=0.8`），
密集处再加 `hatch=mm_style.HATCHES[k]`，这就是上面说的冗余编码。

#### 需要不常见的图表时：查这两处现成实现

- **`mathmodel-figure-templates`**（工作流自带，11 个模板）：泰勒图、云雨图、
  和弦图、SHAP 蜂群柱状图、交叉验证 ROC、分组环形热图、TPE 调参 3D 曲面等。
  它的脚本用**确定性模拟数据**、输出到 `绘图复刻/`——**不能直接拿来画论文图**，
  正确用法是**抄它的实现改数据源**。
- **`scientific-figure-making/references/`**：`tutorials.md`（端到端流程）、
  `demos.md`（`figure_*` 实例索引）、`design-theory.md`（排版与导出理念）。

#### 图表中文字体（必须验一遍）

matplotlib 默认字体不含中文，直接绘图**全是方框，而编译与导出都不报错**。
`mm_style.use()` 已经把中文字体配好了，但换机器或改了字体链后要重新验证。

**关键机制**：matplotlib 的逐字形回退**只认 `font.family` 列表**——
写 `font.sans-serif` 是无效的。列表里西文在前、中文在后，才能做到
「Arial 渲染西文、Noto Sans CJK 渲染中文」。

`mm_style.py` 的 `_resolve_fonts()` 会按本机实际装了的字体**静默过滤**候选列表：
一个没装的字体（如 macOS 有而 Linux 无的 `Helvetica`）会刷出几百条
`findfont: Font family ... not found`，把真正的缺字警告淹没。

**验法**：渲染一张带中文的最小图，确认

```bash
pdffonts out.pdf | grep -i cjk     # 应看到 NotoSansCJK / SimHei 已内嵌
```

并且绘图时**没有 `missing from font` 警告**。字体链里如果有没装的字体，
先看警告是不是只是 `findfont ... not found`（无害，已被过滤掉了），
别把真正的缺字警告漏过去。
