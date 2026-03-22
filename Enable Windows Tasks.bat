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


echo Enabling Tasks
timeout /t 1 /nobreak > NUL
echo Xbox Tasks
timeout /t 1 /nobreak > NUL
schtasks /change /tn "\Microsoft\XblGameSave\XblGameSaveTask" /enable
schtasks /change /tn "\Microsoft\XblGameSave\XblGameSaveTaskLogon" /enable
timeout /t 1 /nobreak > NUL
echo Done!
timeout /t 1 /nobreak > NUL
echo Other Tasks
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /enable
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\BthSQM" /enable
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /enable
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /enable
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Uploader" /enable
schtasks /change /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /enable
schtasks /change /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /enable
schtasks /change /tn "\Microsoft\Windows\Application Experience\StartupAppTask" /enable"
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /enable
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver" /enable
schtasks /change /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /enable
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyMonitor" /enable
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyRefresh" /enable
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyUpload" /enable
schtasks /change /tn "\Microsoft\Windows\Autochk\Proxy" /enable
schtasks /change /tn "\Microsoft\Windows\Maintenance\WinSAT" /enable
schtasks /change /tn "\Microsoft\Windows\Application Experience\AitAgent" /enable
schtasks /change /tn "\Microsoft\Windows\Windows Error Reporting\QueueReporting" /enable
schtasks /change /tn "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /enable
schtasks /change /tn "\Microsoft\Windows\DiskFootprint\Diagnostics" /enable
schtasks /change /tn "\Microsoft\Windows\FileHistory\File History (maintenance mode)" /enable
schtasks /change /tn "\Microsoft\Windows\PI\Sqm-Tasks" /enable
schtasks /change /tn "\Microsoft\Windows\NetTrace\GatherNetworkInfo" /enable
schtasks /change /tn "\Microsoft\Windows\AppID\SmartScreenSpecific" /enable
schtasks /change /tn "\Microsoft\Windows\HelloFace\FODCleanupTask" /enable
schtasks /change /tn "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /enable
schtasks /change /tn "\Microsoft\Windows\Feedback\Siuf\DmClient" /enable
schtasks /change /tn "\Microsoft\Windows\Application Experience\PcaPatchDbTask" /enable
schtasks /change /tn "\Microsoft\Windows\Device Information\Device" /enable
schtasks /change /tn "\Microsoft\Windows\Device Information\Device User" /enable
timeout /t 1 /nobreak > NUL
echo Done!
pause
exit