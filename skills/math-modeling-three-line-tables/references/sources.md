# 来源与适用边界

查阅日期：2026-09-24。这里的来源用于支持技术实现和统计报告要求；不把某一期刊的规则推广成所有数学建模比赛的规定。

## [S1] LearnLaTeX — Tables
https://www.learnlatex.org/en/lesson-08

由LaTeX相关社区维护的入门材料，介绍 `booktabs` 的顶线、中线、底线及局部分组线，强调节制使用线条。本技能的“三线风格允许必要分组线”据此组织。

## [S2] CTAN — booktabs
https://ctan.org/pkg/booktabs

包的正式条目，说明出版级表格用途及与longtable的兼容性。本技能不把三条线当成所有表严格线数上限。

## [S3] CTAN — siunitx
https://ctan.org/pkg/siunitx

正式包条目说明数值、单位一致排版以及表格数值对齐能力。示例的具体配置以本地实际编译为准，不承诺任意版本配置完全相同。

## [S4] Overleaf — Algorithms
https://www.overleaf.com/learn/latex/Algorithms

介绍algpseudocode、algorithm和algorithm2e等体系，包含输入输出、行号、缩进、赋值和分支示例，并提醒不要同时加载冲突算法体系。本技能据此区分伪代码与正文散文，允许算法中使用必要数学表达。

## [S5] NeurIPS — Paper Checklist Guidelines
https://neurips.cc/public/guides/PaperChecklist

“Experiment Statistical Significance”一节要求对主要主张相关实验适当报告并解释误差条、区间或统计显著性信息，说明变异来源及标准差／标准误差等含义。这里作为透明统计报告的参考，不声称数学建模比赛都必须照搬NeurIPS检查表。

## [S6] Scientific Reports — Submission guidelines, Tables
https://www.nature.com/srep/author-instructions/submission-guidelines

要求提交可编辑的表格而不是图片；涉及统计分析的表需要在表说明中交代误差分析标准及范围。这里只援引这些内容，不引用该刊的页数／数量限制作为通用规范。

## 本技能独立提出的编辑建议

短引表句、少量关键比较、以同口径最佳值加粗、次优下划线可选、不要整行加粗、优先减少重复而非硬控字数、流程图与算法表分工，均作为本技能的明确建议。不是某个顶会／顶刊的统一强制风格。

示例中的所有结果数值均为虚构教学数据，不可用于实际论文结果。算法示例为完整的有限候选筛选规则，不代表某篇论文真实采用该方法，也不构成全局最优性声明。
