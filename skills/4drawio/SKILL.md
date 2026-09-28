---
name: 4drawio
description: "数学建模非数据型图示绘制阶段。根据 ANALYSIS_MODELING_REPORT.md、RESULTS_REPORT.md 和已有 figures/ 生成技术路线图、子问题求解流程图、模型结构图、数据处理流程图等 DrawIO 图，并导出论文可引用 PDF。"
allowed-tools: Bash(*), Read, Write, Edit, Grep, Glob, Agent, WebSearch, WebFetch
---

# DrawIO 非数据图示绘制

## huaweicup 项目配色覆盖

在 `/home/zyl-zml/huaweicup` 及其子工作区绘图时，先读取 [huaweicup 流程图配色规范](/home/zyl-zml/huaweicup/_shared/流程图配色规范.md)。用户已授权自主配色：**文字必须黑色**，使用中等明度实色或白底深边框，避免浅色/粉彩面板；极深色用于无文字元素，不配白字。本次仅线上评阅，不启用打印/灰度门槛；保留结构与屏幕可读性检查。参考图颜色无需复刻，配色无需再问。本节覆盖下文及参考文档的冲突默认值，其他项目仍按各自媒介与用户偏好执行。


本 skill 承接 `3coding-visual`。它只负责论文中的**非数据型图示**，例如技术路线图、求解流程图、模型结构图、数据处理流程图、变量关系图、指标体系图等。

## 专项图示规则

绘制问题求解流程和技术路线图时，读取 `../adaptive-academic-flowchart/SKILL.md`：先核对真实步骤与依赖，再选择布局和配色；节点不放公式本体或已经求得的答案。绘制具体算法的原理或机制图时，读取 `../sci-algorithm-drawio/SKILL.md`：先核对用户方法与原始参考图的机制，再冻结连接关系，生成原生可编辑 `.drawio` 并检查实际导出。只在该图确需算法机制参考时执行其联网前置要求。比赛模板及用户当前配色要求优先。

在 `reports/FIGURE_TABLE_PLAN.md` 记录图示服务的子问、方法依据、论文位置和源文件；已有等价台账则沿用。验收时检查箭头的语义和端点，不以 XML 合法或渲染成功代替方法正确性。

## 数学建模规范参考

如需领域判断，读取 `../_references/math_modeling_norms.md` 中的“图表与可视化”和“非数据图工具选择”小节。该文件只作为规范知识库，不要求为了凑数量生成额外图示。

## 阶段边界

- 本阶段负责：DrawIO 源文件、非数据图 PDF、图示生成记录。
- 本阶段不负责：折线图、柱状图、散点图、热力图、箱线图、雷达图等数据图。这些由 `3coding-visual` 生成。
- 本阶段不重跑模型、不修改 `code/`，不改写 `reports/RESULTS_REPORT.md` 的数值结论。

## 必须产出

在当前工作目录创建或更新：

```text
figures/
  fig_roadmap.drawio
  fig_roadmap.pdf
  fig_flow_q1.drawio
  fig_flow_q1.pdf
  ...
reports/DRAWIO_REPORT.md
```

如果某类图不需要生成，必须在 `reports/DRAWIO_REPORT.md` 中说明原因。竞赛论文通常至少需要一张 `fig_roadmap` 技术路线图。

读取这些文件的目的不是提取数据作图，而是理解论文方法、章节结构、子问题关系和已有图表，避免重复。

## 工作流程

### Step 1: 盘点已有图表和需求

先读取以下文件（存在则读取）：`reports/ANALYSIS_MODELING_REPORT.md`、`reports/RESULTS_REPORT.md`、`figures/` 目录列表。

然后从前序文档提取非数据图需求，输出一个清单：

```text
DRAWIO PLAN CHECKLIST:
[ ] fig_roadmap      技术路线图，放在问题重述/绪论
[ ] fig_flow_q1      问题一求解流程图
[ ] fig_flow_q2      问题二求解流程图
[ ] fig_flow_q3      问题三求解流程图
[ ] fig_pipeline     数据处理流程图
[ ] fig_model        模型结构/变量关系图
```

清单不是固定模板，要根据题目实际删减或增补。不要为了凑图生成无意义图示。

### Step 2: 判定图类型

常见图示选择：

| 图类型 | 文件名建议 | 适用场景 |
| --- | --- | --- |
| 技术路线图 | `fig_roadmap` | 展示整体解题路线、章节逻辑、方法串联 |
| 子问题求解流程图 | `fig_flow_q1`, `fig_flow_q2` | 展示单个子问题的输入、判断、算法、输出 |
| 数据处理流程图 | `fig_pipeline` | 展示数据清洗、特征构造、建模输入 |
| 模型结构图 | `fig_model` | 展示模块关系、变量关系、模型层次 |
| 指标体系图 | `fig_index_system` | 展示目标层、准则层、指标层 |
| 决策树/规则图 | `fig_decision_tree` | 展示分类规则、设备选择、策略分支 |

