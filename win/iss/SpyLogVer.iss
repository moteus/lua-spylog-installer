#define protected

#define public SpyLogVer

#define FileHandle
#define FileLine
#sub ProcessFileLine
  #define FileLine = FileRead(FileHandle)
  #if pos('_VERSION', FileLine) != 0
    #define public SpyLogVer = Copy(FileLine, Pos('''', FileLine) + 1, RPos('''', FileLine) - Pos('''', FileLine) - 1 )
  #endif
#endsub
#for {FileHandle = FileOpen("..\spylog\src\lib\spylog\version.lua"); FileHandle && !FileEof(FileHandle); ""} \
  ProcessFileLine
#if FileHandle
  #expr FileClose(FileHandle)
#endif
