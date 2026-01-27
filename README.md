# ai-dev-workflow-template

AI（Codex / Gemini / Jules など）を主戦力にして、**Issue駆動で安全に開発を回すためのGitHubテンプレート**です。

このテンプレートは次の原則で設計されています。

> **1 Issue = 1 AI implementation = 1 PR**

- 人間は「設計・Issue定義・レビュー」に集中する
- AIは「実装・軽量テスト・PR作成」を担当する

---

## このテンプレートについて

このテンプレートは、AIエージェントと人間が協調して開発を進めるための、Issue駆動開発ワークフローを提供します。
導入することで、以下のメリットがあります。

- **AIのスコープ逸脱防止**: IssueとPRのテンプレートにより、AIの作業範囲を明確にします。
- **導入の容易さ**: 新規・既存プロジェクト問わず、段階的に導入できます。
- **役割の明確化**: 人間とAIの役割分担を定義し、効率的な開発フローを確立します。

---

## 導入手順

### 新規プロジェクトでの導入手順 (Quickstart)

新しいリポジトリで最初からこのワークフローを導入する場合の手順です。
以下だけで「理解 → 初期化 → テンプレ動作確認」まで到達できます。

#### 1) テンプレからリポジトリを作成

GitHubの **Use this template** から新しいリポジトリを作成します。

#### 2) ローカルにクローン

```bash
git clone <your-repo-url>
cd <your-repo-name>
```

#### 3) 初期化スクリプトを実行

```bash
./scripts/init.sh
```

テンプレ関連ファイルの存在確認に加えて、`gh` CLI が使える場合は
labels / milestones（および任意の初期Issue）を初期化します。
より詳しい説明は次でも確認できます。

```bash
./scripts/check-templates.sh --help
```

```bash
./scripts/init_repo.sh --help
```

#### 4) Issue / PR テンプレが効くことを確認

- **ブラウザで確認（推奨）**:
  - Issue: `https://github.com/<owner>/<repo>/issues/new/choose`
  - PR: PR作成画面を開くとテンプレが自動で読み込まれます
- **CLIで確認（任意）**:
  - `gh issue create --template task.yml --title "Test" --body "Test"`
  - 例: `gh issue create --title "[Task] テンプレ動作確認" --body "テンプレ確認用" --template task.yml`

---

### 既存プロジェクトへの段階的導入手順

すでに動いているプロジェクトに導入する場合、まずこのテンプレートリポジトリを適当な場所に `git clone` してから、移植スクリプトを実行する形が最も簡単です。

```bash
# 1. テンプレートをクローン
https://github.com/M763468/ai-dev-workflow-template.git

# 2. 既存プロジェクトに移動
cd /path/to/your-project

# 3. 移植スクリプトを実行
/path/to/ai-dev-workflow-template/scripts/import.sh
```

このスクリプトは、テンプレのコア要素（`.github`, `docs`, `scripts`, `skills`, `AGENTS.md`）を安全にコピーします。
詳細は [docs/WORKFLOW.md](docs/WORKFLOW.md) を参照してください。

- `scripts/import.sh`: 既存プロジェクトへのテンプレファイル移植用
- `scripts/init.sh`: `import.sh` 実行後、または新規プロジェクトのGitHubリソース（labels, milestones）初期化用

#### Step 2: 一部のIssueで試験運用

影響の少ない、独立したIssue（例: `good first issue`, `docs`など）でAI開発フローを試します。
チームメンバーがプロセスに慣れることを目指します。

#### Step 3: 標準ワークフローとして定着

試験運用で効果が確認できたら、チームの標準開発フローとして正式に採用します。
プロジェクトの `CONTRIBUTING.md` や `README.md` から、このワークフローのドキュメント（`docs/WORKFLOW.md`）へリンクを貼ることを推奨します。

---

## ドキュメントの運用方針

このテンプレートに含まれるドキュメントと、あなたのプロジェクト固有のドキュメントが重複し、混乱を招くことを防ぐための方針です。
詳細は [docs/WORKFLOW.md](docs/WORKFLOW.md) を参照してください。基本的な原則は **1 Issue = 1 AI implementation = 1 PR** です。

### 推奨: 参照型 (Reference Model)

**プロジェクトの `README.md` や `CONTRIBUTING.md` から、このテンプレートの `docs/WORKFLOW.md` 等へリンクする** 運用です。
導入先で `docs/ai-workflow/` などにまとめる場合は、リンクをその置き場所に合わせて調整します。

- **メリット**:
  - 常に最新のテンプレート運用を参照できる
  - ドキュメントの二重管理を防げる
- **デメリット**:
  - プロジェクト固有のルールを追記しにくい

### 選択肢: 統合型 (Integrated Model)

テンプレートのドキュメントをプロジェクトの `docs` ディレクトリにコピーし、プロジェクトに合わせて改変・統合する運用です。

- **メリット**:
  - プロジェクト独自ルールを1箇所にまとめられる
- **デメリット**:
  - テンプレートの更新に追従しにくい

### 選択肢: 分離型 (Separated Model)

テンプレートはあくまで参考と割り切り、プロジェクト独自の開発フローとドキュメントを別途作成する運用です。

---

## 各ドキュメントの役割

| ファイル/ディレクトリ | 役割 |
|:---|:---|
| `README.md` (このファイル) | **全体像と導入手順**: テンプレートの目的、導入手順、ドキュメントの運用方針を説明する |
| `docs/WORKFLOW.md` | **具体的な開発フロー**: Issueの立て方からPRのマージまで、詳細な手順を解説 |
| `docs/LABELS.md` | **ラベル一覧**: IssueやPRで使うラベルの定義 |
| `AGENTS.md` | **AIエージェントへの指示書**: AIが守るべきルールや品質基準を定義 |
| `docs/PROMPTS.md` | **プロンプト集**: AIへの指示に使えるプロンプトの雛形 |
| `.github/` | **テンプレート**: Issue / PR のテンプレート |
| `scripts/` | **支援ツール**: 初期化やチェックのためのスクリプト |
| `skills/` | **配布用スキル**: 共通スキルの雛形 |
| `.agents/skills` | **運用スキル置き場**: エージェントが読み込むディレクトリ（推奨） |

---

## テンプレ設計の意図

### Issueテンプレの意図

- AIが迷いがちな「スコープ逸脱」を防ぐ
- 入出力仕様（ファイル名 / パス）を固定する
- Acceptance Criteria を「契約書」として扱う

### PRテンプレの意図

- Related Issue（Closes #）の明示を強制
- Scope（In / Out）を再確認
- AI側チェック / 人間側チェックを分離

---

## 次にやると良い拡張（任意）

- `docs/LABELS.md` でラベル標準化
- `tools/` にレビュー支援スクリプトを追加
- `docs/DECISIONS.md` で設計判断ログを残す
