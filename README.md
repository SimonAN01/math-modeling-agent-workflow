# 通用智能体数学建模工作流

这是面向各种智能体、代理框架和人工协作环境的六阶段数模工作流。它采用普通 Markdown 技能文件、项目台账和命令行脚本，不依赖某一家智能体产品。入口为 `1start-mathmodel`；也可以把每个阶段文件转换成目标平台的提示词、规则文件或工具说明。

```text
1start-mathmodel → 2analysis-modeling → 3coding-visual
                 → 4drawio → 5writing → 6verity
```

阶段之间设有建模、结果、图示、写作和最终验收门禁。发现问题时回到产生问题的阶段，只更新受影响的下游产物。专项技能按需加载：流程图、算法机制图、三线表、图表公式正文衔接和论文叙事润色。

## 使用与适配

最简单的方式是把本仓库作为项目参考目录，让智能体按阶段读取相应的 `SKILL.md`。不同平台可按自己的约定安装或导入：

```bash
# 例：复制到某个平台的技能目录
bash install.sh /path/to/agent/skills
```

`install.sh` 只是一个可选的目录复制脚本，不是工作流运行所必需的。默认目标是 `${AGENT_SKILLS_DIR:-$HOME/.local/share/agent-skills}`；也可传入自定义目录。目标平台不支持 `SKILL.md` 时，直接把文件内容纳入该平台的 system prompt、project rules 或 agent instructions。

```bash
bash install.sh /path/to/agent/skills
```

启动阶段使用 `skills/1start-mathmodel/SKILL.md`。已有项目可直接读取相应阶段技能和现有 `plan.md`、`todo.md`，无需重新初始化项目。平台没有子代理、联网或命令执行能力时，跳过不可用动作并在报告中记录；不要把平台工具名称当成数学建模要求。

## 内容

- `skills/1start-mathmodel` 至 `skills/6verity`：六阶段主流程。
- `skills/_references`：数模规范参考。
- `skills/adaptive-academic-flowchart`、`sci-algorithm-drawio`：非数据图专项。
- `skills/math-modeling-text-object-integration`、`math-modeling-three-line-tables`、`paper-launch-polish`：论文写作专项。

比赛官方要求、用户指定模板和项目现有约定优先于本仓库的通用建议。仓库中的 `allowed-tools`、特定工具名和安装路径均不是工作流必需条件；适配器应将它们映射到目标平台的等价能力，或明确标记为不可用。
