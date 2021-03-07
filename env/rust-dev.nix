# An expression producing an environment suitable for rust & nannou dev.
let
  # Provides `rust-bin` - a declarative alternative to rustup.
  rust-overlay = import (fetchTarball {
    url =
      "https://github.com/oxalica/rust-overlay/archive/24a0f16207369d0a8a295e2b69a1b29ad319b427.tar.gz";
    sha256 = "0a072f7n0r4zyrkrgd5rp188s005idnj99h2dl6yy9ixc44sr88y";
  });

  # Provide the overlay to nixpkgs.
  # TODO: Replace `<nixpkgs>` with pinned version (i.e. use a flake).
  pkgs = import <nixpkgs> { overlays = [ rust-overlay ]; };

  # Customised rust installation.
  # This can be thought of as a declarative alternative to rustup.
  # Aggregate of all default rust components (cargo, rustc, etc).
  rust = pkgs.rust-bin.stable."1.50.0".rust.override {
    extensions = [ "llvm-tools-preview" ];
    targets = [ "thumbv7em-none-eabihf" "thumbv7m-none-eabi" ];
  };

  # Use our custom rust installation to build the following rust crates.
  # If we were to just use `rustPlatform`, it would use its own rust version.
  rust-platform = pkgs.makeRustPlatform {
    rustc = rust;
    cargo = rust;
  };

  cargo-binutils = with pkgs;
    rust-platform.buildRustPackage rec {
      pname = "cargo-binutils";
      version = "0.3.3";
      src = fetchCrate {
        inherit pname version;
        sha256 = "02pqahggcj1kg8yacrvmnkir9n3xw96cjhq024c9p5gw5sz7xhnn";
      };
      cargoSha256 = "1bzi3qkj0d9c1h7rxlcjy80ql3ba0drpq3744cmyrxa58q81b2qw";
    };

  cargo-embed = with pkgs;
    rust-platform.buildRustPackage rec {
      pname = "cargo-embed";
      version = "0.10.1";
      src = fetchCrate {
        inherit pname version;
        sha256 = "1s6qwsqrr9y7hdpn23k2vcic19j4zbwisbxyp8bi7qc68329hf44";
      };
      nativeBuildInputs = [ pkg-config ];
      buildInputs = [ libusb ];
      cargoSha256 = "129ad52v4k52sxi5gbx9660lmlz3ahwvj8cyjacwpr7zfw14sydf";
    };

  cargo-flash = with pkgs;
    rust-platform.buildRustPackage rec {
      pname = "cargo-flash";
      version = "0.10.2";
      src = fetchCrate {
        inherit pname version;
        sha256 = "1mxy3d7f78w137rg1sr8rgsik5dvzyb8h7lli500d1hzafnin7hq";
      };
      nativeBuildInputs = [ pkg-config ];
      buildInputs = [ libusb ];
      cargoSha256 = "1y20zrywwsra4y3ph9rj2q0f7bwsinhkgyh5ms551zccl97z8c4r";
    };

in with pkgs;
stdenv.mkDerivation {
  name = "rust-dev-env";
  buildInputs = [
    # Commonly required libs and tools.
    alsaLib
    binutils
    cargo-binutils # Necessary for embedded targets.
    cargo-bloat # What occuppies binary size?
    cargo-deps # visualise dep graph
    cargo-embed
    cargo-flash
    cargo-generate # wasm tute
    cmake
    gcc
    gnumake
    graphviz # visualise dep graph (cargo-deps)
    kcachegrind
    libftdi1 # A lib for communicating with FTDI chips, currently necessary to compile probe-rs.
    libGL # For camera_capture example.
    libv4l # video4linux
    libudev
    libusb # For compiling probe-rs.
    nodejs # For Rust+JS+WASM dev.
    openssl
    pkgconfig
    python3
    renderdoc
    rust
    rust-bindgen
    shaderc
    valgrind
    vulkan-loader
    vulkan-validation-layers
    xorg.libxcb
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr
    wasm-pack # For building, testing, publishing rust-generated wasm.
  ];

  LD_LIBRARY_PATH =
    "${vulkan-loader}/lib:${xorg.libX11}/lib:${xorg.libXcursor}/lib:${xorg.libXi}/lib:${xorg.libXrandr}/lib:${libGL}/lib:$LD_LIBRARY_PATH";
  ALSA_LIB_DEV = "${alsaLib.dev}";
  SHADERC_LIB_DIR = "${shaderc}/lib";
}
