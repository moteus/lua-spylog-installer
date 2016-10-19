:: Run SpyLog as console application

@echo off && setlocal

CD /D "$(APP)\jail"

SET PATH=$(APP)\bin;%PATH%
SET LUA_INIT=
SET LUA_CPATH=!\..\lib\?.dll
SET LUA_PATH=!\..\lib\?.lua;!\..\lib\?\init.lua;!\..\jail\lib\?.lua

start "SpyLog - Jail" "$(APP)\bin\lua51.exe" main.lua
