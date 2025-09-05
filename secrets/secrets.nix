# secrets.nix
{
  # 例: cloudflared のトークンを暗号化するファイルを定義
  "cloudflared-credentials.age".publicKeys = [
    "age13sjyfypwvm375ywwvntkcyydwz5avrn6tkl9075dducwn6tym96qmhuf5p"
  ];
  "tf-cloudflare.json.age".publicKeys = [
    "age13sjyfypwvm375ywwvntkcyydwz5avrn6tkl9075dducwn6tym96qmhuf5p"
  ];
}

