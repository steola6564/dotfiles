# secrets.nix
{
  # 例: cloudflared のトークンを暗号化するファイルを定義
  "cloudflared-credentials.age".publicKeys = [
    "age13sjyfypwvm375ywwvntkcyydwz5avrn6tkl9075dducwn6tym96qmhuf5p"
    "age1r36ddxgempjfyz6lly3zmnhut0svvt894phu55y72k4jfpqq4yzqpnkrnn"
  ];
  "tf-cloudflare.json.age".publicKeys = [
    "age13sjyfypwvm375ywwvntkcyydwz5avrn6tkl9075dducwn6tym96qmhuf5p"
    "age1r36ddxgempjfyz6lly3zmnhut0svvt894phu55y72k4jfpqq4yzqpnkrnn"
  ];
}

