:: Run SpyLog as console application

@echo off && setlocal

CD /D "$(APP)\filter"

SET PATH=$(APP)\bin;%PATH%
SET LUA_INIT=
SET LUA_CPATH=!\..\lib\?.dll
SET LUA_PATH=!\..\lib\?.lua;!\..\lib\?\init.lua;!\..\filter\lib\?.lua

start "SpyLog - Filter" "$(APP)\bin\lua51.exe" main.lua
