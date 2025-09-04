# secrets.nix
{
  # 例: cloudflared のトークンを暗号化するファイルを定義
  "secrets/cloudflared-credentials.age".publicKeys = [
    "age1qtz46wq8phnhzhxw0re8zvekzwkku54dwysu2dmy84cu2gc5ds4szwtynm"
  ];
}

