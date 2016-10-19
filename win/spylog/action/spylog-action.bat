:: Run SpyLog as console application

@echo off && setlocal

SET PATH=..\bin;%PATH%
SET LUA_INIT=
SET LUA_CPATH=..\lib\?.dll
SET LUA_PATH=..\lib\?.lua;..\lib\?\init.lua;.\lib\?.lua

start "SpyLog - Action" ..\bin\lua51.exe main.lua
