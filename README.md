<div align="center">
  <img src="assets/logo.svg" width="80" height="80" alt="Model Tips Logo" />
  <h1>Antigravity 模型人话小抄 (Model Tips)</h1>
  <p><strong>零界面遮挡 · 敲 <code>/m</code> 秒弹「人话工种」气泡 · 自带后台静默更新与新模型自进化</strong></p>
</div>

---

Google 在 Gemini 4 系列启用了化学元素周期表命名（`Carbon`、`Neon`、`Hydrogen`、`Argon`），再加上列表中混排的 `Orchestrator`、`Claude 5.5` 等选项，每次切模型都容易犯选择困难症。

本插件不占用侧边栏、平时 **0 Token 消耗**，巧妙利用 Antigravity 输入框原生的 **`/` 斜杠悬浮菜单**，让你在切模型前随手敲下 **`/m`** 即可弹出整齐的中文人话速查卡。

## ✨ 一句话自动安装

不用懂代码，也不用开命令行，直接复制下面这句话发给你的 **Antigravity（反重力）**，它会自动完成安装并免重启生效（支持 macOS / Windows / Linux）：

```text
帮我安装这个模型小抄插件到全局插件目录：https://github.com/youyukongzhong/antigravity-model-tips
```

---

## 🔄 双层自动进化机制（装完一劳永逸）

1. **后台静默同步（0 额度消耗）**
   内置轻量 `SessionStart` 启动钩子，每 12 小时最多在后台静默执行一次 `git pull`（异步非阻塞、不调用大模型、不费一分钱 Token）。公共词库更新后自动无感升级。
2. **新模型自动感知 + `/m-sync` 本地自学（不依赖作者更新）**
   - 当你切换到一个小抄尚未收录的全新模型（例如未来发布的 `Gemini 4 Oxygen`）时，启动钩子会自动在聊天框顶部弹出一行轻量提示（不占 AI 上下文）；
   - 随时发送 **`/m-sync`**（或直接贴一张最新的模型菜单截图配 `/m-sync`），你本地的反重力会自动联网查询官方发布说明，按“职场工种”格式写入你本地独立的 `m-local-*` 词条目录——**即使作者停更，你的小抄也能自己进化，且与 GitHub 自动同步互不冲突**。

---

## 🤖 Agent Installation Guide (给 AI 助手执行的安装说明)

> When a user asks you (Antigravity / AI Agent) to install or update this plugin:
>
> 1. **Target Global Plugin Path** (must use directory name `model-tips` under the user's global Antigravity config):
>    - **macOS / Linux**: `~/.gemini/config/plugins/model-tips`
>    - **Windows (PowerShell)**: `$HOME\.gemini\config\plugins\model-tips`
> 2. **Install Command**:
>    - macOS / Linux: `mkdir -p ~/.gemini/config/plugins && git clone https://github.com/youyukongzhong/antigravity-model-tips.git ~/.gemini/config/plugins/model-tips`
>    - Windows (PowerShell): `New-Item -ItemType Directory -Force "$HOME\.gemini\config\plugins" | Out-Null; git clone https://github.com/youyukongzhong/antigravity-model-tips.git "$HOME\.gemini\config\plugins\model-tips"`
> 3. **Update Command** (if directory already exists):
>    - `git -C ~/.gemini/config/plugins/model-tips pull --ff-only` (or `"$HOME\.gemini\config\plugins\model-tips"` on Windows).
> 4. **No Restart Needed**: Antigravity discovers `~/.gemini/config/plugins/model-tips/plugin.json` and `hooks.json` automatically via live reload. Tell the user they can immediately type `/m` in the chat input box to see the floating model cheat sheet, or manage it at `[模型人话小抄 (Model Tips)](customization://model-tips)`.

---

## 📋 默认内置的模型人话速查表

| 斜杠项 | 对应模型 / 功能 | 人话工种定位 | 说明 |
| :--- | :--- | :--- | :--- |
| `/m` | **一句话总口诀** | 懒人总纲 | 日常主力挂 Neon · 啃硬骨头切 Carbon · 秒回杂活 Hydrogen · 文笔/前端找 Claude |
| `/m-neon` | **Gemini 4 Neon** | 全能主力骨干 | 速度与智商甜点位，日常 80% 写项目、改方案、理逻辑闭眼选它 |
| `/m-carbon` | **Gemini 4 Carbon** | 首席架构师 | 最重旗舰，专治疑难杂症、复杂架构设计与硬核 Bug |
| `/m-hydrogen` | **Gemini 4 Hydrogen** | 快手实习生 | 周期表第 1 号最轻最快，翻译、改格式、简单问答秒回 |
| `/m-orchestrator` | **Orchestrator** | 项目包工头 | 自动拆解大工程并分派执行，适合多步骤复杂任务 |
| `/m-claude` | **Claude Opus / Sonnet 5.5** | 顶尖外援 | Opus 死磕细节；Sonnet 中文网感文笔与前端 UI 审美极佳 |
| `/m-skip` | **Argon / 3.8 Flash / GPT-OSS** | 直接忽略 | 标注 `Leaving Soon` 即将退役或属开源尝鲜备胎，省下脑容量 |
| `/m-sync` | **自动识新与同步** | 自进化引擎 | 联网拉取更新，或识别菜单截图里的新模型自动写入本地 `/m` 小抄 |

---

## 📄 License

MIT License
