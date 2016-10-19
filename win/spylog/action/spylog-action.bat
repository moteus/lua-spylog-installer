:: Run SpyLog as console application

@echo off && setlocal

CD /D "$(APP)\action"

SET PATH=$(APP)\bin;%PATH%
SET LUA_INIT=
SET LUA_CPATH=!\..\lib\?.dll
SET LUA_PATH=!\..\lib\?.lua;!\..\lib\?\init.lua;!\..\action\lib\?.lua

start "SpyLog - Action" "$(APP)\bin\lua51.exe" main.lua
