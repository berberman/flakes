{ pkgs, lib, ... }:
with lib;
let
  cfg = config.services.luoxu;
  user = "luoxu";
  group = "luoxu";
  state = "/var/lib/luoxu";
in {
  options.services.luoxu = {
    enable = mkEnableOption "luoxu";
    package = mkPackageOption pkgs "luoxu";
    pgroongaPackage = mkPackageOption pkgs "pgroonga_2_4_5";
    configFile = mkOption {
      type = types.path;
      description = "Path to the luoxu config file";
    };
  };
  config = mkIf cfg.enable {

    users.users.${user} = {
      isSystemUser = true;
      home = state;
      createHome = true;
      inherit group;
    };

    users.groups.${group} = { };

    services.postgresql = {
      enable = true;
      ensureDatabases = [ "luoxu" ];
      ensureUsers = [{
        name = user;
        ensurePermissions."DATABASE luoxu" = "ALL PRIVILEGES";
      }];
      initialScript = pkgs.writeText "luoxu-init" ''
        \c luoxu;
        CREATE EXTENSION pgroonga;
        \i ${cfg.package}/share/luoxu/dbsetup.sql
      '';
    };

    systemd.services.luoxu = {
      description = "luoxu";
      wantedBy = [ "multi-user.target" ];
      after = [ "postgresql.service" ];
      serviceConfig = {
        Type = "simple";
        User = user;
        Group = group;
        ExecStart = "${cfg.package}/bin/luoxu --config ${cfg.configFile}";
        Restart = "always";
        RestartSec = "10";
        WorkingDirectory = state;
      };
    };
  };

}
