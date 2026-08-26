---
name: stop-slop
description: 清除AI生成文本中的机器味，让文章读起来像真人写的。去除填充词、套路开头、em-dash狂魔、二元对比等AI痕迹。Use when cleaning up AI-written text, editing docs/READMEs/release notes to sound human, or removing AI tells from prose.
---

# Stop Slop — 去AI味

## What this does
Removes obvious AI-generated tells from prose without changing meaning or losing the author's voice. Makes text sound like a human wrote it.

## What to remove

### Filler phrases (delete entirely)
- "In today's rapidly evolving landscape..."
- "It is worth noting that..."
- "As we can see..."
- "Needless to say..."
- "It goes without saying..."
- "In conclusion..."
- "Furthermore/Moreover/Additionally" — use sparingly, replace with "And" or restructure
- 中文对应：值得注意的是、众所周知、由此可见、不言而喻、综上所述

### Throat-clearing openers (rewrite to start with substance)
- "I'd be happy to help you with that..." → just do it
- "That's a great question!" → don't say this
- "Let me walk you through..." → just explain
- 中文对应：好的，让我来帮你... / 这是个好问题... / 让我为你详细说明...

### Structural tells
- Em-dash overuse (—) → limit to 1 per paragraph max
- Binary contrasts ("Not X, but Y" / "It's not about A, it's about B") → rewrite
- Dramatic single-sentence paragraphs for emphasis → merge with context
- Overuse of colons for dramatic reveals → use naturally
- Overuse of bold/italic for emphasis → reduce by 80%

### AI cliché phrases
- "unlock the power of..."
- "take X to the next level"
- "game-changer"
- "supercharge your..."
- "harness the power of..."
- "seamlessly integrate"
- "cutting-edge" / "state-of-the-art"

## Scoring rubric (1-10 per dimension)
1. **Naturalness**: Does this sound like a human wrote it?
2. **Conciseness**: No filler, no fluff
3. **Voice**: Distinct personality, not generic
4. **Structure**: Varied sentence lengths, no formula
5. **Honesty**: No hype, no exaggeration

**Threshold**: If total < 35/50, mark for revision.

## Process
1. Read the original text
2. Identify all AI tells
3. Rewrite preserving meaning, removing slop
4. Show before/after for significant changes
5. Report final score
