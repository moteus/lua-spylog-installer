#define protected FileHandle

#sub ProcessFileLine
  #define private FileLine = FileRead(FileHandle)
  #if pos('_VERSION', FileLine) != 0
    #define public SpyLogVer = Copy(FileLine, Pos('''', FileLine) + 1, RPos('''', FileLine) - Pos('''', FileLine) - 1 )
  #endif
  #if pos('_NAME', FileLine) != 0
    #define public SpyLogName = Copy(FileLine, Pos('''', FileLine) + 1, RPos('''', FileLine) - Pos('''', FileLine) - 1 )
  #endif
  #if pos('_COPYRIGHT', FileLine) != 0
    #define public SpyLogCr = Copy(FileLine, Pos('''', FileLine) + 1, RPos('''', FileLine) - Pos('''', FileLine) - 1 )
  #endif
  #if pos('_URL', FileLine) != 0
    #define public SpyLogUrl = Copy(FileLine, Pos('''', FileLine) + 1, RPos('''', FileLine) - Pos('''', FileLine) - 1 )
  #endif
  #if pos('_LICENSE', FileLine) != 0
    #define public SpyLogLic = Copy(FileLine, Pos('''', FileLine) + 1, RPos('''', FileLine) - Pos('''', FileLine) - 1 )
  #endif
#endsub

#define private VerFileName = SpyLogGit + "\src\lib\spylog\version.lua"

#for {FileHandle = FileOpen(VerFileName); FileHandle && !FileEof(FileHandle); ""} ProcessFileLine

#if FileHandle
  #expr FileClose(FileHandle)
#else
  #pragma warning "Can not open version file: " + VerFileName
#endif

#ifndef SpyLogVer
  #pragma warning "Can not detect version. Use default one"
  #define public SpyLogVer = "0.0.0"
#endif

#ifndef SpyLogName
  #pragma warning "Can not detect name. Use default one"
  #define public SpyLogName = "SpyLog"
#endif

#ifndef SpyLogUrl
  #pragma warning "Can not detect URL. Use default one"
  #define public SpyLogUrl = "SpyLog"
#endif
