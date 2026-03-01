{
  # Environment Variables and PATH Configuration
  home.sessionVariables = {
    # Tool-specific variables
    BUN_INSTALL = "$HOME/.bun";
    PNPM_HOME = "$HOME/.pnpm";
    GOPATH = "$HOME/.go";
    DOTNET_ROOT = "/usr/local/share/dotnet";
    MODULAR_HOME = "$HOME/.modular";
  };

  home.sessionPath = [
    # Development Tools & SDKs
    "$HOME/.local/share/mise/shims" # Mise
    "$HOME/.modular/pkg/packages.modular.com_mojo/bin" # Modular Mojo
    "$HOME/.ghcup/bin" # Haskell
    "$HOME/.progate/bin" # Progate Path
    "$HOME/.go/bin" # Go Bin (using $HOME/.go instead of $GOPATH for path)
    "$HOME/.bun/bin" # Bun Bin

    # .NET
    "/usr/local/share/dotnet"
  ];
}
