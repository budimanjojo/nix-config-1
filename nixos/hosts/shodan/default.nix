# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{ config
, lib
, pkgs
, ...
}: {
  mySystem.purpose = "Homelab";
  mySystem.services = {
    openssh.enable = true;
    podman.enable = true;
    traefik.enable = true;

    gatus.enable = true;
    homepage.enable = true;
    # backrest.enable = true;

    plex.enable = true;
    tautulli.enable = true;
    syncthing.enable = true;
    searxng.enable = true;
    factorio.freight-forwarding.enable = true; # the factory must grow
    whoogle.enable = true;

    redlib.enable = true;


  };

  mySystem.nfs.nas.enable = true;
  mySystem.persistentFolder = "/persistent";
  mySystem.system.motd.networkInterfaces = [ "enp1s0" ];

  boot = {

    initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];

    # for managing/mounting ntfs
    supportedFilesystems = [ "ntfs" ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      # why not ensure we can memtest workstatons easily?
      # TODO check whether this is actually working, cant see it in grub?
      grub.memtest86.enable = true;

    };
  };

  networking.hostName = "durandal"; # Define your hostname.
  networking.hostId = "0a90730f";
  networking.useDHCP = lib.mkDefault true;

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/2e843998-f409-4ccc-bc7c-07099ee0e936";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/12CE-A600";
      fsType = "vfat";
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/0ae2765b-f3f4-4b1a-8ea6-599f37504d70"; }];

}