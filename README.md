# Codex CLI 数学建模工作流

这是当前 Codex CLI 使用的六阶段数模技能及其共享参考和专项技能。入口为 `1start-mathmodel`。

```text
1start-mathmodel → 2analysis-modeling → 3coding-visual
                 → 4drawio → 5writing → 6verity
```

阶段之间设有建模、结果、图示、写作和最终验收门禁。发现问题时回到产生问题的阶段，只更新受影响的下游产物。专项技能按需加载：流程图、算法机制图、三线表、图表公式正文衔接和论文叙事润色。

## 安装

在仓库根目录运行：

```bash
bash install.sh
```

默认安装到 `${CODEX_HOME:-$HOME/.codex}/skills`。安装脚本会在覆盖前备份同名技能目录。也可传入自定义目录：

```bash
bash install.sh /path/to/codex/skills
```

安装后在数模项目中使用 `$1start-mathmodel` 启动。已有项目可直接让 Codex 读取对应阶段技能和现有 `plan.md`、`todo.md`，无需重新初始化项目。

## 内容

- `skills/1start-mathmodel` 至 `skills/6verity`：六阶段主流程。
- `skills/_references`：数模规范参考。
- `skills/adaptive-academic-flowchart`、`sci-algorithm-drawio`：非数据图专项。
- `skills/math-modeling-text-object-integration`、`math-modeling-three-line-tables`、`paper-launch-polish`：论文写作专项。

比赛官方要求、用户指定模板和项目现有约定优先于本仓库的通用建议。
