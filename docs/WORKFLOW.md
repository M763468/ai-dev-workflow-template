# AI駆動OSS開発ワークフローまとめ（GitHub + gh + LLM）

本ドキュメントは、本リポジトリで実際に運用している **AIを主戦力にした開発フロー** を整理したものです。

対象読者:
- 個人開発 / OSS開発で AI（Jules / Codex / Gemini 等）を活用したい人
- GitHub UI を極力使わず、CLI中心で開発を回したい人

---

## 全体像（基本原則）

**1 Issue = 1 AI実装 = 1 Pull Request**

- 人間: 設計・Issue定義・レビュー・マージ判断
- AI: 実装・軽量テスト・PR作成

> AIは「作業者」、人間は「設計者 + 編集者」

---

## 0. 初期化（テンプレ適用直後の10分）

テンプレートから作成した直後は、まず次を実行します。

```bash
./scripts/init.sh
```

このスクリプトは以下を確認・初期化します。

- `gh` CLI の有無と認証状態
- Issue / PR テンプレなど必須ファイルの存在
- labels / milestones の初期セットアップ（冪等）

任意の初期Issueもまとめて作る場合は、次のように実行します。

```bash
./scripts/init.sh --with-issues
```

変更内容だけを確認したい場合は dry-run が便利です。

```bash
./scripts/init.sh --dry-run --repo <owner>/<repo>
```

---

## 1. `.github/` に置くべきもの

### 必須ファイル

- `.github/ISSUE_TEMPLATE/*.yml`
- `.github/pull_request_template.md`
- `docs/LABELS.md` (new)

The new `docs/LABELS.md` file serves as a "Label Dictionary" to standardize label usage across the project. For more details, refer to the file itself.

### pull_request_template.md（AI向け最適化）

- Related Issue（Closes #）を必須化
- Scope（In / Out）を明示
- AI側テスト / 人間側テストを分離

これにより:
- AIの先取り実装を防止
- レビュー時の確認点を最小化

---

## 2. Issueの立て方（AIに解かせる前提）

### Issueに必ず書く項目

- Goal（このIssueで達成すること）
- Scope（In / Out）
- Inputs / Outputs（パス・ファイル名を固定）
- CLI usage example
- Acceptance Criteria（チェックリスト）
- How to test
  - AI側確認
  - 人間側確認

> Acceptance Criteria = 契約書

---

## 3. AI（Jules等）にIssueを解かせる方法

### 基本手順

1. Issueを作成
2. 依存IssueがすべてCloseされていることを確認
3. `assign-to-jules` ラベルを付与

### 成功率を上げるコツ

- Issue本文以外の説明を極力しない
- 「A-3以降を実装しない」など禁止事項を明記
- 1 Issueずつ実行（並列にしない）

---

## 4. Julesが反応しないとき

- コメントは必ずしも再同期トリガーにならない

### 確実な方法

1. `assign-to-jules` ラベルを一度外す
2. 再度 `assign-to-jules` を付ける

> ラベル付与 = 明示的な開始イベント

---

## 5. gh CLI でのPR / Issue操作

### よく使うコマンド

```bash
# PR一覧
gh pr list

# PR詳細
gh pr view 13

# 差分（Files changed）
gh pr diff 13

# Issue本文
gh issue view 5
```

### コメント・操作

```bash
gh pr comment 13 --body "Please fix X"
gh pr merge 13 --squash
gh pr edit 13 --add-label assign-to-jules
```

---

## 6. PRレビューをAIにやらせる（自動化）

### 基本アイデア

1. ghで差分取得
2. LLMに diff + 要件を渡す
3. レビュー文章を生成
4. ghでPRにコメント

---

## 7. ローカル自動レビュー用スクリプト例

> ここは将来的な拡張ポイントです（現時点では未実装でもOK）。

```bash
# PR番号を指定してAIレビュー生成
./tools/review_pr.sh 13 codex

# そのままPRにコメント投稿
./tools/review_pr.sh 13 codex --post
```

このスクリプトは:
- `gh pr diff` で差分取得
- Codex / Gemini に diff を渡す
- マージ可否・修正点・改善案を生成

---

## 8. 実務での判断基準（重要）

- **設計ミス > 実装ミス**
- AIのコードは「下書き」
- マージ基準は Acceptance Criteria のみ

> コード品質は後で直せるが、I/O設計は後で直しにくい

---

## 9. この運用のメリット

- 実装スピードが爆発的に上がる
- 設計が自然に言語化される
- AIを複数切り替えても破綻しない
- private / OSS どちらでも使える

---

## 10. 推奨運用サイクル（まとめ）

```
Issue設計
  ↓
assign-to-jules
  ↓
PR作成
  ↓
AIレビュー（codex/gemini）
  ↓
人間レビュー
  ↓
merge
```

このループを淡々と回すだけで、
**AI主導でも破綻しない開発**が成立します。
