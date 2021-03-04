{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    (arduino.override { withTeensyduino = true; })
    teensyduino
  ];
}
