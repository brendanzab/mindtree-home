# An expression producing an environment suitable for rust & nannou dev.
#
# `rustChannel` is a function where, given `pkgs.rust-bin` the specific channel
# version is returned. This allows for re-using the following code between
# stable rust and nightly rust environments.
#
# Test this file with
# ```
# nix-shell -E "(import ./rust-dev.nix) { rustChannel = rust-bin: rust-bin.stable.latest; }"
# ```
{ rustChannel }:
let
  # Provides `rust-bin` - a declarative alternative to rustup.
  rust-overlay = import (fetchTarball {
    url =
      "https://github.com/oxalica/rust-overlay/archive/462835d47b901e8d5b445642940de40f6344f4f3.tar.gz";
    sha256 = "0wjy48l5527za83hmhdlzzw805hy3skwp0w63a7z33ip33yi8sd8";
  });

  # Provide the overlay to nixpkgs.
  # TODO: Replace `<nixpkgs>` with pinned version (i.e. use a flake).
  pkgs = import <nixpkgs> { overlays = [ rust-overlay ]; };

  # Customised rust installation.
  # This can be thought of as a declarative alternative to rustup.
  # Aggregate of all default rust components (cargo, rustc, etc).
  # - "thumb*" targets used to target stm32f107 and stm32f407.
  rust = (rustChannel pkgs.rust-bin).default.override {
    extensions = [
      # Used for morph embedded stuff.
      "llvm-tools-preview"
      # Used for rust-gpu.
      "rustc-dev"
      "rust-src"
    ];
    targets = [
      # Used to target stm32f107 and stm32f407.
      "thumbv7em-none-eabihf"
      "thumbv7m-none-eabi"
    ];
  };

  # Use our custom rust installation to build the following rust crates.
  # If we were to just use `rustPlatform`, it would use its own rust version.
  #
  # (Currently no custom crates need building for inclusion, all are in nixpkgs)
  rust-platform = pkgs.makeRustPlatform {
    rustc = rust;
    cargo = rust;
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
    crate2nix
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
