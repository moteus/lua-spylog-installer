JAIL{"fail-access";
  enabled  = true;
  filter   = {"rdp-fail-access", "fusionpbx-fail-access", "radmin-fail-access"};
  findtime = 300;
  maxretry = 4;
  bantime  = 600;
  action   = {"ipsec", {"mail", {unban=false}}};
}
