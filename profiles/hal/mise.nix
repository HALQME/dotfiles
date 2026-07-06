{...}: {
  xdg.configFile."mise/config.toml".text = ''
    [settings]
    experimental = true
  '';
}
