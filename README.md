# dotfiles

## Summary
Hosts/configuration.nixから各Modules内のファイルを適宜インポート、もしそのホスト固有でしたい設定とModules内のファイルの設定が衝突するなら、Profiles内のファイルで衝突回避

## Tips
- home-managerはそのユーザーに入れたいもの、「自分しか使わない」「設定込みで育てたい」ツールはここに寄せると管理が楽
- environmentはシステム全体に入れいたいもの、OS（NixOS, Darwin, WSL）をまたいで「共通で揃えたいもの」、全ユーザーが使えると便利なもの

## The files will be deleted
- 

## Feture
- pkgsをcommon、gui、cli、と言った具合に環境ごのpkgsを意識してまとめる
- modules/pkgs/common.nixをgit,curl,neovim,home-manager等本当の意味でのcommonにし、darwin/configからpkgsをインポートできるようにする
