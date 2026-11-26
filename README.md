<div align="center">
  <img src="assets/logo.svg" width="80" height="80" alt="Model Tips Logo" />
  <h1>Antigravity 模型人话小抄 (Model Tips)</h1>
  <p><strong>零界面遮挡 · 免重启热加载 · 敲 <code>/m</code> 秒弹各模型「人话工种」悬浮气泡</strong></p>
</div>

---

Google 在 Gemini 4 系列启用了化学元素周期表命名（`Carbon`、`Neon`、`Hydrogen`、`Argon`），再加上列表中混排的 `Orchestrator`、`Claude 5.5` 等选项，每次切模型都容易犯选择困难症。

本插件不占用侧边栏、不跑任何后台进程，巧妙利用 Antigravity 输入框原生的 **`/` 斜杠悬浮菜单**，让你在切模型前随手敲下 **`/m`** 即可弹出整齐的中文人话速查卡。

## ✨ 一句话自动安装（推荐）

不用敲命令行，直接复制下面这句话发给你的 **Antigravity（反重力）**，它会自动完成安装并立即生效（支持 macOS / Windows / Linux）：

```text
帮我把这个 GitHub 仓库克隆安装到我的 Antigravity 全局插件目录（~/.gemini/config/plugins/model-tips）：https://github.com/youyukongzhong/antigravity-model-tips
```

日后模型列表更新时，只需对 Antigravity 说一句：
```text
帮我更新一下 model-tips 模型小抄插件
```

---

## 🤖 Agent Installation Guide (给 AI 助手执行的安装说明)

> When a user asks you (Antigravity / AI Agent) to install or update this plugin:
>
> 1. **Target Global Plugin Path** (must use directory name `model-tips` under the user's global Antigravity config):
>    - **macOS / Linux**: `~/.gemini/config/plugins/model-tips`
>    - **Windows (PowerShell)**: `$HOME\.gemini\config\plugins\model-tips`
> 2. **Install Command**:
>    - Ensure parent folder `~/.gemini/config/plugins` exists, then run:
>      - macOS / Linux: `git clone https://github.com/youyukongzhong/antigravity-model-tips.git ~/.gemini/config/plugins/model-tips`
>      - Windows (PowerShell): `New-Item -ItemType Directory -Force "$HOME\.gemini\config\plugins" | Out-Null; git clone https://github.com/youyukongzhong/antigravity-model-tips.git "$HOME\.gemini\config\plugins\model-tips"`
> 3. **Update Command** (if directory already exists):
>    - `git -C ~/.gemini/config/plugins/model-tips pull` (or `"$HOME\.gemini\config\plugins\model-tips"` on Windows).
> 4. **No Restart Needed**: Antigravity discovers `~/.gemini/config/plugins/model-tips/plugin.json` automatically via live reload. Tell the user they can immediately type `/m` in the chat input box to see the floating model cheat sheet, or manage it at `[模型人话小抄 (Model Tips)](customization://model-tips)`.

---

## 💡 两种使用姿势

1. **纯看悬浮气泡（不发消息）**
   在聊天输入框敲 **`/m`**，上方原生悬浮菜单会立即弹出总口诀及每个模型的人话定位；扫一眼后按退格键删掉 `/m`，直接点左下角切换模型即可，平时界面 **0 像素遮挡**。
2. **回车智能选型**
   输入 **`/m + 你接下来要做的任务`**（例如：`/m 我要排查一个很深的并发死锁 Bug`），AI 会直接用一句话建议你切哪个模型最划算。

---

## 📋 当前收录的模型人话速查表

| 斜杠项 | 对应模型 | 人话工种定位 | 适用场景 |
| :--- | :--- | :--- | :--- |
| `/m` | **一句话总口诀** | 懒人总纲 | 日常主力挂 Neon · 啃硬骨头切 Carbon · 秒回杂活 Hydrogen · 文笔/前端找 Claude |
| `/m-neon` | **Gemini 4 Neon** | 全能主力骨干 | 速度与智商甜点位，日常 80% 写项目、改方案、理逻辑闭眼选它 |
| `/m-carbon` | **Gemini 4 Carbon** | 首席架构师 | 最重旗舰，专治疑难杂症、复杂架构设计与硬核 Bug |
| `/m-hydrogen` | **Gemini 4 Hydrogen** | 快手实习生 | 周期表第 1 号最轻最快，翻译、改格式、简单问答秒回 |
| `/m-orchestrator` | **Orchestrator** | 项目包工头 | 自动拆解大工程并分派执行，适合多步骤复杂任务 |
| `/m-claude` | **Claude Opus / Sonnet 5.5** | 顶尖外援 | Opus 死磕细节；Sonnet 中文网感文笔与前端 UI 审美极佳 |
| `/m-skip` | **Argon / 3.8 Flash / GPT-OSS** | 直接忽略 | 标注 `Leaving Soon` 即将退役或属开源尝鲜备胎，省下脑容量 |

---

## 📄 License

MIT License
