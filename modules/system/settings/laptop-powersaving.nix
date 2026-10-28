{
  flake.modules.nixos.laptop-powersaving =
    { pkgs, ... }:
    {
      boot.kernelParams = [
        "pcie_aspm=force"
        "amdgpu.dcfeaturemask=0xB" # 0x2 (default) + 0x8 (PSR, panel self refresh) + 0x1 (FBC, frame buffer compression)
        # "amdgpu.visualconfirm=5" # temporary: draws on-screen indicator when PSR engages
      ];

      boot.kernel.sysctl = {
        "kernel.nmi_watchdog" = 0;
        "vm.dirty_writeback_centisecs" = 1500;
      };

      # temporarily enable model specific registers, to read
      hardware.cpu.x86.msr.enable = true;

      networking.networkmanager.wifi.powersave = true;

      powerManagement.powertop.enable = false;

      # PCI runtime PM: what powertop's "Runtime PM for PCI device" tunable
      # does (echo auto > /sys/bus/pci/devices/<dev>/power/control). Devices
      # in active use keep device refs and stay awake, idle ones (wifi, NVMe,
      # Sensor Fusion Hub, ...) may enter D3. Caveat: iwlwifi wake latency —
      # if that annoys, exclude it with a later rule:
      #   SUBSYSTEM=="pci", DRIVER=="iwlwifi", ATTR{power/control}="on"
      services.udev.extraRules = ''
        ACTION=="add", SUBSYSTEM=="pci", ATTR{power/control}="auto"
      '';

      # battery charge/power/voltage logger for idle-power debugging
      # log: /var/log/battery-power.log)
      systemd.services.battery-power-log = {
        description = "Battery charge/power/voltage logger for idle-power debugging";
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "simple";
          Restart = "on-failure";
          RestartSec = 30;
          Nice = 10;
          IOSchedulingClass = "idle";
          ExecStart = pkgs.writeShellScript "battery-power-log" ''
            LOG=/var/log/battery-power.log
            BAT=/sys/class/power_supply/BAT0
            until [ -e "$BAT/energy_now" ]; do sleep 10; done
            echo "# $(date '+%F %T') batlog-v2 start: energy_full=$(cat "$BAT/energy_full") uWh" >> "$LOG"
            while sleep 10; do
              # keep the log bounded at ~20 MB (keep the newest 2 MB)
              if [ "$(stat -Lc %s "$LOG" 2>/dev/null || echo 0)" -gt 20971520 ]; then
                tail -c 2097152 "$LOG" > "$LOG.tmp" && mv "$LOG.tmp" "$LOG"
              fi
              printf '%s %s st=%s e=%s p=%s u=%s\n' \
                "$(date +%s)" "$(date +%T)" \
                "$(cat "$BAT/status" 2>/dev/null || echo ERR)" \
                "$(cat "$BAT/energy_now" 2>/dev/null || echo ERR)" \
                "$(cat "$BAT/power_now" 2>/dev/null || echo ERR)" \
                "$(cat "$BAT/voltage_now" 2>/dev/null || echo ERR)" >> "$LOG"
            done
          '';
        };
      };
    };
}