不要用 DrawIO 画这些图：

- 结果对比柱状图
- 预测误差曲线
- 灵敏度曲线
- 相关性热力图
- 分布图和箱线图

### Step 3: 生成 DrawIO 源文件

每张图一个 `.drawio` 文件，放在 `figures/`。

DrawIO 内容要求：

- 文字语言与论文语言一致。
- 节点文字短，必要时双行，不堆长句。
- 同类节点样式统一。
- 箭头方向清晰，避免交叉。
- 图中不写大段解释，解释留给论文正文。
- 不使用装饰性阴影和过度渐变。

#### 外观规范（不遵守会输出"能用但平庸"的默认样式）

只写「样式统一」是不够的——不管的话出来就是直角 + 原色堆砌。

**配色与阅读媒介**

1. 背景以白色留白为主，参考图提供结构参考，颜色可以自主设计。
2. huaweicup 项目按上述项目规范：中等明度实色或白底深边框，避免浅色/粉彩面板。
3. 本项目所有文字黑色；有字填充须保持足够对比，极深色用于边框、箭头和无文字色带。
4. 本项目仅线上评阅，以屏幕显示和 PDF 阅读为验收口径，不要求灰度或打印优化。

**在此约束下的两种组织方式**

*方式 A：分区式*（适合多个子问题、信息密度高）

- 四个子问题用 2×2 四分区；三个子问题用三列或「上一下三」
- 每个分区用**灰色虚线框**圈起，白色填充
- 分区标题用大号粗体（20px+），放在虚线框**上方**
- 分区底部可加一行加粗小结
- **跨分区依赖用带文字标注的箭头表示**（如「问题一 → 问题四：价格残差」），
  这一条能直接读出各问之间的数据流

*方式 B：分层式*（适合单一主链、需区分节点类型）

- 统一圆角 `rounded=1;arcSize=12`
- 按语义自主选 2–4 种功能色，huaweicup 可使用蓝 `#5596C2`、赭橙 `#DB9640`、绿 `#61A38B` 等中等明度实色。
- 本项目文字 `#000000`，也允许白底内容框配深色边框。深色标题块不得叠黑字造成低对比；改为中等明度填充或白底标题。

**两者都适用**

- **连线也是设计**：`endArrow=block;endFill=1;endSize=7;strokeWidth=2`，
  折线加 `rounded=1;arcSize=12` 让拐角圆润
- **字号层级**：分区标题 > 框内文字 > 注释，不要一样大
- **节奏一致**：同层框间距固定，不要忽宽忽窄

#### ⚠️ 竖排文字、块箭头、汇聚路由

**`horizontal=0` 是竖排文字的正确手段，不是坑。**

它能做出"细高条内竖排文字"的效果（技术路线图、求解流程图常用）。
关键在于**明确知道要竖排时才加**——早期我在普通节点上误设 `horizontal=0;vertical=0`，
导致整框文字意外竖排，才把它当成了坑。

顺带澄清：**文字对齐**用的是 `align` / `verticalAlign`，与 `horizontal` 无关。

**块箭头只有 `shape=singleArrow` 能渲染。** 实测：

| shape | PDF 导出结果 |
| --- | --- |
| `flexArrow` | ❌ 完全不渲染 |
| `arrow` | ❌ 完全不渲染 |
| **`singleArrow`** | ✅ 正常 |

用它连接分区时，**列间距要 ≥ 60px**，否则箭头被挤成一条细缝。

**多路汇聚必须用显式路径点。**

三条以上流程汇聚到一个框时，正交路由会把横线画在**上游框的垂直中心**，
结果横线**穿过中间的框**。必须在边的几何里指定路径点，把横线压到上下游之间的空隙：

```xml
<mxCell id="e" style="..." edge="1" source="c1o" target="check">
  <mxGeometry relative="1" as="geometry">
    <Array as="points">
      <mxPoint x="215" y="424"/>   <!-- 先下到空隙高度 -->
      <mxPoint x="450" y="424"/>   <!-- 再横走到目标正上方 -->
    </Array>
  </mxGeometry>
</mxCell>
```

选空隙高度前先算清上游框下沿与下游框上沿的位置，别压在任何一个框上。

#### 现成范本（**先查这里，不要每次从零画**）

环境里若存在 `_shared/drawio-templates/`（工作流的共享模板库），**画图前必须先去看**。
库里有 18 个已校验的范本（XML 合法、id 唯一）：

- **`数模流程图模板集/`** —— 11 个**按框架结构命名**的模板，挑法见该目录 `README.md`
  的对照表：2×2 象限式（01/02/03）、左右双栏式（04/05）、三列分区式（06）、
  横向分区式（07）、左纵右双栏（08）、分行链式（09）、环绕式（10）、矩阵表格式（11）。
  对照表里写着每个模板「框架长啥样 / 适用场景」，按「我要哪种布局」直接挑。
