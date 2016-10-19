-- Configuration file for LuaService

return {
  tracelevel = 7,
  name = "spylog_jail",
  display_name = "SpyLog - Jail",
  script = "main.lua",
  path      = '..\\bin',
  lua_init  = '',
  lua_cpath = '@!\\..\\lib\\?.dll',
  lua_path  = '@!\\..\\lib\\?.lua;'        ..
              '!\\..\\lib\\?\\init.lua;'   ..
              '!\\lib\\?.lua';
}
