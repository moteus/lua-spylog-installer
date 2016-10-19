-- Configuration file for LuaService

return {
  tracelevel = 7,
  name = "spylog_action",
  display_name = "SpyLog - Action",
  script = "main.lua",
  path      = '..\\bin',
  lua_init  = '',
  lua_cpath = '@!\\..\\lib\\?.dll',
  lua_path  = '@!\\..\\lib\\?.lua;'        ..
              '!\\..\\lib\\?\\init.lua;'   ..
              '!\\lib\\?.lua';
}
