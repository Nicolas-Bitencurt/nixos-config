  # Gerado por nixos-generate-config e ajustado à mão: discos por label, não por UUID.
  # Labels definidos no mkfs: BOOT (vfat), swap, nixos (ext4).
  { config, lib, pkgs, modulesPath, ... }:

  {
    imports =
      [ (modulesPath + "/profiles/qemu-guest.nix")
      ];

    boot.initrd.availableKernelModules = [ "uhci_hcd" "ehci_pci" "ahci" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" =
      { device = "/dev/disk/by-label/nixos";
        fsType = "ext4";
      };

    fileSystems."/boot" =
      { device = "/dev/disk/by-label/BOOT";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
      };

    swapDevices =
      [ { device = "/dev/disk/by-label/swap"; }
      ];

    networking.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  }
