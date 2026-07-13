@echo off

set "ADB=.\pt\adb.exe"
set "APK_PATH=.\app\eagle.apk"
set "PACKAGE_NAME=com.eagle.darshni"
set "ACTIVITY=com.godot.game.GodotApp"

echo Installing APK...
%ADB% install -r "%APK_PATH%"

if errorlevel 1 (
    echo Installation failed.
    pause
    exit /b
)

echo Closing old app...
%ADB% shell am force-stop %PACKAGE_NAME%

echo Launching app...
%ADB% shell am start -n %PACKAGE_NAME%/%ACTIVITY%

pause