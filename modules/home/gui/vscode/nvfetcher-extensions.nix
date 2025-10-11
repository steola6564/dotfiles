{ pkgs, generated }:

with pkgs.vscode-utils; [

  # === From existing repo ===
  (buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "evilz";
      name = "vscode-reveal";
      version = generated."evilz.vscode-reveal".version;
    };
    vsix = generated."evilz.vscode-reveal".src;
  })

  (buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "janisdd";
      name = "vscode-edit-csv";
      version = generated."janisdd.vscode-edit-csv".version;
    };
    vsix = generated."janisdd.vscode-edit-csv".src;
  })

  (buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "mattn";
      name = "Lisp";
      version = generated."mattn.lisp".version;
    };
    vsix = generated."mattn.lisp".src;
  })

  # === From nvfetcher.toml (validated via log) ===
  (buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "1yib";
      name = "svelte-bundle";
      version = generated."1yib.svelte-bundle".version;
    };
    vsix = generated."1yib.svelte-bundle".src;
  })

  (buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "fivethree";
      name = "vscode-svelte-snippets";
      version = generated."fivethree.vscode-svelte-snippets".version;
    };
    vsix = generated."fivethree.vscode-svelte-snippets".src;
  })

  (buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "yandeu";
      name = "five-server";
      version = generated."yandeu.five-server".version;
    };
    vsix = generated."yandeu.five-server".src;
  })

  (buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "ms-azuretools";
      name = "vscode-docker";
      version = generated."ms-azuretools.vscode-docker".version;
    };
    vsix = generated."ms-azuretools.vscode-docker".src;
  })

  (buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "ms-vscode-remote";
      name = "remote-containers";
      version = generated."ms-vscode-remote.remote-containers".version;
    };
    vsix = generated."ms-vscode-remote.remote-containers".src;
  })

  (buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "mechatroner";
      name = "rainbow-csv";
      version = generated."mechatroner.rainbow-csv".version;
    };
    vsix = generated."mechatroner.rainbow-csv".src;
  })

  (buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "ms-vsliveshare";
      name = "vsliveshare";
      version = generated."ms-vsliveshare.vsliveshare".version;
    };
    vsix = generated."ms-vsliveshare.vsliveshare".src;
  })

  (buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "marp-team";
      name = "marp-vscode";
      version = generated."marp-team.marp-vscode".version;
    };
    vsix = generated."marp-team.marp-vscode".src;
  })

  (buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "ritwickdey";
      name = "liveserver";
      version = generated."ritwickdey.liveserver".version;
    };
    vsix = generated."ritwickdey.liveserver".src;
  })

  (buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "openai";
      name = "chatgpt";
      version = generated."openai.chatgpt".version;
    };
    vsix = generated."openai.chatgpt".src;
  })

]

