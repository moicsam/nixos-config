{ config, pkgs,  ... }:
{
  environment.systemPackages = with pkgs; [
    dnsmasq
    spice-vdagent
  ];

  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  programs.virt-manager.enable = true;
  hardware.graphics.enable = true;
}
