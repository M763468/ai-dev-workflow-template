# ai-dev-workflow-template

AI（Codex / Gemini / Jules など）を主戦力にして、**Issue駆動で安全に開発を回すためのGitHubテンプレート**です。

このテンプレートは次の原則で設計されています。

> **1 Issue = 1 AI implementation = 1 PR**

- 人間は「設計・Issue定義・レビュー」に集中する
- AIは「実装・軽量テスト・PR作成」を担当する

---

## これで何ができる？

このテンプレートを使うと、次が最短距離で整います。

- Goal / Scope / Acceptance Criteria を固定した Issue 運用
- AIに優しい PR テンプレ（関連Issue・スコープ・テストを強制）
- 「最初の10分」で迷わない初期化導線

---

## Quickstart（最初の10分）

以下だけで「理解 → 初期化 → テンプレ動作確認」まで到達できます。

### 0) テンプレからリポジトリを作成

GitHubの **Use this template** から新しいリポジトリを作成します。

### 1) ローカルにクローン

```bash
git clone <your-repo-url>
cd <your-repo-name>
```

### 2) 初期化スクリプトを実行

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

### 3) Issue / PR テンプレが効くことを確認

#### ブラウザで確認（確実）

- Issue: `https://github.com/<owner>/<repo>/issues/new/choose`
- PR: PR作成画面を開くとテンプレが自動で読み込まれます
- blank issue を許可する場合でも、まずはテンプレから作る運用を推奨します

#### CLIで確認（任意）

`gh` CLI が使える場合は、テンプレを指定してIssueを作成できます。

```bash
gh issue create --title "[Task] テンプレ動作確認" --body "テンプレ確認用" --template task.yml
```

---

## 使い方（運用フロー）

詳細は [docs/WORKFLOW.md](docs/WORKFLOW.md) を参照してください。
基本的な原則は **1 Issue = 1 AI implementation = 1 PR** です。

- [docs/WORKFLOW.md](docs/WORKFLOW.md): 全体設計と判断基準（ブランチ運用もここに記載）
- [docs/LABELS.md](docs/LABELS.md): ラベルの定義と標準
- [AGENTS.md](AGENTS.md): AIエージェントのための行動指針
- [docs/PROMPTS.md](docs/PROMPTS.md): プロンプト置き場（雛形）
- `skills/`: 共通Skills（リポジトリ固有の最適化は `.agents/skills`）

---

## テンプレ設計の意図（重要）

### Issueテンプレの意図

- AIが迷いがちな「スコープ逸脱」を防ぐ
- 入出力仕様（ファイル名 / パス）を固定する
- Acceptance Criteria を「契約書」として扱う

### PRテンプレの意図

- Related Issue（Closes #）の明示を強制
- Scope（In / Out）を再確認
- AI側チェック / 人間側チェックを分離

---

## よくある詰まりポイント

- AIが余計な機能を足す
  - IssueのScopeに「Out（やらないこと）」を明記する
- レビューで揉める
  - Acceptance Criteria をチェックリストで書く
- テンプレが出ない
  - 既存リポジトリに後から入れた場合は、デフォルトブランチへの反映を確認する

---

## 次にやると良い拡張（任意）

- `docs/LABELS.md` でラベル標準化
- `tools/` にレビュー支援スクリプトを追加
- `docs/DECISIONS.md` で設計判断ログを残す
