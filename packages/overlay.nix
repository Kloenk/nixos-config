{ secrets }: self: super:
let
  upgrade = package: overrides:
  let
    upgraded = package.overrideAttrs overrides;
    upgradedVersion = (builtins.parseDrvName upgraded.name).version;
    originalVersion =(builtins.parseDrvName package.name).version;

    isDowngrade = (builtins.compareVersions upgradedVersion originalVersion) == -1;

    warn = builtins.trace
      "Warning: ${package.name} downgraded by overlay with ${upgraded.name}.";
    pass = x: x;
  in (if isDowngrade then warn else pass) upgraded;
in {
  autorandr-configs = self.callPackage ./autorandr-configs { };

  backlight = self.callPackage ./backlight { };

  bash-config = self.callPackage ./bash-config { };

  custom-emacs = self.callPackage ./emacs { };

  cnijfilter2 = super.cnijfilter2.overrideAttrs (x: {
    name = "cnijfilter2-5.60";
    src = self.fetchzip {
      url = "http://gdlp01.c-wss.com/gds/0/0100009490/01/cnijfilter2-source-5.60-1.tar.gz";
      sha256 = "0yagz840g28kz0cyy3abbv4h2imw1pia1hzsqacjsmvz4wdhy14k";
    };
  });

  dunst_config = self.callPackage ./dunst { };

  direnv = upgrade super.direnv (oldAttrs: {
    name = "direnv-2.19.2";
    version = "2.19.2";
    src = self.fetchFromGitHub {
      owner = "direnv";
      repo = "direnv";
      rev = "v2.19.2";
      sha256 = "1iq9wmc63x1c7g1ixdhd6q3w1sx8xl8kf1bprxwq26n9zpd0g13g";
    };
  });

  direnv-hook = self.callPackage ./direnv-hook { };

  font-b612 = self.callPackage ./b612-font { };

  gitconfig = self.callPackage ./gitconfig { };

  gnupgconfig = self.callPackage ./gnupgconfig { };

  h = self.callPackage ./h { };

  helvetica = self.callPackage ./helvetica { inherit secrets; };

  i3config = self.callPackage ./i3config { inherit secrets; };

  is-nix-channel-up-to-date = self.callPackage ./is-nix-channel-up-to-date { };

  did-graham-commit-his-repos = self.callPackage ./did-graham-commit-his-repos { };

  motd-massive = self.callPackage ./motd { };

  mutate = self.callPackage ./mutate { };

  nixosUnstablePkgs = self.callPackage ./nixos-unstable-packages { };

  nixpkgs-maintainer-tools = self.callPackage ./nixpkgs-maintainer-tools { };

  nixpkgs-pre-push = self.callPackage ./nixpkgs-pre-push { };

  passff-host = self.callPackage ./passff-host { };

  screenshot = self.callPackage ./screenshot { };

  systemd-lock-handler = self.callPackage ./systemd-lock-handler { };

  timeout_tcl = self.callPackage ./timeout { };

  volume = self.callPackage ./volume { };

  zsh-config = self.callPackage ./zsh-config { };
}
