# Cockpit Passthrough

**Meta Quest 3 専用**の、シムレーシング向けパススルーアプリです。
PC の VR レースゲームを遊びながら、**ハンドルやシフターなど、コックピットの実物だけを見える**ようにします。

[ALVR](https://github.com/alvr-org/ALVR) をもとにした**非公式の改造版**です。ALVR の開発チームや Meta とは関係ありません。

- 見せたい範囲を**手でなぞって**決めます。範囲は空間に貼り付くので、頭を動かしてもずれません
- ハンドルは**ステアリング範囲**を設定します。回転軸に合わせて置くだけで、どれだけ回してもハンドルと握った手が形どおりに見えます
- ゲームの映像は ALVR と同じように PC から Wi-Fi で届きます

> このリポジトリには**配布物と説明書だけ**があります。プログラムのソースコードは含みません。

## ダウンロード

[**Releases**](../../releases) から最新の `Cockpit_Passthrough_YYYY-MM-DD.zip` をダウンロードしてください。
中身は次のとおりです。

| ファイル | 内容 |
|---|---|
| `1_Questにインストール.bat` | Quest にアプリを入れるバッチ |
| `apk/Cockpit_Passthrough_*.apk` | Quest 3 用アプリ本体 |
| `pc/alvr_streamer_windows.zip` | PC 用ストリーマー（ALVR 公式の開発版 v21.0.0-dev14 をそのまま同梱） |
| `はじめにお読みください.html` | 詳しい説明書（ブラウザで開いてください） |
| `licenses/` | ライセンス文書 |

## 必要なもの

- **Meta Quest 3**（Quest 3S は未確認。Quest 2 などではステアリング範囲が使えません）
- SteamVR が動く Windows PC
- PC と Quest が同じネットワーク（Quest は 5GHz／6GHz Wi-Fi 推奨）
- USB ケーブル（アプリを入れるときだけ）
- Quest の**開発者モード**（スマホの Meta Horizon アプリから ON にします）

## 使い方（概要）

1. zip を PC のローカルディスクに展開します
2. `1_Questにインストール.bat` をダブルクリックし、Quest を USB でつなぎます。ヘッドセット内で「USB デバッグを許可」を押してください
   - 初回だけ、通信に使う adb（Google の Android SDK Platform-Tools **r37.0.1**）を Google の公式サイトから取得します。版を固定し、SHA-256 でファイルを確認してから使います
3. PC で `pc/alvr_streamer_windows.zip` を展開し、`ALVR Dashboard.exe` を起動します
   - **公式の安定版 v20 系とは接続できません。**必ず同梱のストリーマーを使ってください
4. Quest で「Cockpit Passthrough」（ライブラリ →「提供元不明」）を起動し、ダッシュボードで Trust を押します
5. 座席で正面を再設定してから、左手の手のひらのメニューで範囲を作ります

詳しい手順と操作は、zip の中の `はじめにお読みください.html` を見てください。

## 保存について

- 窓もステアリング範囲も、**編集モードの「完了」を押したときだけ保存**されます。次に起動すると自動で出てきます
- 完了を押さずにアプリを終了すると、その回の編集は保存されません
- 新しい版をバッチで入れ直しても保存は残ります。アプリをアンインストールすると消えます

## 今の制限（テスト版）

- 範囲の位置はヘッドセットの**正面（センター）基準**です。**再起動や被り直しで位置がずれる**ので、そのつど座席で正面を再設定してください
- 範囲が見えるのはこのアプリの中だけです
- ステアリング範囲は、ハンドルを素早く回すと縁がわずかに遅れて付いてきます
- ステアリング範囲は、目から約 20cm より近い物や、黒くてつやのある物・金属・ガラスが苦手です
- 手の情報はゲームに送っていません（ハンドトラッキング前提のゲームは、ALVR の Multimodal tracking を ON にすれば使えます）
- 実機での確認は Quest 3 のみです

## ライセンス

- この改造版は、ALVR と同じ [MIT License](LICENSE) です。ALVR の著作権表示は [licenses/ALVR.txt](licenses/ALVR.txt) にあります
- ALVR が使っているライブラリのライセンスは [licenses/dependencies.html](licenses/dependencies.html) にあります
- アプリ内の日本語フォント Noto Sans JP は [SIL Open Font License 1.1](licenses/NotoSansJP-OFL.txt) です
- アプリに入っている OpenXR ローダー（Khronos・Meta・PICO・YVR。公式 ALVR と同じものを変更せず同梱）のライセンスは [licenses/OpenXR-loaders.txt](licenses/OpenXR-loaders.txt) と [licenses/Meta-OpenXR-SDK-Third-Party-Notices.txt](licenses/Meta-OpenXR-SDK-Third-Party-Notices.txt) にあります。Quest 3 で使うのは Khronos のものだけです
- 同梱のストリーマーは ALVR 公式のビルドをそのまま使っています。FFmpeg などのライセンスは、その zip の中の `licenses` フォルダにあります。FFmpeg は GPLv3 のため、ソースコードの入手先を [licenses/PC-streamer-sources.txt](licenses/PC-streamer-sources.txt) に記載しています
- adb は同梱していません。インストール時に Google から取得し、Google の利用規約が適用されます

本ソフトウェアは**無保証**です。使用によって生じたいかなる損害についても、作者および ALVR の著作権者は責任を負いません。
問い合わせは ALVR 公式ではなく、このリポジトリの Issues へお願いします。

Meta Quest は Meta Platforms, Inc. の、SteamVR は Valve Corporation の商標です。