- **根目录** —— `整体技术路线图-范本`、`问题二/三/四求解流程-范本`、
  `三列分区问题一求解流程-范本`、`CNN结构图-范本`，以及 2×2 备份版。

**用法：复制一份再改，不要污染模板库。**

模板布局与路由参数见 `_shared/drawio-templates/README.md`。复制后按项目最新配色规范调整 `fillColor`、`strokeColor` 和 `fontColor`，不要机械照搬旧配色。

生成大 XML 时，分段写入，避免截断。示例：

```bash
mkdir -p figures
cat << 'XMLEOF' > figures/fig_roadmap.drawio
<mxfile>
  <diagram name="Page-1">
    <mxGraphModel>
      <root>
        <mxCell id="0"/>
        <mxCell id="1" parent="0"/>
        <!-- nodes and edges -->
      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
XMLEOF
```

### Step 4: 导出 PDF

优先用可用的 DrawIO 命令导出 PDF：

```bash
DRAWIO_BIN="$(command -v drawio 2>/dev/null || command -v draw.io 2>/dev/null || command -v draw.io.exe 2>/dev/null || true)"
if [ -n "$DRAWIO_BIN" ]; then
  "$DRAWIO_BIN" --export --format pdf --crop --output figures/fig_roadmap.pdf figures/fig_roadmap.drawio
else
  echo "DrawIO command not found; keep .drawio source and record export failure."
fi
```

如果无法导出 PDF，保留 `.drawio`，在 `reports/DRAWIO_REPORT.md` 记录失败原因和建议导出命令。

### Step 5: 自检和修复

每张图必须检查：

- `.drawio` 文件非空。
- **`.drawio` 是合法 XML。** 必须用解析器验证，不能只看「能不能导出」：

  ```bash
  python3 -c "
  import xml.etree.ElementTree as ET, sys
  for f in sys.argv[1:]:
      try: ET.parse(f); print('OK  ', f)
      except Exception as e: print('FAIL', f, e)
  " figures/*.drawio
  ```

  裸 `<` 会让整个文件成为非法 XML。**`<mxCell>` 的 `value` 属性里换行必须写
  `&lt;br&gt;` 而不是 `<br>`**——属性值中不允许出现裸 `<`。drawio 自身解析宽容，
  但导出器不认，且会静默产生错误结果（见下方「典型故障」）。
- 若导出成功，`.pdf` 文件非空。
- **`.pdf` 体积合理。** 体积异常小往往意味着标签根本没渲染。同样内容下，
  单行标签与双行标签的 PDF 体积可相差数倍；若某图明显小于同类图，必须打开确认。
- 节点没有明显重叠。
- 箭头不穿过核心节点。
- 字号、颜色、边框风格一致。
- 文件名和图意一致。
- 没有与 `3coding-visual` 的数据图重复。

发现问题要修 `.drawio` 并重新导出，不要只在报告里解释。

#### 典型故障：XML 未转义（实测案例）

一次生成 5 张图，标签里的 `<br>` 直接写进了 `value` 属性：

- 现象：drawio 解析宽容，5 张里 4 张照常导出 PDF，只有 1 张报 `Export failed`。
- 隐藏后果：那 4 张「导出成功」的 PDF 里，`<br>` **没有被当作换行**，
  文字挤成一行——体积只有 11 KB，修复后是 78 KB。
- 若只检查「PDF 非空」，这 5 张图会被判定全部合格，错误一路带进论文。

**结论：XML 合法性 + PDF 体积合理性 + 目视确认，三者缺一不可。**

### Step 6: 写生成记录

创建 `reports/DRAWIO_REPORT.md`，至少包含：

```markdown
# DrawIO 图示生成报告

## 图示清单
| 文件 | 类型 | 来源依据 | 用途 | 状态 |
| --- | --- | --- | --- | --- |

## 未生成图示及原因

## 导出与自检记录

## 给论文阶段的嵌入建议
```

嵌入建议只说明每张图适合放入哪个章节和建议 caption，不生成 `*_typst_includes.typ`。最终的图表插入代码（Typst 的 `#figure(image(...), caption: [...])` 或 LaTeX 的 `\begin{figure}...\end{figure}`）由 `5writing` 根据论文结构和所选引擎决定。

## 质量要求

- 图示服务论文论证，不为装饰而画。
- 每张图必须能对应到`reports/ANALYSIS_MODELING_REPORT.md` 中的真实方法。
- 数据型图表不得在本阶段重复生成。
- 论文阶段引用的非数据图都应有 `.drawio` 源文件和 PDF，或者在 `reports/DRAWIO_REPORT.md` 说明导出失败。
