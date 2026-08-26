---
name: skill-creator
description: 创建、测试和改进 OpenCode Skills (SKILL.md)。Use when creating new skills, improving existing skills, or converting workflows into reusable SKILL.md files.
---

# Skill Creator — 技能创建者

## 触发场景
- "创建一个 skill..."
- "把这个流程做成 skill"
- "改进/测试这个 skill"
- "写一个 SKILL.md"

## SKILL.md 规范

### 必需结构
```markdown
---
name: skill-name          # 1-64字符，小写字母+连字符，匹配文件夹名
description: 做什么 + 何时触发  # 1-1024字符，这是最重要的字段
---

# 技能标题

## 何时使用
- 触发条件 1
- 触发条件 2

## 指令
[详细指令，越具体越好]

## 示例
[实际输入输出示例]
```

### 关键规则
1. **description 决定触发率** — 必须同时包含"做什么"和"触发词"
   - ❌ "代码审查工具"
   - ✅ "审查代码中的bug、安全问题、风格问题。当用户要求review代码、检查PR或发现问题时使用"
2. **文件夹名 = skill name** — 严格一致
3. **body 控制在 500 行以内** — 超出的放 references/ 目录渐进加载
4. **具体 > 抽象** — "检查SQL注入" 比 "检查安全问题" 好 10 倍
5. **一个技能只做一件事** — 不要混合代码审查 + 测试生成 + 部署

### 进阶技巧
- `references/` 目录存放补充资料（仅在需要时加载）
- `scripts/` 目录存放辅助脚本
- `metadata` 字段可记录作者、版本、分类
- `license` 字段标注许可协议

## 创建流程
1. 与用户确认技能的目标和范围
2. 撰写 SKILL.md（遵循上述规范）
3. 创建文件夹 `~/.config/opencode/skills/{name}/`
4. 写入 SKILL.md
5. 告知用户如何验证（重启 OpenCode 后用 `skill` 工具查看）
