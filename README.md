# 中学英単語 選定アプリ（GitHub Pages + Supabase）

候補語 **2,461件**（編集用の広めの一次案）を「採用・除外・保留」に分けるアプリです。PCとスマホで同じアカウントにログインすればクラウド同期します。候補には活用形・派生語・熟語・中学範囲を超える可能性のある語も含みます。**学習指導要領の正式な全語リストではありません。**

## 1. Supabaseの準備（無料枠で開始可能）
1. https://supabase.com でアカウント登録し、新規プロジェクトを作成します。
2. プロジェクトの **SQL Editor** を開き、`setup.sql` を貼り付けて実行します。
3. **Project Settings > API**（または Connect 画面）で **Project URL** と **publishable key / anon public key** を確認します。
4. `config.js` の `YOUR_SUPABASE_PROJECT_URL` と `YOUR_SUPABASE_PUBLISHABLE_KEY` を書き換えます。**secret key / service_role key は公開しないでください。**
5. **Authentication > Providers > Email** でメール認証を有効にします（既定で有効の場合があります）。メール確認が有効なら確認メールのリンクを開いてください。
6. **Authentication > URL Configuration** の Site URL / Redirect URLs に、公開するGitHub PagesのURL（例：`https://ユーザー名.github.io/リポジトリ名/`）を登録します。

## 2. GitHub Pagesに公開
1. GitHubで新しいリポジトリを作成します。
2. このフォルダ内の **`index.html`、`words.json`、`config.js`、`setup.sql`、`README.md`** をリポジトリのルートへアップロードしてCommitします。
3. **Settings > Pages > Build and deployment** で `Deploy from a branch`、`main`、`/(root)` を選択して保存します。
4. 表示されたURLをPC・スマホで開きます。初回は「新規登録」し、メール確認後にログインします。

## 3. 保存・同期について
- ボタンを押すとクラウドへ自動保存します。上部に「クラウドに保存済み」と出たことを確認してください。
- 通信エラー時は変更を端末内に一時保持し、オンライン復帰時に再送します。ブラウザのデータを消すと未送信分は失われます。
- 他端末での変更は「今すぐ同期」または画面へ戻ったときに取得します。**同時に両端末で同じ語を変更した場合は、最後にサーバーへ保存された操作が優先されます。**
- JSONでバックアップと復元、CSVで全判定を書き出せます。
- 同期にはインターネット接続が必要です。

## 注意
- GitHub Pages単体にはサーバー側の保存機能がないため、Supabaseを利用します。無料枠には利用制限があり、将来変更される場合があります。
- `config.js` の公開用キーは公開して問題ない設計ですが、**SQLのRLSポリシーが重要**です。`setup.sql` を必ず実行してください。
- パスワードを忘れた場合の再設定UIは未実装です。Supabaseの管理画面でユーザー管理ができます。
