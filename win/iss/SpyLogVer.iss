#define protected FileHandle

#sub ProcessFileLine
  #define private FileLine = FileRead(FileHandle)
  #if pos('_VERSION', FileLine) != 0
    #define public SpyLogVer = Copy(FileLine, Pos('''', FileLine) + 1, RPos('''', FileLine) - Pos('''', FileLine) - 1 )
  #endif
#endsub

#for {FileHandle = FileOpen(SpyLogGit + "\src\lib\spylog\version.lua"); FileHandle && !FileEof(FileHandle); ""} \
  ProcessFileLine

#if FileHandle
  #expr FileClose(FileHandle)
#else
  #pragma warning "Can not open version file: " + SpyLogGit + "\src\lib\spylog\version.lua"
#endif

#ifndef SpyLogVer
  #pragma warning "Can not detect version. Use default one"
  #defin public SpyLogVer = "0.0.0"
#endif