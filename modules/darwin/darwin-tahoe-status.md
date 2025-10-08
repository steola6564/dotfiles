# Nix Darwin Configuration Policy for macOS 26 “Tahoe”  
*(as of 2025-10-08)*

---

## 🎯 方針概要

macOS 26 “Tahoe” 以降、Apple はユーザー設定（特に Finder・Trackpad・Screenshot 関連）を  
従来の `/usr/bin/defaults` コマンドを介さず **InputDeviceSettings / UserPreferences Framework** で管理するよう変更した。  
この結果、`nix-darwin` の `system.defaults` で一部設定が反映されない状態が続いている。

当面の方針は以下の通り。

---

## 🧭 方針一覧

### 1. 宣言的整合性を優先
- macOS 側で非対応になった項目を Nix 側で無理に上書きしない。
- 一時的な shell script (`tmp-system.nix` 等) を利用せず、`system.nix` 内でコメントアウトして保持。
- コメント内に “macOS 26 で無効化中” などの文脈を明記。

### 2. GUI 設定との責務分離
- `system.defaults` で反映されない項目は macOS GUI で手動設定する。
- 手動設定後は `~/Library/Preferences/` 下に永続化されるため、再起動・再構築でも維持される。
- 具体的に GUI で操作すべき項目は以下。

| 設定項目 | 対応方法 | 備考 |
|-----------|-----------|------|
| マウスカーソル速度 | システム設定 → トラックパッド → ポインタの速度 | `com.apple.trackpad.scaling` 廃止 |
| トラックパッド「タップでクリック」 | システム設定 → トラックパッド → ポイントとクリック | `trackpad.Clicking` 無効化 |
| スクリーンショット保存先 | システム設定 → キーボードショートカット → スクリーンショット | `screencapture.location` 無効化 |
| Finder の表示形式 | Finder → 表示オプションを表示 → リスト表示設定を保存 | `FXPreferredViewStyle` 一部無効化 |

---

## 🧩 実装上の運用

### `modules/darwin/system.nix`
- 以下の項目をコメントアウトしておく：

```nix
# finder = {
#   FXPreferredViewStyle = "Nlsv";
# };

# screencapture.location = "/Users/steola/Pictures/ScreenShots";

# trackpad.Clicking = true;
```

- 旧来のトラックパッド速度設定もコメントアウト：

```nix
# system.activationScripts.setTrackpadScaling.text = ''
#   /usr/bin/defaults write -g com.apple.trackpad.scaling -float 7.5
# '';
```

- 上記コメントは残しておき、Apple 側の仕様が戻った際に簡単に復活できるようにする。

---

## 📘 ドキュメント構成
- `modules/darwin/system.nix`
→ 宣言的設定の本体。非対応箇所はコメント付きで保持。
- `modules/darwin/darwin-tahoe-status.md`
→ LLM / 開発者向けに、macOS 26 における nix-darwin 非対応領域を明記するメタドキュメント。LLM はこのファイルを参照して自動的に対応判断を行う。

---

## 🧠 運用ルール

1. macOS のアップデート後：
`darwin-tahoe-status.md` を確認し、該当項目が公式対応された場合はコメントを解除。
2. flake 更新時：
`nix flake update nix-darwin` 実行後、`darwin-rebuild switch --flake .#darwin-air` で再適用。
3. LLM 利用時：
本リポジトリを提示すれば、`darwin-tahoe-status.md` を自動参照し、現状の `nix-darwin` と macOS の互換状況を文脈的に判断可能。

---

## ✅ 結論
- 短期的対応：GUI で設定を保持し、Nix 側では該当箇所をコメント化。
- 中期的対応：`darwin-tahoe-status.md` をメタ情報として維持し、LLM に文脈判断を委譲。
- 長期的対応：Apple または `nix-darwin` が `InputDeviceSettings` に正式対応次第、コメント解除＋再宣言的構成に復帰。

---

Last updated: 2025-10-08
