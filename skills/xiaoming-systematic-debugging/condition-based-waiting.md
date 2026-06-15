# 基于条件的等待 (Condition-Based Waiting)

## 概述

脆弱的测试常常用任意延迟来猜测时序。这会产生竞态条件 (race condition)，使测试在快速机器上通过，但在负载下或 CI 中失败。

**核心原则：** 等待你真正关心的条件，而不是猜测需要多长时间。

## 使用时机

```dot
digraph when_to_use {
    "测试使用 setTimeout/sleep？" [shape=diamond];
    "测试时序行为？" [shape=diamond];
    "记录为何需要超时" [shape=box];
    "使用基于条件的等待" [shape=box];

    "测试使用 setTimeout/sleep？" -> "测试时序行为？" [label="是"];
    "测试时序行为？" -> "记录为何需要超时" [label="是"];
    "测试时序行为？" -> "使用基于条件的等待" [label="否"];
}
```

**适用情形：**
- 测试有任意延迟（`setTimeout`、`sleep`、`time.sleep()`）
- 测试不稳定（有时通过，在负载下失败）
- 并行运行时测试超时
- 等待异步操作完成

**不适用情形：**
- 测试实际时序行为（防抖 (debounce)、节流 (throttle) 间隔）
- 如果使用任意超时，始终记录原因

## 核心模式

```typescript
// ❌ 之前：猜测时序
await new Promise(r => setTimeout(r, 50));
const result = getResult();
expect(result).toBeDefined();

// ✅ 之后：等待条件
await waitFor(() => getResult() !== undefined);
const result = getResult();
expect(result).toBeDefined();
```

## 快速模式

| 场景 | 模式 |
|----------|---------| 
| 等待事件 | `waitFor(() => events.find(e => e.type === 'DONE'))` |
| 等待状态 | `waitFor(() => machine.state === 'ready')` |
| 等待数量 | `waitFor(() => items.length >= 5)` |
| 等待文件 | `waitFor(() => fs.existsSync(path))` |
| 复杂条件 | `waitFor(() => obj.ready && obj.value > 10)` |

## 实现

通用轮询函数：
```typescript
async function waitFor<T>(
  condition: () => T | undefined | null | false,
  description: string,
  timeoutMs = 5000
): Promise<T> {
  const startTime = Date.now();

  while (true) {
    const result = condition();
    if (result) return result;

    if (Date.now() - startTime > timeoutMs) {
      throw new Error(`Timeout waiting for ${description} after ${timeoutMs}ms`);
    }

    await new Promise(r => setTimeout(r, 10)); // 每 10ms 轮询
  }
}
```

见此目录中的 `condition-based-waiting-example.ts`，了解带领域特定辅助函数（`waitForEvent`、`waitForEventCount`、`waitForEventMatch`）的完整实现，来自实际调试会话。

## 常见错误

**❌ 轮询过快：** `setTimeout(check, 1)` — 浪费 CPU
**✅ 修复：** 每 10ms 轮询

**❌ 无超时：** 如果条件永远不满足，会无限循环
**✅ 修复：** 始终包含带清晰错误信息的超时

**❌ 数据过期：** 在循环之前缓存状态
**✅ 修复：** 在循环内部调用 getter 以获取最新数据

## 任意超时确实正确的情形

```typescript
// 工具每 100ms 触发一次——需要 2 次触发来验证部分输出
await waitForEvent(manager, 'TOOL_STARTED'); // 首先：等待条件
await new Promise(r => setTimeout(r, 200));   // 然后：等待定时行为
// 200ms = 100ms 间隔的 2 次触发——有记录且有理由
```

**要求：**
1. 首先等待触发条件
2. 基于已知时序（而非猜测）
3. 注释说明为什么

## 真实影响

来自调试会话（2025-10-03）：
- 修复了 3 个文件中 15 个脆弱测试
- 通过率：60% → 100%
- 执行时间：快了 40%
- 不再有竞态条件 (race condition)
