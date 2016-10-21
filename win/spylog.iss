#ifndef SpyLogGit
#define SpyLogGit "..\spylog"
#endif

#ifndef Arch
#define Arch       "x86"
#endif

#ifndef LuaVer
#define LuaVer     "5.1"
#endif

#ifndef Version

#include "iss\SpyLogVer.iss"

#if SpyLogVer
#define   Version    SpyLogVer
#else
#define   Version    "0.0.1"
#endif

#endif

#define   Name       "SpyLog"
#define   Publisher  "Alexey Melnichuk"
#define   URL        "https://github.com/moteus/lua-spylog"
#define   LuaShortVer StringChange(LuaVer, ".", "")

[Setup]
AppId={#Name}

AppName={#Name}
AppVersion={#Version}
AppPublisher={#Publisher}
AppPublisherURL={#URL}
AppSupportURL={#URL}/issues
AppUpdatesURL={#URL}

DefaultDirName={pf}\{#Name}
DefaultGroupName={#Name}

OutputDir=.
OutputBaseFileName={#Name}-{#Arch}-{#Version}

SetupIconFile=

Compression=lzma
SolidCompression=yes

; We install Services
PrivilegesRequired=admin

#if Arch=="x64"
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode={#Arch}
#endif

[Files]
; Backup current configs
Source: "{app}\config\*"; DestDir: "{app}\backup\{code:InstDate}"; Flags: external skipifsourcedoesntexist recursesubdirs

; Common files
Source: "deps\{#Arch}\bin\*"; DestDir: "{app}\bin"; Components: Multi\Filter Multi\Jail Multi\Action SpyLog
Source: "deps\{#Arch}\{#LuaVer}\bin\*"; DestDir: "{app}\bin"; Components: Multi\Filter Multi\Jail Multi\Action SpyLog
Source: "deps\{#Arch}\{#LuaVer}\lib\*"; DestDir: "{app}\lib"; Components: Multi\Filter Multi\Jail Multi\Action SpyLog; Flags: recursesubdirs

; Bin for Filter
Source: "deps\{#Arch}\{#LuaVer}\bin\LuaService.exe"; DestDir: "{app}\filter"; Components: Multi\Filter
Source: "deps\{#Arch}\{#LuaVer}\bin\lua*.dll"; DestDir: "{app}\filter"; Components: Multi\Filter

; Bin for Jail
Source: "deps\{#Arch}\{#LuaVer}\bin\LuaService.exe"; DestDir: "{app}\jail"; Components: Multi\Jail
Source: "deps\{#Arch}\{#LuaVer}\bin\lua{#LuaShortVer}.dll"; DestDir: "{app}\jail"; Components: Multi\Jail

; Bin for Action
Source: "deps\{#Arch}\{#LuaVer}\bin\LuaService.exe"; DestDir: "{app}\action"; Components: Multi\Action
Source: "deps\{#Arch}\{#LuaVer}\bin\lua{#LuaShortVer}.dll"; DestDir: "{app}\action"; Components: Multi\Action

; Bin for SpyLog
Source: "deps\{#Arch}\{#LuaVer}\bin\LuaService.exe"; DestDir: "{app}\spylog"; Components: SpyLog
Source: "deps\{#Arch}\{#LuaVer}\bin\lua{#LuaShortVer}.dll"; DestDir: "{app}\spylog"; Components: SpyLog

; Filter configuration
Source: "spylog\filter\init.lua"; DestDir: "{app}\filter"; Components: Multi\Filter
Source: "spylog\filter\spylog-filter.bat"; DestDir: "{app}\filter"; Components: Multi\Filter; AfterInstall: ProcessStartBat

; Jail configuration
Source: "spylog\jail\init.lua"; DestDir: "{app}\jail"; Components: Multi\Jail
Source: "spylog\jail\spylog-jail.bat"; DestDir: "{app}\jail"; Components: Multi\Jail; AfterInstall: ProcessStartBat

; Action configuration
Source: "spylog\action\init.lua"; DestDir: "{app}\action"; Components: Multi\Action
Source: "spylog\action\spylog-action.bat"; DestDir: "{app}\action"; Components: Multi\Action; AfterInstall: ProcessStartBat

; SpyLog configuration
Source: "spylog\spylog\init.lua"; DestDir: "{app}\spylog"; Components: SpyLog
Source: "spylog\spylog\spylog.bat"; DestDir: "{app}\spylog"; Components: SpyLog; AfterInstall: ProcessStartBat

; Common
Source: "{#SpyLogGit}\src\lib\*"; DestDir: "{app}\lib"; Components: Multi\Filter Multi\Jail Multi\Action SpyLog; Flags: recursesubdirs
Source: "{#SpyLogGit}\src\config\spylog.lua"; DestDir: "{app}\config"; Components: Multi\Filter Multi\Jail Multi\Action SpyLog

; Filter
Source: "{#SpyLogGit}\src\filter\*"; DestDir: "{app}\filter"; Components: Multi\Filter SpyLog; Excludes: "init.lua"; Flags: recursesubdirs
Source: "{#SpyLogGit}\src\config\sources\*"; DestDir: "{app}\config\sources"; Components: Multi\Filter SpyLog
Source: "{#SpyLogGit}\src\config\filters\*"; DestDir: "{app}\config\filters"; Components: Multi\Filter SpyLog
 
; Jail
Source: "{#SpyLogGit}\src\jail\*"; DestDir: "{app}\jail"; Components: Multi\Jail SpyLog; Excludes: "init.lua"; Flags: recursesubdirs
Source: "{#SpyLogGit}\src\config\jails\*"; DestDir: "{app}\config\jails"; Components: Multi\Jail SpyLog

; Action
Source: "{#SpyLogGit}\src\action\*"; DestDir: "{app}\action"; Components: Multi\Action SpyLog; Excludes: "init.lua"; Flags: recursesubdirs
Source: "{#SpyLogGit}\src\config\actions\*"; DestDir: "{app}\config\actions"; Components: Multi\Action SpyLog

; SpyLog
Source: "{#SpyLogGit}\src\spylog\*"; DestDir: "{app}\spylog"; Components: SpyLog; Excludes: "init.lua"; Flags: recursesubdirs

[Components]
Name: "Multi"; Description: "Install SpyLog as several services"; Flags: exclusive
Name: "Multi\Filter"; Description: "SpyLog Filter service"; Types: Multi
Name: "Multi\Jail"; Description: "SpyLog Jail service"; Types: Multi
Name: "Multi\Action"; Description: "SpyLog Action service"; Types: Multi
Name: "SpyLog"; Description: "Install SpyLog as Single service"; Types: Single; Flags: exclusive

[Dirs]
Name: "{app}\bin"
Name: "{app}\lib"
Name: "{app}\filter"
Name: "{app}\jail"
Name: "{app}\action"
Name: "{app}\spylog"
Name: "{app}\config"
Name: "{app}\backup"
Name: "{app}\config\filters"
Name: "{app}\config\jails"
Name: "{app}\config\actions"
Name: "{app}\filter\logs"
Name: "{app}\jail\logs"
Name: "{app}\action\logs"
Name: "{app}\action\data"
Name: "{app}\spylog\logs"
Name: "{app}\spylog\data"

[Types]
Name: "Multi"; Description: "Multi service installation"
Name: "Single"; Description: "Single service installation"
Name: "Custom"; Description: "Custom installation"; Flags: iscustom

[UninstallDelete]
Type: files; Name: "{app}\filter\logs\*"
Type: files; Name: "{app}\jail\logs\*"
Type: files; Name: "{app}\action\logs\*"
Type: files; Name: "{app}\action\data\*"
Type: files; Name: "{app}\spylog\logs\*"
Type: files; Name: "{app}\spylog\data\*"

[Code]

#include "iss\FileReplaceString.iss"
#include "iss\services.iss"

[Code]

function InstDate(Param: String): String;
begin
  Result := GetDateTimeString('yyyy.mm.dd_hh.nn.ss', #0, #0);
end;

procedure ProcessStartBat();
begin
  ReplaceStringInCurFile('$(APP)', '{app}');
  ReplaceStringInCurFile('lua51.exe', 'lua{#LuaShortVer}.exe');
end;

procedure WinMessageError(msg : string);
var
  err : cardinal;
begin
  err := DLLGetLastError();
  MsgBox(msg + ': ' + IntToStr(err) + #13 + SysErrorMessage(err), mbError, MB_OK);
end;

function SpyLogServiceName(name:string) : string;
begin
  if name = 'spylog' then Result := 'SpyLog';
  if name = 'filter' then Result := 'SpyLog - Filter';
  if name = 'jail'   then Result := 'SpyLog - Jail';
  if name = 'action' then Result := 'SpyLog - Action';
end;

function SpyLogStopService(name : string) : boolean;
var
  i : integer;
begin
  if name <> 'spylog' then name := 'spylog_' + name;

  i := 0;
  while IsServiceRunning(name) do begin
    inc(i);
    StopService(name);
    if i > 3 then break;
    if IsServiceRunning(name) then Sleep(20000);
  end;

  Result := not IsServiceRunning(name);
end;

procedure SpyLogInstallService(name:string);
var
  appPath, display, desc : String;
begin
  appPath := ExpandConstant('{app}') + '\' + name + '\LuaService.exe';

  display := SpyLogServiceName(name);

  if name = 'spylog' then desc := 'SpyLog service';
  if name = 'filter' then desc := 'SpyLog Filter service';
  if name = 'jail'   then desc := 'SpyLog Jail service';
  if name = 'action' then desc := 'SpyLog Action service';

  if name <> 'spylog' then name := 'spylog_' + name;

  if not IsServiceInstalled(name) then begin
    if not InstallService( appPath, name, display, desc, SERVICE_WIN32_OWN_PROCESS, SERVICE_AUTO_START) then
    begin
      WinMessageError('Can not install ' + display + ' service')
    end
  end;

  if not StartService(name) then begin
    WinMessageError('Can not start ' + display + ' service');
  end;
end;

procedure SpyLogUnInstallService(name:string);
var
  svc, display : String;
begin
  display := SpyLogServiceName(name);

  if name <> 'spylog' then svc := 'spylog_' + name else svc := name;
  
  if IsServiceInstalled(svc) then begin
    if not SpyLogStopService(name) then
      WinMessageError('Can not stop ' + display + ' service')
    else if not RemoveService(svc) then
      WinMessageError('Can not remove ' + display + ' service')
  end
end;

function InitializeSetup(): Boolean;
begin
  Result := true
  if not SpyLogStopService('spylog') then begin
    Result := false;
    WinMessageError('Can not stop ' + SpyLogServiceName('spylog') + ' service')
  end;

  if not SpyLogStopService('filter') then begin
    Result := false;
    WinMessageError('Can not stop ' + SpyLogServiceName('filter') + ' service')
  end;

  if not SpyLogStopService('jail') then begin
    Result := false;
    WinMessageError('Can not stop ' + SpyLogServiceName('jail') + ' service')
  end;
  
  if not SpyLogStopService('action') then begin
    Result := false;
    WinMessageError('Can not stop ' + SpyLogServiceName('action') + ' service')
  end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then begin
    if IsComponentSelected('SpyLog') then begin
      SpyLogUnInstallService('filter');
      SpyLogUnInstallService('jail');
      SpyLogUnInstallService('action');

      SpyLogInstallService('spylog')
    end
    else if IsComponentSelected('Multi') then begin
      SpyLogUnInstallService('spylog');

      if IsComponentSelected('Multi\Filter') then SpyLogInstallService('filter');
      if IsComponentSelected('Multi\Jail')   then SpyLogInstallService('jail');
      if IsComponentSelected('Multi\Action') then SpyLogInstallService('action');
    end
  end
end;

procedure CurUninstallStepChanged(CurStep: TUninstallStep);
begin
  if CurStep = usUninstall then begin
    SpyLogUnInstallService('filter');
    SpyLogUnInstallService('jail');
    SpyLogUnInstallService('action');
    SpyLogUnInstallService('spylog');
  end
end;
