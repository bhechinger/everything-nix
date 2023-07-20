{
  description = "Satellite";

  # {{{ Inputs
  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    # Nixpkgs-unstable
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # NUR
    nur.url = "github:nix-community/NUR";

    # Firefox addons
    firefox-addons.url = "git+https://gitlab.com/rycee/nur-expressions?dir=pkgs/firefox-addons";
    firefox-addons.inputs.nixpkgs.follows = "nixpkgs";

    # Agenix
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    # Homeage
    homeage.url = "github:jordanisaacs/homeage";
    homeage.inputs.nixpkgs.follows = "nixpkgs";

    # Grub2 themes
    grub2-themes.url = "github:vinceliuice/grub2-themes";
    grub2-themes.inputs.nixpkgs.follows = "nixpkgs";

    # Stylix
    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    stylix.inputs.home-manager.follows = "home-manager";

    # Catpuccin base16 color schemes
    catppuccin-base16.url = "github:catppuccin/base16";
    catppuccin-base16.flake = false;

    # Rosepine base16 color schemes
    rosepine-base16.url = "github:edunfelt/base16-rose-pine-scheme";
    rosepine-base16.flake = false;

    # Impermanence
    impermanence.url = "github:nix-community/impermanence";

    # Slambda
    slambda.url = "github:Mateiadrielrafael/slambda";
    slambda.inputs.nixpkgs.follows = "nixpkgs";

    # Neovim nightly
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    neovim-nightly-overlay.inputs.nixpkgs.follows = "nixpkgs";

    # Hyprland (available in nix unstable only atm)
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs-unstable";

    # Hyprland (available in nix unstable only atm)
    hyprland-contrib.url = "github:hyprwm/contrib";
    hyprland-contrib.inputs.nixpkgs.follows = "nixpkgs-unstable";

    # Contains a bunch of wayland stuff not on nixpkgs
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    nixpkgs-wayland.inputs.nixpkgs.follows = "nixpkgs-unstable";

    # Nix language server
    # [the docs](https://github.com/nix-community/nixd/blob/main/docs/user-guide.md#installation)
    # tell me not to override the nixpkgs input.
    nixd.url = "github:nix-community/nixd";

    # Spotify client
    spicetify-nix.url = "github:the-argus/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs-unstable";

    # Disko
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };
  # }}}

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      # {{{ Common helpers 
      inherit (self) outputs;
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      specialArgs = system: {
        inherit inputs outputs;
        # This is used so often it makes sense to have it as it's own thing
        upkgs = inputs.nixpkgs-unstable.legacyPackages.${system};
      };
      # }}}
    in
    {
      # {{{ Packages
      # Acessible through 'nix build', 'nix shell', etc
      packages = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./pkgs { inherit pkgs; }
      );
      # }}}
      # {{{ Bootstrapping and other pinned devshells
      # Acessible through 'nix develop'
      devShells = forAllSystems
        (system:
          let
            pkgs = nixpkgs.legacyPackages.${system};
            default = import ./shell.nix { inherit pkgs; };
            args = { inherit pkgs; } // specialArgs system;
            devshells = import ./devshells args;
          in
          devshells // { inherit default; });
      # }}}
      # {{{ Overlays and modules
      # Custom packages and modifications, exported as overlays
      overlays = import ./overlays;

      # Reusable nixos modules
      nixosModules = import ./modules/nixos // import ./modules/common;

      # Reusable home-manager modules
      homeManagerModules = import ./modules/home-manager // import ./modules/common;
      # }}}
      # {{{ Nixos
      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#...
      nixosConfigurations =
        let
          nixos = { system, hostname, user }: nixpkgs.lib.nixosSystem {
            specialArgs = specialArgs system;

            modules = [
              home-manager.nixosModules.home-manager
              {
                home-manager.users.${user} = import ./home/${hostname}.nix;
                home-manager.extraSpecialArgs = specialArgs system;
                home-manager.useUserPackages = true;
                stylix.homeManagerIntegration.followSystem = false;
                stylix.homeManagerIntegration.autoImport = false;
              }

              ./hosts/nixos/${hostname}
            ];
          };
        in
        {
          tethys = nixos {
            system = "x86_64-linux";
            hostname = "tethys";
            user = "wonko";
          };

          euporie = nixos {
            system = "x86_64-linux";
            hostname = "euporie";
            user = "guest";
          };

          newbob = nixos {
            system = "x86_64-linux";
            hostname = "newbob";
            user = "wonko";
          };
        };
      # }}}
      # {{{ Home manager
      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#...
      homeConfigurations =
        let
          mkHomeConfig = { system, hostname }:
            home-manager.lib.homeManagerConfiguration {
              pkgs = nixpkgs.legacyPackages.${system};
              extraSpecialArgs = specialArgs system;
              modules = [
                ./home/${hostname}.nix
              ];
            };
        in
        {
          "wonko@tethys" = mkHomeConfig {
            system = "x86_64-linux";
            hostname = "tethys";
          };
          "guest@euporie" = mkHomeConfig {
            system = "x86_64-linux";
            hostname = "euporie";
          };
          "wonko@newbob" = mkHomeConfig {
            system = "x86_64-linux";
            hostname = "newbob";
          };
        };
      # }}}
    };

  # {{{ Caching and whatnot
  # TODO: persist trusted substituters file
  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org" # I think I need this for neovim-nightly?
      "https://nixpkgs-wayland.cachix.org"
    ];

    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
    ];
  };
  # }}}
}
