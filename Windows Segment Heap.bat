@echo off
color b
cls
:: Getting Admin Permissions https://stackoverflow.com/questions/1894967/how-to-request-administrator-access-inside-a-batch-file
echo Checking for Administrative Privelages...
timeout /t 3 /nobreak > NUL
IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

if '%errorlevel%' NEQ '0' (
    goto UACPrompt
) else ( goto GotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:GotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
	
	
chcp 65001 >nul

cls

goto Menu

:Menu
color b
cls
echo %z%Do you want to use Windows Segment Heap ?%q%
echo.
echo %i%Enable (Could be useful) = 1%q%
echo.
echo %i%Disable (Default) = 2%q%
echo.
echo %i%Per-Applications Segment Heap Manager (Could be useful) = 3%q%
echo.
echo %i%Disabling Windows Segment Heap for Certain Apps (Incompatible ones) = 4%q%
color b
set choice=
set /p choice=
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto EnableWindowsSegmentHeap
if '%choice%'=='2' goto DisableWindowsSegmentHeap
if '%choice%'=='3' goto PerAppsWindowsSegmentHeap
if '%choice%'=='4' goto IncmptblPpsWdnSgmntHpStstd

:IncmptblPpsWdnSgmntHpStstd
color b
cls
echo Disabling Segment Heap for unstable apps
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\vrmonitor.exe" /v "FrontEndHeapDebugOptions" /t REG_DWORD /d "0x04" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\vrserver.exe" /v "FrontEndHeapDebugOptions" /t REG_DWORD /d "0x04" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\vrwebhelper.exe" /v "FrontEndHeapDebugOptions" /t REG_DWORD /d "0x04" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\steamvr.exe" /v "FrontEndHeapDebugOptions" /t REG_DWORD /d "0x04" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\vrcompositor.exe" /v "FrontEndHeapDebugOptions" /t REG_DWORD /d "0x04" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\vrdashboard.exe" /v "FrontEndHeapDebugOptions" /t REG_DWORD /d "0x04" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\melonloader.exe" /v "FrontEndHeapDebugOptions" /t REG_DWORD /d "0x04" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\boneworks.exe" /v "FrontEndHeapDebugOptions" /t REG_DWORD /d "0x04" /f

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\boneworks.exe" /v "RobloxPlayerBeta.exe" /t REG_DWORD /d "0x04" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\boneworks.exe" /v "WhoCrashedEx.exe" /t REG_DWORD /d "0x04" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\vrmonitor.exe" /v "FrontEndHeapDebugOptions" /t REG_DWORD /d "0x04" /f
echo Done!
pause
goto Menu

:EnableWindowsSegmentHeap
cls
color b
echo Downloading Segment Heap Manager.
echo CLICK ENABLE
md %UserProfile%\Desktop\OptiClub\SegmentHeapManager\

PowerShell Invoke-WebRequest "https://raw.githubusercontent.com/ZaneLS/MSI_UTIL_V3/refs/heads/main/SegmentHeapManagerv2.6.1.ps1" -OutFile "%UserProfile%\Desktop\OptiClub\SegmentHeapManager\SegmentHeapManagerv2.6.1.ps1"
powershell.exe -File "%UserProfile%\Desktop\OptiClub\SegmentHeapManager\SegmentHeapManagerv2.6.1.ps1" 
timeout /t 1 /nobreak > NUL

goto IncmptblPpsWdnSgmntHpStstd

:DisableWindowsSegmentHeap
cls
color b
echo Disabling Windows Segment Heap (Default value)
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Segment Heap" /v "Enabled" /t REG_DWORD /d "0" /f
echo CLICK DISABLE
PowerShell Invoke-WebRequest "https://raw.githubusercontent.com/ZaneLS/MSI_UTIL_V3/refs/heads/main/SegmentHeapManagerv2.6.1.ps1" -OutFile "%UserProfile%\Desktop\OptiClub\SegmentHeapManager\SegmentHeapManagerv2.6.1.ps1"
powershell.exe -File "%UserProfile%\Desktop\OptiClub\SegmentHeapManager\SegmentHeapManagerv2.6.1.ps1" 
echo Done!
pause
goto Menu


:PerAppsWindowsSegmentHeap
color b
cls
echo Downloading Windows Segment Heap Manager
PowerShell Invoke-WebRequest "https://raw.githubusercontent.com/ZaneLS/MSI_UTIL_V3/refs/heads/main/SegmentHeapNano.ps1" -OutFile "%UserProfile%\Desktop\OptiClub\SegmentHeapManager\SegmentHeapNano.ps1"
powershell.exe -File "%UserProfile%\Desktop\OptiClub\SegmentHeapManager\SegmentHeapNano.ps1" 
echo Done!
pause
goto Menu