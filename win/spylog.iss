#define   Name       "SpyLog"
#define   Version    "0.0.1"
#define   Publisher  "Alexey Melnichuk"
#define   URL        "https://github.com/moteus/lua-spylog"
#define   Arch       "x86"
#define   LuaVer     "5.1"

[Setup]
AppId="SpyLog"

AppName={#Name}
AppVersion={#Version}
AppPublisher={#Publisher}
AppPublisherURL={#URL}
AppSupportURL={#URL}
AppUpdatesURL={#URL}

; ���� ��������� ��-���������
DefaultDirName={pf}\{#Name}
; ��� ������ � ���� "����"
DefaultGroupName={#Name}

; �������, ���� ����� ������� ��������� setup � ��� ������������ �����
OutputDir=.
OutputBaseFileName={#Name}-setup

; ���� ������
SetupIconFile=

; ��������� ������
Compression=lzma
SolidCompression=yes

; ����� ��� ��������� ������
PrivilegesRequired=admin

[Files]
; Common files
Source: "deps\{#Arch}\bin\*"; DestDir: "{app}\bin"; Components: Multi\Filter Multi\Jail Multi\Action SpyLog
Source: "deps\{#Arch}\{#LuaVer}\bin\*"; DestDir: "{app}\bin"; Components: Multi\Filter Multi\Jail Multi\Action SpyLog
Source: "deps\{#Arch}\{#LuaVer}\lib\*"; DestDir: "{app}\lib"; Components: Multi\Filter Multi\Jail Multi\Action SpyLog; Flags: recursesubdirs

; Bin for Filter
Source: "deps\{#Arch}\{#LuaVer}\bin\LuaService.exe"; DestDir: "{app}\filter"; Components: Multi\Filter
Source: "deps\{#Arch}\{#LuaVer}\bin\lua51.dll"; DestDir: "{app}\filter"; Components: Multi\Filter

; Bin for Jail
Source: "deps\{#Arch}\{#LuaVer}\bin\LuaService.exe"; DestDir: "{app}\jail"; Components: Multi\Jail
Source: "deps\{#Arch}\{#LuaVer}\bin\lua51.dll"; DestDir: "{app}\jail"; Components: Multi\Jail

; Bin for Action
Source: "deps\{#Arch}\{#LuaVer}\bin\LuaService.exe"; DestDir: "{app}\action"; Components: Multi\Action
Source: "deps\{#Arch}\{#LuaVer}\bin\lua51.dll"; DestDir: "{app}\action"; Components: Multi\Action

; Bin for SpyLog
Source: "deps\{#Arch}\{#LuaVer}\bin\LuaService.exe"; DestDir: "{app}\spylog"; Components: SpyLog
Source: "deps\{#Arch}\{#LuaVer}\bin\lua51.dll"; DestDir: "{app}\spylog"; Components: SpyLog

; Filter configuration
Source: "spylog\filter\init.lua"; DestDir: "{app}\filter"; Components: Multi\Filter
Source: "spylog\filter\spylog-filter.bat"; DestDir: "{app}\filter"; Components: Multi\Filter

; Jail configuration
Source: "spylog\jail\init.lua"; DestDir: "{app}\jail"; Components: Multi\Jail
Source: "spylog\jail\spylog-jail.bat"; DestDir: "{app}\jail"; Components: Multi\Jail

; Action configuration
Source: "spylog\action\init.lua"; DestDir: "{app}\action"; Components: Multi\Action
Source: "spylog\action\spylog-action.bat"; DestDir: "{app}\action"; Components: Multi\Action

; SpyLog configuration
Source: "spylog\spylog\init.lua"; DestDir: "{app}\spylog"; Components: SpyLog
Source: "spylog\spylog\spylog.bat"; DestDir: "{app}\spylog"; Components: SpyLog

; Common
Source: "..\spylog\src\lib\*"; DestDir: "{app}\lib"; Components: Multi\Filter Multi\Jail Multi\Action SpyLog; Flags: recursesubdirs
Source: "..\spylog\src\config\spylog.lua"; DestDir: "{app}\config"; Components: Multi\Filter Multi\Jail Multi\Action SpyLog

; Filter
Source: "..\spylog\src\filter\*"; DestDir: "{app}\filter"; Components: Multi\Filter SpyLog; Excludes: "init.lua"; Flags: recursesubdirs
Source: "..\spylog\src\config\sources\*"; DestDir: "{app}\config\sources"; Components: Multi\Filter SpyLog
Source: "..\spylog\src\config\filters\*"; DestDir: "{app}\config\filters"; Components: Multi\Filter SpyLog
 
; Jail
Source: "..\spylog\src\jail\*"; DestDir: "{app}\jail"; Components: Multi\Jail SpyLog; Excludes: "init.lua"; Flags: recursesubdirs
Source: "..\spylog\src\config\jails\*"; DestDir: "{app}\config\jails"; Components: Multi\Jail SpyLog

; Action
Source: "..\spylog\src\action\*"; DestDir: "{app}\action"; Components: Multi\Action SpyLog; Excludes: "init.lua"; Flags: recursesubdirs
Source: "..\spylog\src\config\actions\*"; DestDir: "{app}\config\actions"; Components: Multi\Action SpyLog

; SpyLog
Source: "..\spylog\src\spylog\*"; DestDir: "{app}\spylog"; Components: SpyLog; Excludes: "init.lua"; Flags: recursesubdirs

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

[Code]

#include "iss\services.iss"

procedure WinMessageError(msg : string);
var
  err : cardinal;
begin
  err := DLLGetLastError();
  MsgBox(msg + ': ' + IntToStr(err) + #13 + SysErrorMessage(err), mbError, MB_OK);
end;

procedure SpyLogInstallService(name:string);
var
  appPath, display, desc : String;
begin
  appPath := ExpandConstant('{app}') + '\' + name + '\LuaService.exe';

  if name = 'spylog' then display := 'SpyLog';
  if name = 'filter' then display := 'SpyLog - Filter';
  if name = 'jail'   then display := 'SpyLog - Jail';
  if name = 'action' then display := 'SpyLog - Action';

  if name = 'spylog' then desc := 'SpyLog service';
  if name = 'filter' then desc := 'SpyLog Filter service';
  if name = 'jail'   then desc := 'SpyLog Jail service';
  if name = 'action' then desc := 'SpyLog Action service';

  if name <> 'spylog' then name := 'spylog_' + name;

  if false = IsServiceInstalled(name) then begin
    if not InstallService( appPath, name, display, desc,
      SERVICE_WIN32_OWN_PROCESS, SERVICE_AUTO_START) then
    begin
      WinMessageError('Can not install ' + display + ' service')
    end
    else if not StartService(name) then begin
      WinMessageError('Can not start ' + display + ' service');
    end
  end
end;

procedure SpyLogUnInstallService(name:string);
var
  i : integer;
  display : String;
begin
  if name = 'spylog' then display := 'SpyLog';
  if name = 'filter' then display := 'SpyLog - Filter';
  if name = 'jail'   then display := 'SpyLog - Jail';
  if name = 'action' then display := 'SpyLog - Action';

  if name <> 'spylog' then name := 'spylog_' + name;
  
  if IsServiceInstalled(name) then begin
    i := 0;
    while IsServiceRunning(name) do begin
      inc(i);
      StopService(name);
      if i > 3 then break;
      if IsServiceRunning(name) then Sleep(20000);
    end;
    if IsServiceRunning(name) then
      WinMessageError('Can not stop ' + display + ' service')
    else if not RemoveService(name) then
      WinMessageError('Can not remove ' + display + ' service')
  end
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then begin
    if IsComponentSelected('SpyLog') then SpyLogInstallService('spylog')
    else begin
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
