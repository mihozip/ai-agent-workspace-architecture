# 別讓 AI Agent 靠記憶開發：我如何把專案改造成可續接的持久化架構

使用 Codex、AGY 或其他 Coding Agent 開發一段時間後，我慢慢發現一個問題：真正讓大型 AI 開發失控的，往往不是模型不夠聰明，而是「工作狀態沒有被妥善保存」。

一個開發工作可能持續數小時，甚至跨好幾天。中間可能遇到用量限制、Terminal 關閉、Context Reset、換模型、換 Agent，或只是隔天重新打開專案。這時如果所有上下文都只存在上一段對話裡，新的 Agent 就只能重新猜：做到哪裡了？哪些已經完成？哪些規則不能破壞？下一步應該做什麼？

所以我開始把問題反過來想：**AI Agent 的記憶，不應該主要存在對話裡，而應該存在 Repository 裡。**

這就是這套架構的起點。

## 從 Conversation State 轉成 Repository State

一般使用 AI 寫程式時，很容易形成這種模式：

```text
對話紀錄
  ↓
AI 記得前面做過什麼
  ↓
繼續工作
```

這種方式在短任務很好用，但專案一大就開始脆弱。只要 Session 中斷，Agent 就得重新建立上下文。

我後來把專案拆成四個核心檔案：

```text
AGENTS.md
STATE.md
TODO.md
docs/CONTINUATION.md
```

再視需要增加：

```text
.agents/rules/
```

每一個檔案只負責一件事情。

### AGENTS.md：長期不變的工作規則

`AGENTS.md` 不是專案百科，也不是進度紀錄，而是 Agent 每次工作都應知道的核心規則，例如技術棧、不可破壞的資料契約、安全邊界、驗證方式、部署限制，以及 Session Start / Resume Protocol。

原則很簡單：**短、穩定、長期有效。**

如果 `AGENTS.md` 裡塞進幾百行資料字典、API 規格、工作歷史，它就會變成昂貴的常駐 Context。因此詳細規則應拆出去。

### STATE.md：現在到底做到哪裡

`STATE.md` 是專案的狀態快照，而不是開發日誌。

它回答幾個問題：

- 現在的主要目標是什麼？
- 架構目前長什麼樣子？
- 哪些重要里程碑已完成？
- 現在正在做什麼？
- 有哪些已知問題？
- 下一步大致往哪裡走？

如此，即使換一個全新的 Agent，也可以很快知道「現在在哪裡」。

### TODO.md：下一步做什麼

`TODO.md` 則刻意與 `STATE.md` 分開。

`STATE.md` 說明狀態；`TODO.md` 管理行動。

我通常只保留：

```text
Current
Next
Later
Blocked
```

而且不讓它無限累積歷史。真正完成的歷史交給 Git，TODO 只保留還有行動價值的工作。

### CONTINUATION.md：Session 中斷後怎麼回來

第四個檔案是 `docs/CONTINUATION.md`。

它定義中斷恢復 SOP，例如：

```text
讀 AGENTS.md
↓
讀 STATE.md
↓
讀 TODO.md
↓
檢查 Git / Working Tree
↓
確認未提交修改
↓
驗證既有成果
↓
找到第一個未完成工作
↓
繼續
```

這讓「恢復」本身也變成一個標準工作流，而不是每次臨時跟 AI 解釋。

## 詳細規則不必全部常駐

大型專案常有完整資料字典、API Contract、部署 SOP、權限矩陣、Migration 規則。如果全部塞進 `AGENTS.md`，每個工作回合都要帶著大量無關 Context。

因此我再加一層：

```text
.agents/rules/
├── data-contracts.md
├── api-contracts.md
└── deployment.md
```

核心 invariant 留在 `AGENTS.md`；只有特定工作才需要的深層知識，改成按需載入。

這個差異很重要：

> `AGENTS.md` 告訴 Agent「永遠不能忘記什麼」；  
> `.agents/rules/` 告訴 Agent「做到這類工作時，再來讀什麼」。

## 多專案工作區再多一層治理

如果最上層資料夾包含很多彼此獨立的專案，就不能把整個資料夾當成一個專案。

我採用兩層架構：

```text
Workspace Governance Layer
│
├── AGENTS.md
├── STATE.md
├── TODO.md
└── PROJECT_AGENT_STANDARD.md

Project Layer
│
├── AGENTS.md
├── STATE.md
├── TODO.md
├── docs/CONTINUATION.md
└── .agents/rules/
```

Workspace 層只管共同安全、專案路由、Agent 協作原則與專案標準；真正的功能狀態、資料結構與待辦，全部回到各自 Project。

這可以避免最危險的一件事：**Agent 把 A 專案的 Context、資料庫規則或部署方式套到 B 專案。**

## 我最後只留下兩個啟動語句

架構完成後，我希望日常操作越簡單越好。

進入專案：

```bash
cd my-project
codex
```

然後只輸入：

```text
啟動專案
```

Agent 會執行 Read-only Startup：

1. 讀取 `AGENTS.md`
2. 讀取 `STATE.md`
3. 讀取 `TODO.md`
4. 檢查 Repository / Git 狀態
5. 找出目前最高優先級任務
6. 回報 Project Startup Brief
7. 停下來等待下一個指令

如果我已經確定要直接接續工作，就輸入：

```text
啟動專案並繼續
```

差別只有一個：前者先報告再停，後者在確認沒有 blocker 後，可以繼續 Current TODO。

## 這套架構真正解決的不是 Token，而是可恢復性

一開始我只是想解決 Coding Agent 的長時間使用限制。但整理到最後，我發現更核心的問題其實不是五小時、Token 或某一個模型的限制，而是：

**專案能不能在失去上一段對話之後，仍然被重新理解。**

理想狀況下，即使原本的 Session 完全消失，只要 Repository 還在：

```text
AGENTS.md
STATE.md
TODO.md
Git
Tests
```

新的 Agent 就能重新建立足夠的 Context。

這代表我們不再把「AI 記得多少」當成開發可靠性的基礎，而是把專案本身設計成可被 Agent 重新讀懂、重新驗證、重新接手。

我把這套可重用的範本整理成 GitHub 專案，裡面包含 Workspace 與 Project 兩層的 `AGENTS.md`、`STATE.md`、`TODO.md`、`CONTINUATION.md`、條件式 rules 範例，以及一個快速建立新專案架構的 bootstrap script。

它不是某一套框架，也不限定 GAS、PHP、React、Laravel 或 Python；它比較像一個「AI Agent 開發專案的狀態治理層」。

真正的目的只有一句話：

> **不要讓 Agent 靠聊天記憶工作，讓 Repository 本身成為可以持續交接的工作現場。**
