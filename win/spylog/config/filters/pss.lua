local ENABLED = true

-- date
local D = "^(%d%d%d%d%-%d%d%-%d%d %d%d:%d%d:%d%d) !%d+! %d+>"
-- variable
local V = "[^%]]*"
-- skip
local S = "%[" .. V .. "%]"
-- capture
local C = "%[(" .. V .. ")%]"

FILTER{ "pss-auth-request";
  enabled = ENABLED and false;
  source  = "pss";
  exclude = WHITE_IP;
  hint    = "auth request";
  failregex = {
    D .. " %S+ auth request %S+ %S+ " .. S .. " from " .. C .. "" .. S .. " for user " .. S .. " login " .. S .. " number " .. S .. " cause " .. S;
  };
}

FILTER{ "pss-auth-fail";
  enabled = ENABLED and false;
  source  = "pss";
  exclude = WHITE_IP;
  hint    = "auth request";

  failregex = {
    D .. " %S+ auth request fail %S+ " .. S .. " from " .. C .. "" .. S .. " for user " .. S .. " login " .. S .. " number " .. S .. " cause " .. S;
  };

  ignoreregex = {
    "cause %[9%]";
    "cause %[11%]";
    "cause %[15%]";
    "cause %[20%]";
  };
}

FILTER{ "pss-route-request";
  enabled = ENABLED and true;
  source  = "pss";
  exclude = WHITE_IP;
  hint    = "Route request from";
  capture = {'date', 'host', 'number', 'user'};
  failregex = {
    D .. " Route request from ".. C .." VPN: %d+ E164Number ".. C .." Ani " .. S .. " UserID ".. C;
  }
}

FILTER{ "pss-call-end";
  enabled = ENABLED and true;
  source  = "pss";
  exclude = WHITE_IP;
  hint    = "call end from";
  capture = {'date', 'host', 'user', 'number', 'duration'};
  failregex = {
    D .. " call end from ".. C .. "" .. S .. " for user ".. C .." number ".. C .." duration ".. C;
  };

  ignoreregex = {
    "duration %[0%]";
  };
}
