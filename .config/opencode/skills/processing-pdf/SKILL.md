---
name: processing-pdf
description: 读取、提取和分析PDF文件内容。支持学术论文、扫描文档、报告等多种PDF格式。Use when reading PDFs, extracting text from PDFs, analyzing PDF documents, or working with PDF papers.
---

# PDF 处理器

## 触发场景
- 用户上传或提及 PDF 文件
- "帮我读一下这个 PDF"
- "从这篇论文中提取..."
- "分析这个 PDF 文档"

## 工作流程

### 1. 确认文件
- 确认 PDF 文件路径
- 如果是 arXiv 论文，优先使用 arxiv MCP (`arxiv_read_paper`) 获取文本
- 如果用户粘贴 PDF 内容，直接处理该内容

### 2. 读取与提取
- 使用 `read` 工具读取 PDF（OpenCode 支持 PDF 读取）
- 对扫描版 PDF（图片），使用 `look_at` 提取信息
- 对大文件分段处理，避免上下文溢出

### 3. 分析模板

#### 学术论文
参考 `paper-translator` skill 的结构化解读模板

#### 一般文档
```
## 文档概要
- 标题、作者、日期
- 文档类型（报告/手册/合同/...）
- 一句话摘要

## 关键内容
### 章节 1: {标题}
要点

### 章节 2: {标题}
要点

## 关键发现/行动项
```

#### 数据表格
- 提取表格为 Markdown 表格格式
- 标注数据来源页码
- 若有数值，提供单位

### 4. 输出格式
- 默认回复用户所用语言
- 保持原文关键术语
- 精确引用页码/行号
