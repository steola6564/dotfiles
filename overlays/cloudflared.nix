final: prev:
let
  ver = "2025.8.1";
  urlFor = system: {
    "x86_64-linux" =
      "https://github.com/cloudflare/cloudflared/releases/download/${ver}/cloudflared-linux-amd64";
  }.${system};
  shaFor = system: {
    "x86_64-linux" = "sha256-pmNTAEGX7kwfy2hUkgOCSIK7piN4rU0A0jS9uCUfERQ=";
  }.${system};
in {
  cloudflared-bin = final.stdenvNoCC.mkDerivation {
    pname = "cloudflared-bin";
    version = ver;

    src = final.fetchurl {
      url = urlFor final.stdenv.hostPlatform.system;
      sha256 = shaFor final.stdenv.hostPlatform.system;
    };

    dontUnpack = true;
    installPhase = ''
      install -Dm755 "$src" "$out/bin/cloudflared"
    '';

    meta = with final.lib; {
      description = "Cloudflare Tunnel daemon (prebuilt binary)";
      homepage = "https://developers.cloudflare.com/cloudflare-one/";
      license = licenses.unfree;
      platforms = [ "x86_64-linux" ];
      mainProgram = "cloudflared";
    };
  };
}

